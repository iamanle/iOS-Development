//
//  main.m
//  Assignment 2
//
//  Created by An Le on 9/5/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//  ID: 815892617

#import <Foundation/Foundation.h>
#import "NSString+DateConverter.h"
#import "NSDate+CurrentUTCDate.h"
#import "Person.h"
#import "ContactList.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
//Question 1:
        NSDate *date =[[NSString alloc] asDate:@"09/26/2013"];
        //I really have no idea how to output a NSDate to the format you assigned. The only way I can do is converting it back to String:
        if (date) {
            NSDateFormatter *date_format = [[NSDateFormatter alloc] init];
            [date_format setDateFormat:@"E, MMMM d, yyyy"];
            NSLog(@"Question 1: %@", [date_format stringFromDate:date]);
        };
        
//Question 2:
        NSLog(@"Question 2: Current time: %@", [[NSDate alloc] now]);
        
//Question 3:
        //Even though the name of category is CurrentUTCDate, I updated the method to return the current time of user's system timezone.
        NSLog(@"Question 3: The time interval between input date and now is %ld years",
              [[NSDate alloc] yearsBetween:date]);
        
//Question 4:
        NSLog(@"Question 4: ");
        
        Person *person = [Person firstName:@"An" lastName:@"Le" birthday:@"09/26/1991"];
        
        NSLog(@"This person full name: %@", [person description]);
        
        NSLog(@"This person age: %ld", (long)[person age]);
        
        [person setPhoneNumber:@"222-222-2222" type:@"cell"];
        [person setPhoneNumber:@"123-456-7890" type:@"work"];
        
        NSLog(@"This person cell phone: %@", [person phoneNumber:@"cell"]);
        NSLog(@"This person work phone: %@", [person phoneNumber:@"work"]);
        //Check if the method returns null
        NSLog(@"This person home phone: %@", [person phoneNumber:@"home"]); 
        
        //222-222-2222 (cell) exists,111-111-1111 does not.
        NSLog(@"Does this person has 222-222-2222 number? %@", [person hasNumber:@"222-222-2222"] ? @"Yes" : @"No");
        NSLog(@"Does this person has 111-111-1111 number? %@", [person hasNumber:@"111-111-1111"] ? @"Yes" : @"No");

//Question 5:
        NSLog(@"Question 5:");
        
        //Create 2 more people and a cell phone number for each.
        Person *person2 = [Person firstName:@"Paul" lastName:@"Hazen" birthday:@"09/26/1992"];
        //Paul has same cell number as An.
        [person2 setPhoneNumber:@"222-222-2222" type:@"cell"];
        Person *person3 = [Person firstName:@"Alex" lastName:@"K" birthday:@"09/26/1993"];
        [person3 setPhoneNumber:@"333-333-3333" type:@"cell"];
        
        //Add 3 people including An in quesiton 4 to myContactList.
        ContactList *myContactList = [[ContactList alloc] init];
        [myContactList addPerson:person];
        [myContactList addPerson:person2];
        [myContactList addPerson:person3];
        
        //Age: Le 21, Hazen 20, K 19.
        NSLog(@"Sorted by age (younger to older): %@", [myContactList orderedByAge]);
        
        //Alphabetical order: H,K,L.
        NSLog(@"Sorted by last name: %@", [myContactList orderedByName]);
        
        //I think NSDictionary gives a better result with specific types of phone number.
        NSLog(@"All phone numbers of Le: %@", [myContactList phoneNumberFor:@"Le"]);
        
        //222-222-2222 is An and Paul' cell. 111-111-1111 doesn't exists.
        NSLog(@"The first person with phone number 222-222-2222: %@", [myContactList nameForNumber:@"222-222-2222"]);
        NSLog(@"The first person with phone number 111-111-1111: %@", [myContactList nameForNumber:@"111-111-1111"]);
    }
    return 0;
}

