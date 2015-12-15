//
//  UIView+Shadow.m
//  AIG CyberEdge
//
//  Created by Oli on 21/08/2013.
//  Copyright (c) 2013 Oli. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)

-(void)addShadowWithOpacity: (float) opacity leftOffset: (CGFloat) x topOffset: (CGFloat) y withRadius: (CGFloat) radius
{    
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(x, y);
    self.layer.shadowOpacity = opacity;
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
    if(radius > 0) self.layer.shadowRadius = radius;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

@end
