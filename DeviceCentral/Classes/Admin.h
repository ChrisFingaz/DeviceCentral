//
//  Admin.h
//  DeviceCentral
//
//  Created by Janice Garingo on 10/31/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Admin : NSObject

+(BOOL)hasPasscode;
+(BOOL)isLoggedIn;
+(void)savePasscode:(NSString *)passcode;
+(void)loginWithPasscode:(NSString*)passcode;
+(BOOL)validatePasscode:(NSString*)passcode;

@end
