//
//  AS4WebViewController.m
//  Assignment4
//
//  Created by An Le on 10/18/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import "AS4WebViewController.h"

@interface AS4WebViewController ()

@end

@implementation AS4WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *urlString = @"http://www.google.com";
    NSURL *url  = [NSURL URLWithString:urlString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)visitWebPage:(id)sender {
    [self request];
}

- (void)request{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", @"http://", self.textField.text];
    NSURL *url  = [NSURL URLWithString:urlString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    [self.textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.textField) {
        [self request];
        return NO;
    }
    return YES;
}

@end
