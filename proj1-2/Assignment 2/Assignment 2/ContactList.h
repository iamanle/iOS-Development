//
//  ContactList.h
//  Assignment 2
//
//  Created by An Le on 9/12/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface ContactList : NSObject{
    NSMutableArray *contactList;
}


@property NSMutableArray *contactList;
- (id)init;

//Add a Person object to the list
- (void)addPerson:(Person *)newContact;

//Returns an NSArray of all your contacts ordered by age, from youngest to oldest.
- (NSArray *)orderedByAge;

//Returns an NSArray of all your contacts ordered by last name.
- (NSArray *)orderedByName;

//Given the lastName return phone numbers for the first person in the list that has that last name. Return an empty array if no such person exists.
- (NSDictionary *)phoneNumberFor:(NSString *)lastName;

//Return the full name of the person with the given phone number. Return nil if no one has the phone number.
- (NSString *)nameForNumber:(NSString *)phoneNumber;

@end
