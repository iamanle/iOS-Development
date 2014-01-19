//
//  ChatRoomViewController.h
//  ShyStudent
//
//  Created by An Le on 11/23/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "chatCell.h"
#import "Reachability.h"

@interface ChatRoomViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, PF_EGORefreshTableHeaderDelegate>{
    UITextField *tfEntry;
    IBOutlet UITableView *chatTable;
    NSMutableArray *chatData;
    PF_EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    NSString *className;
    NSString *userName;
}

@property (nonatomic, strong) IBOutlet UITextField *tfEntry;
@property (nonatomic, retain) UITableView *chatTable;
@property (nonatomic, retain) NSArray *chatData;

- (IBAction)changeNameButton:(id)sender;

-(void) registerForKeyboardNotifications;
-(void) freeKeyboardNotifications;
-(void) keyboardWasShown:(NSNotification*)aNotification;
-(void) keyboardWillHide:(NSNotification*)aNotification;
-(void) loadLocalChat;
- (NSString *)stringFromStatus:(NetworkStatus )status;
-(void)presentChatNameDialog;
@end
