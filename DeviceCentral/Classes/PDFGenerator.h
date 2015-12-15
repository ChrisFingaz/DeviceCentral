//
//  PDFGenerator.h
//  DeviceCentral
//
//  Created by Oli Griffiths on 07/11/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFGenerator : NSObject

@property (nonatomic) CGFloat margin;
@property (nonatomic, readonly) NSArray *devices;

+(NSData*)generateWithDevices:(NSArray*)devices;

-(id)initWithDevices:(NSArray*)devices;

-(NSData*)generate;

@end
