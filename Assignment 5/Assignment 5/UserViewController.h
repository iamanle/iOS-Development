//
//  UserViewController.h
//  Assignment 5
//
//  Created by An Le on 11/11/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UITableViewController<NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSMutableArray *arrayUserName;
@property (nonatomic, strong) NSMutableArray *arrayUserID;
@property (nonatomic,strong) NSMutableData *webData;
@property (nonatomic, strong) NSURLConnection *connection;

- (void)connectDatabase;
@end
