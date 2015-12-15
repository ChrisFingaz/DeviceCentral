//
//  UIView+Shadow.h
//  AIG CyberEdge
//
//  Created by Oli on 21/08/2013.
//  Copyright (c) 2013 Oli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Shadow)

-(void)addShadowWithOpacity: (float) opacity leftOffset: (CGFloat) x topOffset: (CGFloat) y withRadius: (CGFloat) radius;

@end
