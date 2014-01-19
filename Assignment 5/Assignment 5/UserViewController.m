//
//  UserViewController.m
//  Assignment 5
//
//  Created by An Le on 11/11/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

// -----------------------------Note--------------------------------
// I'm be able to save user and photo list, but only 1 photo list of the last looked up user.
// I tested on my actual iphone. I don't know how to turn off wifi on iPhone Simulator.
// Even when wifi connection of my laptop is turn off, iphone simulator still assumes that
// there is wifi connection.
// Check signal using Reachability package download from Apple website: https://developer.apple.com/Library/ios/samplecode/Reachability/Introduction/Intro.html


#import "UserViewController.h"
#import "UserViewCell.h"
#import "PhotoListViewController.h"
#include "Reachability.h"

@interface UserViewController (){
}

@end

@implementation UserViewController

// Pass values to PhotoList ViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"ShowPhotoList"]) {
        PhotoListViewController *photoListViewController = [segue destinationViewController];
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [myIndexPath row];
        
        photoListViewController.userID = _arrayUserID[row];
        photoListViewController.userName = _arrayUserName[row];
        
    }
}

- (void)connectDatabase{
    NSURL *url = [NSURL URLWithString:@"http://bismarck.sdsu.edu/photoserver/userlist"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _arrayUserName = [[NSMutableArray alloc] init];
    _arrayUserID = [[NSMutableArray alloc] init];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (_connection) {
        _webData = [[NSMutableData alloc] init];
    } else {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail To Connect To Database"
                                                        message:@"Please try again later"
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    // Load the UserID and UserName if there is no connection.
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _arrayUserID = [defaults objectForKey:@"restoreUserID"];
        _arrayUserName = [defaults objectForKey:@"restoreUserName"];
    }
    

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self connectDatabase];

}


#pragma mark - Connection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_webData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSArray *allDataArray = [NSJSONSerialization JSONObjectWithData:_webData options:0 error:nil];
    
   
    for (NSDictionary *diction in allDataArray) {
        NSString *name = [diction objectForKey:@"name"];
        NSString *userID = [diction objectForKey:@"id"];
        
        [_arrayUserName addObject:name];
        [_arrayUserID addObject:userID];

    }
    
    //Save current values to load if there is no internet connection
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_arrayUserName forKey:@"restoreUserName"];
    [defaults setObject:_arrayUserID forKey:@"restoreUserID"];
    [defaults synchronize];
    NSLog(@"Data saved");
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayUserID.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"userTableCell";
    UserViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure cells
    long row = [indexPath row];
    cell.userName.text = _arrayUserName[row];
    return cell;
}

@end
