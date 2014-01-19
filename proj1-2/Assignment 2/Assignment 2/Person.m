//
//  Person.m
//  Assignment 2
//
//  Created by An Le on 9/6/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import "Person.h"
#import "NSDate+CurrentUTCDate.h"

@implementation Person

@synthesize firstName = firstName;
@synthesize lastName = lastName;
@synthesize birthDay = birthDay;
@synthesize phoneNumbers = phoneNumbers;
@synthesize yearOld = yearOld;


+ (id)firstName:(NSString *)firstName lastName:(NSString *)lastName birthday:(NSString *)birthday{
    Person *person = [[Person alloc] init];
    [person setFirstName:firstName];
    [person setLastName:lastName];
    [person setBirthDay:birthday];
    
    //Calculate age for this person and init his own phoneNumber dictionary.
    [person setYearOld:[person age]];
    [person initPhoneNumbers];
    return person;
}

- (void)initPhoneNumbers{
    phoneNumbers = [[NSMutableDictionary alloc] init];
}

- (NSInteger)age{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSDate *dob = [dateFormat dateFromString:birthDay];
    return [[NSDate alloc] yearsBetween:dob];
}

- (void)setPhoneNumber:(NSString *)number type:(NSString *)phoneType{
    
    if ([phoneType isEqualToString:PHONE_TYPE_CELL]) {
        [phoneNumbers setValue:number forKey:PHONE_TYPE_CELL];
    }
    
    if ([phoneType isEqualToString:PHONE_TYPE_MOBILE]) {
        [phoneNumbers setValue:number forKey:PHONE_TYPE_MOBILE];
        
        //phoneNumbers = @{number: PHONE_TYPE_MOBILE};
        //Does not work for NSMutableDictionary??
    }
    
    if ([phoneType isEqualToString:PHONE_TYPE_HOME]) {
        [phoneNumbers setValue:number forKey:PHONE_TYPE_HOME];
    }
    
    if ([phoneType isEqualToString:PHONE_TYPE_WORK]) {
        [phoneNumbers setValue:number forKey:PHONE_TYPE_WORK];
    }
    
    if ([phoneType isEqualToString:PHONE_TYPE_OTHER]) {
        [phoneNumbers setValue:number forKey:PHONE_TYPE_OTHER];
    }
}

- (NSString *)description{
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    return fullName;
}

- (NSString *)phoneNumber:(NSString *)phoneType{
    return [phoneNumbers valueForKey:phoneType];

}

- (BOOL)hasNumber:(NSString *)phoneNumber{
    if ([[phoneNumbers allKeysForObject:phoneNumber] count] > 0) {
        return true;
    } else
        return false;
}

@end
