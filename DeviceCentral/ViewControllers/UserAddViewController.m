//
//  UserAddViewController.m
//  DeviceCentral
//
//  Created by Janice Garingo on 10/31/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "UserAddViewController.h"

@interface UserAddViewController ()

@end

@implementation UserAddViewController


- (IBAction)cancelButtonDidSelect:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)doneButtonDidSelect:(id)sender
{
    if([self.nameTextField.text isEqualToString:@""])
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }else if(![self validateEmail: self.emailtextField.text]){
        
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }else{
        UsersModel *usersModel = [UsersModel new];
        User *user = (User*)[usersModel newObject];
        user.name = self.nameTextField.text;
        user.email = self.emailtextField.text;
        [usersModel saveContext];
        
        NSLog(@"Added user : %@ " , self.nameTextField.text);

        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }
}


- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

@end
