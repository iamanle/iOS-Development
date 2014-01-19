//
//  AS4SportsViewController.m
//  Assignment4
//
//  Created by An Le on 10/18/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import "AS4SportsViewController.h"

@interface AS4SportsViewController ()

@end

@implementation AS4SportsViewController

- (IBAction)slideSport:(UISlider *)sender{
    sender.continuous = YES;
    int chooseSport = roundf(sender.value);
    [self.dependentPicker selectRow:chooseSport inComponent:kSportComponent animated:YES];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component == kSportComponent) {
        return 200;
    }else {
        return 90;
    }
}

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
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"sport" withExtension:@"plist"];
    self.countrySport = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    NSArray *allCountries = [self.countrySport allKeys];
    NSArray *sortedCountries = [allCountries sortedArrayUsingSelector:@selector(compare:)];
    self.country = sortedCountries;
    NSString *selectedCountry = self.country[0];
    self.sport = self.countrySport[selectedCountry];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == kCountryComponent) {
        return [self.country count];
    } else {
        return [self.sport count];
    }
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == kCountryComponent) {
        return self.country[row];
    } else {
        return self.sport[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == kCountryComponent) {
        NSString *selecetedCountry = self.country[row];
        self.sport = self.countrySport[selecetedCountry];
        [self.dependentPicker reloadComponent:kSportComponent];
        [self.dependentPicker selectRow:0 inComponent:kSportComponent animated:YES];
        [self.sportSlider setValue:0 animated:YES];
    }
    
    if (component == kSportComponent) {
        [self.sportSlider setValue:row animated:YES];
    }
}
@end
