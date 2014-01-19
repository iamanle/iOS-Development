//
//  PhotoViewController.h
//  Assignment 5
//
//  Created by An Le on 11/12/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController <NSURLConnectionDataDelegate>
@property (nonatomic,strong) NSMutableData *webData;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic,strong) NSMutableArray *arrayPhotoView;
@property (nonatomic, strong) NSMutableArray *photoName;
@property (nonatomic,strong) NSData *photoData;
@property NSInteger index;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
- (IBAction)savePhoto:(id)sender;

- (void)connectDatabase;

- (IBAction)swipeRight:(id)sender;

- (IBAction)swipeLeft:(id)sender;
@end
