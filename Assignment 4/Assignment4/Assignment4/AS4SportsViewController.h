//
//  AS4SportsViewController.h
//  Assignment4
//
//  Created by An Le on 10/18/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCountryComponent 0
#define kSportComponent 1

@interface AS4SportsViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *dependentPicker;
@property (strong, nonatomic) IBOutlet UISlider *sportSlider;
@property (strong, nonatomic) NSDictionary *countrySport;
@property (strong, nonatomic) NSArray *country;
@property (strong, nonatomic) NSArray *sport;

- (IBAction)slideSport:(UISlider *)sender;

@end
