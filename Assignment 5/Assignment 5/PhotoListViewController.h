//
//  PhotoListViewController.h
//  Assignment 5
//
//  Created by An Le on 11/11/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoListViewController : UITableViewController<NSURLConnectionDataDelegate>

@property  (nonatomic) NSString *userID;
@property (strong, nonatomic) NSMutableArray *arrayPhotoName;
@property (strong, nonatomic) NSMutableArray *arrayPhotoID;
@property (nonatomic,strong) NSMutableData *webData;
@property (nonatomic, strong) NSURLConnection *connection;
@property  (nonatomic, strong) NSString *userName;

- (void)connectDatabase;
@end
