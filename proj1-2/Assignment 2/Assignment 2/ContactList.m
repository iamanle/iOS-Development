//
//  ContactList.m
//  Assignment 2
//
//  Created by An Le on 9/12/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import "ContactList.h"

@implementation ContactList

@synthesize contactList = contactList;

- (id)init{
    self = [super init];
    if (self){
        contactList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addPerson:(Person *)newContact{
    [contactList addObject:newContact];
}

- (NSArray *)orderedByAge{
    NSArray *sortedAge = [contactList sortedArrayUsingSelector:@selector(yearOld)];
    return sortedAge;
}

- (NSArray *)orderedByName{
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
    NSArray *sortedName =[contactList sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    return sortedName;
}

//Better result with Dictionary
- (NSDictionary *)phoneNumberFor:(NSString *)lastName{
    for(Person *element in contactList){
        if ([[element lastName] isEqualToString:lastName]) {
            return [element phoneNumbers];
        }
    }
    return nil;
}

- (NSString *)nameForNumber:(NSString *)phoneNumber{
    for(Person *element in contactList){
        if ([[[element phoneNumbers] allKeysForObject:phoneNumber] count] > 0){
            return [element description];
        }
    }
    return nil;
}

@end
