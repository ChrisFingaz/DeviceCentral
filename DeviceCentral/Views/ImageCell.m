//
//  ImageCell.m
//  DeviceCentral
//
//  Created by Oli Griffiths on 04/11/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.imageWrapper = [UIView new];
    
    //Wrapper draws a "shadow" line
    self.imageWrapper = [[UIView alloc] initWithFrame:CGRectMake(0,10,70,70)];
    self.imageWrapper.layer.cornerRadius = self.imageWrapper.frame.size.width / 2;
    self.imageWrapper.layer.borderWidth = 0.5f;
    self.imageWrapper.layer.borderColor = [UIColor colorWithR:184 G:184 B:184 A:1].CGColor;
    self.imageWrapper.layer.shouldRasterize = YES;
    self.imageWrapper.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    //Image has white border and a circular radius
    self.avatarImage = [[UIImageView alloc] initWithFrame:self.imageWrapper.bounds];
    self.avatarImage.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.width / 2;
    self.avatarImage.layer.masksToBounds = YES;

    [self.imageWrapper addSubview:self.avatarImage];
    [self.contentView addSubview:self.imageWrapper];
}

@end
