//
//  HistoryModel.m
//  DeviceCentral
//
//  Created by Janice Garingo on 10/24/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel

-(id)init
{
    if(self = [super init])
    {
        self.entity = @"History";
        self.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"checkedOutDate" ascending:NO]];
    }
    
    return self;
}

@end
