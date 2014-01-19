//
//  Person.h
//  Assignment 2
//
//  Created by An Le on 9/6/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const PHONE_TYPE_CELL = @"cell";
static NSString* const PHONE_TYPE_MOBILE = @"mobile";
static NSString* const PHONE_TYPE_HOME = @"home";
static NSString* const PHONE_TYPE_WORK = @"work";
static NSString* const PHONE_TYPE_OTHER = @"other";

@interface Person : NSObject

@property NSString *firstName;
@property NSString *lastName;
@property NSString *birthDay;
@property NSMutableDictionary *phoneNumbers;
@property NSInteger yearOld;

//Creates a new Person obj with given data.
+ (id)firstName:(NSString *)firstName lastName:(NSString *)lastName birthday:(NSString *)birthday;

//Returns the age of person in years.
- (NSInteger)age;

//Add a phone number of a given type
- (void)setPhoneNumber:(NSString *)number type:(NSString *)phoneType;

//Returns full name of the person.
- (NSString *)description;

//Returns the person phone number of the given type. Or nil if number does not exist.
- (NSString *)phoneNumber:(NSString *)phoneType;

//Returns true if person has given phoneNumber.
- (BOOL)hasNumber:(NSString *)phoneNumber;

@end
