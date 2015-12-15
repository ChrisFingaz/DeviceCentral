//
//  BaseViewController.m
//  DeviceCentral
//
//  Created by Oli Griffiths on 01/11/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Show the status bar
    self.navigationController.navigationBarHidden = NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
