//
//  DevicesModel.m
//  DeviceCentral
//
//  Created by Janice Garingo on 10/24/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "DevicesModel.h"

@implementation DevicesModel

- (id)init
{
    if(self = [super init])
    {
        self.entity = @"Device";
        self.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES]];
    }
    
    return self;
}

@end
