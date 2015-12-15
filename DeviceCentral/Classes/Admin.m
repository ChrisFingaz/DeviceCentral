//
//  Admin.m
//  DeviceCentral
//
//  Created by Janice Garingo on 10/31/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "Admin.h"

@implementation Admin


+(BOOL)isLoggedIn
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"isAdmin"] ? YES : NO;
}


+(BOOL)hasPasscode
{
    return [self passcode] ? YES : NO;
}


+(NSString *)passcode
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"passcode"];
}


+(void)savePasscode:(NSString *)passcode
{
    NSLog(@"Admin passcode saved : %@", passcode);
    [[NSUserDefaults standardUserDefaults] setObject:passcode forKey:@"passcode"];
}


+(void)loginWithPasscode:(NSString*)passcode
{
    if([self validatePasscode:passcode]){
        NSLog(@"Admin logged in");
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"isAdmin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


+(BOOL)validatePasscode:(NSString*)passcode
{
    return [self hasPasscode] && [[self passcode] isEqualToString:passcode];
}

@end
