//
//  ViewController.m
//  DeviceCentral
//
//  Created by Oli Griffiths on 24/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
   [self populate];
}


-(void)populate
{
    UsersModel *usersModel = [UsersModel new];
    User *user = [usersModel newObject];
    user.name = @"Oli";
    user.id = @1;
    
    [usersModel saveContext];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
