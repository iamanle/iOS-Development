//
//  PhotoViewController.m
//  Assignment 5
//
//  Created by An Le on 11/12/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (IBAction)savePhoto:(id)sender {
    // Save to Photo Album (I prefer this)
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:_photoData], nil, nil, nil);
    
    // Save to a specific location
//    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSLog(@"%@",docDir);
//    NSLog(@"saving jpeg");
//    NSString *photNameWithEx = [_photoName[_index] stringByAppendingString:@".jpeg"];
//    NSString *jpegFilePath = [NSString stringWithFormat:@"%@/%@",docDir, photNameWithEx];
//	NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation([UIImage imageWithData:_photoData], 1.0f)];//1.0f = 100% quality
//	[data2 writeToFile:jpegFilePath atomically:YES];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ saved in documents", _photoName[_index]]
//                                                    message:nil
//                                                   delegate:nil
//                                          cancelButtonTitle:@"Ok"
//                                          otherButtonTitles:nil];
//    [alert show];
    
	NSLog(@"saving image done");
}

- (void)connectDatabase{
    NSString *realPhotoURL = @"http://bismarck.sdsu.edu/photoserver/photo/";
    realPhotoURL = [realPhotoURL stringByAppendingString:_arrayPhotoView[_index]];

    NSURL *url = [NSURL URLWithString:realPhotoURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self connectDatabase];
    self.title = _photoName[_index];
    
}

#pragma mark - Swipe Action

- (IBAction)swipeRight:(id)sender {
    if (_index > 0) {
        NSString *realPhotoURL = @"http://bismarck.sdsu.edu/photoserver/photo/";
        realPhotoURL = [realPhotoURL stringByAppendingString:_arrayPhotoView[--_index]];
        
        NSURL *url = [NSURL URLWithString:realPhotoURL];
        _photoData = [[NSData alloc] initWithContentsOfURL:url];
        _photoView.image = [UIImage imageWithData:_photoData];
        self.title = _photoName[_index];
    }
    
}

- (IBAction)swipeLeft:(id)sender {

    if (_index < _arrayPhotoView.count - 1) {
        NSString *realPhotoURL = @"http://bismarck.sdsu.edu/photoserver/photo/";
        realPhotoURL = [realPhotoURL stringByAppendingString:_arrayPhotoView[++_index]];
        
        NSURL *url = [NSURL URLWithString:realPhotoURL];
        _photoData = [[NSData alloc] initWithContentsOfURL:url];
        _photoView.image = [UIImage imageWithData:_photoData];
        self.title = _photoName[_index];
    }
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
    _photoData = _webData;
    _photoView.image = [UIImage imageWithData:_webData];

}





@end
