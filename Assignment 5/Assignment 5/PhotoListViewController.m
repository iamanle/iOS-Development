//
//  PhotoListViewController.m
//  Assignment 5
//
//  Created by An Le on 11/11/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import "PhotoListViewController.h"
#import "PhotoListViewCell.h"
#import "PhotoViewController.h"
#include "Reachability.h"

@interface PhotoListViewController ()

@end

@implementation PhotoListViewController

// Pass values to PhotoViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showImage"]) {
        
        PhotoViewController *photoView = [segue destinationViewController];
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [myIndexPath row];
        
        photoView.arrayPhotoView = _arrayPhotoID;
        photoView.index = row;
        photoView.photoName = _arrayPhotoName;
    }
}

- (void)connectDatabase{
    NSString *photoURL = @"http://bismarck.sdsu.edu/photoserver/userphotos/";
    photoURL = [photoURL stringByAppendingString:_userID];
    NSURL *url = [NSURL URLWithString:photoURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _arrayPhotoName = [[NSMutableArray alloc] init];
    _arrayPhotoID = [[NSMutableArray alloc] init];
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
    
    // Load the Photo Name List if there is no connection.
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable){
        NSLog(@"There IS NO internet connection");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _arrayPhotoName = [defaults objectForKey:@"restorePhotoName"];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _userName;
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
        NSString *photoName = [diction objectForKey:@"name"];
        NSString *photoID = [diction objectForKey:@"id"];
        
        [_arrayPhotoName addObject:photoName];
        [_arrayPhotoID addObject:photoID];
        
    }
    
    //Save current values to load if there is no internet connection
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_arrayPhotoName forKey:@"restorePhotoName"];
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
    return _arrayPhotoName.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"photoListCell";
    PhotoListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    long row = [indexPath row];

    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable){
        cell.imageNameLabel.text = _arrayPhotoName[row];
    }
    else{
        cell.imageNameLabel.text = _arrayPhotoName[row];
        
        // Try
//        NSString *realPhotoURL = @"http://bismarck.sdsu.edu/photoserver/photo/";
//        realPhotoURL = [realPhotoURL stringByAppendingString:_arrayPhotoID[row]];
//        NSURL *url = [NSURL URLWithString:realPhotoURL];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//        [NSURLConnection
//         sendAsynchronousRequest:urlRequest
//         queue:queue
//         completionHandler:^(NSURLResponse *response,
//                             NSData *data,
//                             NSError *error) {
//             if ([data length] >0 && error == nil){
//                 cell.imageViewLabel.image = [UIImage imageWithData:data];
//                 
//             }
//             else if ([data length] == 0 && error == nil){
//                 NSLog(@"Nothing was downloaded.");
//             }
//             else if (error != nil){
//                 NSLog(@"Error happened = %@", error);
//             } }];
        
        
        // Set Thumbnails
        NSString *realPhotoURL = @"http://bismarck.sdsu.edu/photoserver/photo/";
        realPhotoURL = [realPhotoURL stringByAppendingString:_arrayPhotoID[row]];
        NSURL *url = [NSURL URLWithString:realPhotoURL];
        NSData *thumbnail = [[NSData alloc] initWithContentsOfURL:url];
        cell.imageViewLabel.image = [UIImage imageWithData:thumbnail];
    }
    return cell;
}


@end
