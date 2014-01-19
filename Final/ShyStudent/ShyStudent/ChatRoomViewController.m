//
//  ChatRoomViewController.m
//  ShyStudent
//
//  Created by An Le on 11/23/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import "ChatRoomViewController.h"
#define TABBAR_HEIGHT 49.0f
#define TEXTFIELD_HEIGHT 70.0f
#define MAX_ENTRIES_LOADED 25

@interface ChatRoomViewController ()

@end

@implementation ChatRoomViewController
@synthesize tfEntry;
@synthesize chatTable;
@synthesize chatData;

BOOL isShowingAlertView = NO;
BOOL isFirstShown = YES;
// -----------------------------Change Name button-----------------------
- (IBAction)changeNameButton:(id)sender{
    [self presentChatNameDialog];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// -----------------------------App Init-----------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    tfEntry.delegate = self;
    tfEntry.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self registerForKeyboardNotifications];
    
    // Subscribe to Push Channel
    [PFPush subscribeToChannelInBackground:@"ios"];
    
    if (_refreshHeaderView == nil) {
		
		PF_EGORefreshTableHeaderView *view = [[PF_EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - chatTable.bounds.size.height, self.view.frame.size.width, chatTable.bounds.size.height)];
		view.delegate = self;
		[chatTable addSubview:view];
		_refreshHeaderView = view;
	}
	//  update date
	[_refreshHeaderView refreshLastUpdatedDate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Reachability *reach = [Reachability reachabilityForInternetConnection];
	NetworkStatus status = [reach currentReachabilityStatus];
	if (status == NotReachable){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network"
														message:[self stringFromStatus: status]
													   delegate:self
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
	}
    className = @"chatroom";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    userName = [defaults stringForKey:@"chatName"];
    if ([userName isEqualToString:@"Chat Name"]) {
        [self presentChatNameDialog];
    }
    chatData  = [[NSMutableArray alloc] init];
    [self loadLocalChat];
}



#pragma mark - Textfield for Chat
// -----------------------------Methods for Chat textfield and Keyboard-----------------------
-(IBAction) textFieldDoneEditing : (id) sender
{
    NSLog(@"the text content%@",tfEntry.text);
    [sender resignFirstResponder];
    [tfEntry resignFirstResponder];
    
    
}

-(IBAction) backgroundTap:(id) sender
{
    [self.tfEntry resignFirstResponder];
}


// -----------------------------When Text Filed Return, Send Push Message Here-----------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"the text content%@",tfEntry.text);
    [textField resignFirstResponder];
    
    
    
    if (tfEntry.text.length>0) {
        
        // Push to subcribed channel
        [PFPush sendPushMessageToChannelInBackground:@"ios" withMessage:tfEntry.text];
        
        // Update table
        NSArray *keys = [NSArray arrayWithObjects:@"text", @"userName", @"date", nil];
        NSArray *objects = [NSArray arrayWithObjects:tfEntry.text, userName, [NSDate date], nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [chatData addObject:dictionary];
        
        NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [insertIndexPaths addObject:newPath];
        [chatTable beginUpdates];
        [chatTable insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
        [chatTable endUpdates];
        [chatTable reloadData];
        
        // Set object
        PFObject *newMessage = [PFObject objectWithClassName:@"chatroom"];
        [newMessage setObject:tfEntry.text forKey:@"text"];
        [newMessage setObject:userName forKey:@"userName"];
        [newMessage setObject:[NSDate date] forKey:@"date"];
        [newMessage saveInBackground];
        tfEntry.text = @"";
    }
    
    [self loadLocalChat];
    return NO;
}


-(void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


-(void) freeKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


-(void) keyboardWasShown:(NSNotification*)aNotification
{
    NSLog(@"Keyboard was shown");
    NSDictionary* info = [aNotification userInfo];
    
    // Get animation info from userInfo
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    // Move keyboard when return pressed
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    NSLog(@"frame..%f..%f..%f..%f",self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    NSLog(@"keyboard..%f..%f..%f..%f",keyboardFrame.origin.x, keyboardFrame.origin.y, keyboardFrame.size.width, keyboardFrame.size.height);
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y- keyboardFrame.size.height+TABBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height)];
    [chatTable setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+ keyboardFrame.size.height+TABBAR_HEIGHT+TEXTFIELD_HEIGHT, self.view.frame.size.width, self.view.frame.size.height-keyboardFrame.size.height)];
    [chatTable scrollsToTop];
    [UIView commitAnimations];
    
}

-(void) keyboardWillHide:(NSNotification*)aNotification
{
    NSLog(@"Keyboard will hide");
    NSDictionary* info = [aNotification userInfo];
    
    // Get animation info from userInfo
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    // Move
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + keyboardFrame.size.height-TABBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height)];
    [chatTable setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-TABBAR_HEIGHT)];
    [UIView commitAnimations];
}

#pragma mark - Parse
// -----------------------------Send to Parse-----------------------
- (void)loadLocalChat
{
    PFQuery *query = [PFQuery queryWithClassName:className];
    // Get data from cache
    if ([chatData count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        [query orderByAscending:@"createdAt"];
        NSLog(@"Trying to retrieve from cache");
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %d chats from cache.", objects.count);
                [chatData removeAllObjects];
                [chatData addObjectsFromArray:objects];
                [chatTable reloadData];
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    __block int totalNumberOfEntries = 0;
    [query orderByAscending:@"createdAt"];
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (!error) {
            // Get count request to load data
            NSLog(@"There are currently %d entries", number);
            totalNumberOfEntries = number;
            if (totalNumberOfEntries > [chatData count]) {
                NSLog(@"Retrieving data");
                int theLimit;
                if (totalNumberOfEntries-[chatData count]>MAX_ENTRIES_LOADED) {
                    theLimit = MAX_ENTRIES_LOADED;
                }
                else {
                    theLimit = totalNumberOfEntries-[chatData count];
                }
                query.limit = [NSNumber numberWithInt:theLimit];
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        // The find succeeded.
                        NSLog(@"Successfully retrieved %d chats.", objects.count);
                        [chatData addObjectsFromArray:objects];
                        NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
                        for (int ind = 0; ind < objects.count; ind++) {
                            NSIndexPath *newPath = [NSIndexPath indexPathForRow:ind inSection:0];
                            [insertIndexPaths addObject:newPath];
                        }
                        [chatTable beginUpdates];
                        [chatTable insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
                        [chatTable endUpdates];
                        [chatTable reloadData];
                        [chatTable scrollsToTop];
                    } else {
                        // Log details of the failure
                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                    }
                }];
            }
            
        } else {
            // The request failed, we'll keep the chatData count?
            number = [chatData count];
        }
    }];
}


#pragma mark - Table view delegate
// -----------------------------Methods to change Table Display-----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [chatData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	chatCell *cell = (chatCell *)[tableView dequeueReusableCellWithIdentifier: @"chatCellIdentifier"];
	NSUInteger row = [chatData count]-[indexPath row]-1;
    
    if (row < chatData.count){
        NSString *chatText = [[chatData objectAtIndex:row] objectForKey:@"text"];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        UIFont *font = [UIFont systemFontOfSize:14];
        CGSize size = [chatText sizeWithFont:font constrainedToSize:CGSizeMake(225.0f, 1000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
        cell.textString.frame = CGRectMake(75, 14, size.width +20, size.height + 20);
        cell.textString.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        cell.textString.text = chatText;
        [cell.textString sizeToFit];
        
        NSDate *theDate = [[chatData objectAtIndex:row] objectForKey:@"date"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm a"];
        NSString *timeString = [formatter stringFromDate:theDate];
        cell.timeLabel.text = timeString;
        
        cell.userLabel.text = [[chatData objectAtIndex:row] objectForKey:@"userName"];
    }
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [[chatData objectAtIndex:chatData.count-indexPath.row-1] objectForKey:@"text"];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:14.0];
    CGSize constraintSize = CGSizeMake(225.0f, MAXFLOAT);
    //depricated
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height + 40;
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	_reloading = YES;
    [self loadLocalChat];
	[chatTable reloadData];
}

- (void)doneLoadingTableViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:chatTable];
	
}


#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark EGORefreshTableHeaderDelegate Methods
// -----------------------------Refresh Button-----------------------
- (void)egoRefreshTableHeaderDidTriggerRefresh:(PF_EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(PF_EGORefreshTableHeaderView*)view{
    // should return if data source model is reloading
	return _reloading;
    
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(PF_EGORefreshTableHeaderView*)view{
	// should return date data source was last changed
	return [NSDate date];
}

#pragma mark - Connections
// -----------------------------Check if there is Internet Connection-----------------------
- (NSString *)stringFromStatus:(NetworkStatus ) status {
	NSString *string; switch(status) {
		case NotReachable:
			string = @"You are not connected to the internet";
			break;
		case ReachableViaWiFi:
			string = @"Reachable via WiFi";
			break;
		case ReachableViaWWAN:
			string = @"Reachable via WWAN";
			break;
		default:
            string = @"Unknown connection";
            break;
	}
	return string;
}

#pragma mark - Chat name dialog
// -----------------------------Change Chat Name-----------------------
-(void)presentChatNameDialog
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Chat Name"
                                                      message:@"Enter your chat name"
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Continue", nil];
    
    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [message show];
    isShowingAlertView = YES;
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Alert View dismissed with button at index %d",buttonIndex);
    if (buttonIndex != 0) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        NSLog(@"Plain text input: %@",textField.text);
        userName = textField.text;
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"chatName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        isShowingAlertView = NO;
    }
    else if (isFirstShown){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Ooops"
                              message:@"Please enter your chat name!"
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"Dismiss", nil];
        [alert show];
        isFirstShown = NO;
    }
    [chatTable setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-TABBAR_HEIGHT)];
}


@end
