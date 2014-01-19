//
//  AS4WebViewController.h
//  Assignment4
//
//  Created by An Le on 10/18/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AS4WebViewController : UIViewController
<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)visitWebPage:(id)sender;

@end
