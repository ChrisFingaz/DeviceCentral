//
//  UserModel.m
//  DeviceCentral
//
//  Created by Janice Garingo on 10/24/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "UsersModel.h"

@implementation UsersModel

- (id)init
{
    if(self = [super init])
    {
        self.entity = @"User";
        self.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES]];        
    }
    
    return self;
}

@end
