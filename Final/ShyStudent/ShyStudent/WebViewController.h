//
//  WebViewController.h
//  ShyStudent
//
//  Created by An Le on 11/24/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)visitWebPage:(id)sender;

@end
