//
//  WelcomeViewController.m
//  DeviceCentral
//
//  Created by Oli Griffiths on 28/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "WelcomeViewController.h"
#import "ScanViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set nav background color to white as this view is clear to "revel" other views when segueing
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:kUIColorBrand];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:22.0]}];    
    
    //Mask the logo
    self.logoImageView.layer.cornerRadius = 87.5f;

    
//   [self importData];
    
//    if(![Admin hasPasscode])
//    {
//        [self performSegueWithIdentifier:@"welcomeToIntro" sender:nil];
//    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Hide nav bar
    self.navigationController.navigationBarHidden = YES;
    
    //Reset animation
    [self reset];
}

-(void)importData
{
    UsersModel *usersModel = [UsersModel new];
    for(NSString *name in @[@"Oli",@"James",@"Brian",@"Janice",@"Ryan",@"Chris",@"Todd"]){
    
        User *user = (User*)[usersModel newObject];
        user.name = name;
    }
    
    [usersModel saveContext];
    
    DevicesModel *devicesModel = [DevicesModel new];
    for(NSString *name in @[@"iPad 1",@"iPad 2",@"iPad 3",@"iPhone 4",@"Samsung S3",@"iPhone 5"]){
        
        Device *device = (Device*)[devicesModel newObject];
        device.name = name;

    }
    
    [devicesModel saveContext];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"welcomeToCheckIn"]){
        ((ScanViewController*) segue.destinationViewController).isCheckingIn = YES;
    }
    
    //setting the title for each back button to blank
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIStatusBarAnimationFade target:nil action:nil];
    
    [self animate];
}


-(void)animate
{
    [UIView animateWithDuration:0.1f animations:^{
        [self.logoImageView setTransform:CGAffineTransformMakeScale(1.1,1.1)];
    }];
    
    [UIView animateWithDuration:0.5f delay:0.1f options:0 animations:^{
        [self.logoImageView setTransform:CGAffineTransformMakeScale(0,0)];
        self.logoImageView.alpha = 0;
    } completion:nil];

    [UIView animateWithDuration:0.6f animations:^{
        
        [self.checkinButton setTransform:CGAffineTransformMakeTranslation(-self.checkinButton.center.x*3,   -self.checkinButton.center.y*2)];
        [self.checkoutButton setTransform:CGAffineTransformMakeTranslation(self.checkoutButton.center.x*3,  -self.checkoutButton.center.y*2)];
        [self.devicesButton setTransform:CGAffineTransformMakeTranslation(-self.devicesButton.center.x*3,   self.devicesButton.center.y*2)];
        [self.usersButton setTransform:CGAffineTransformMakeTranslation(self.usersButton.center.x*3,        self.usersButton.center.y*2)];
        
        [self.view layoutIfNeeded];
    }];
}


-(void)reset
{
    [UIView animateWithDuration:0.6f animations:^{
        self.logoImageView.alpha = 1;
        self.logoImageView.transform = CGAffineTransformIdentity;
        self.checkinButton.transform = CGAffineTransformIdentity;
        self.checkoutButton.transform = CGAffineTransformIdentity;
        self.devicesButton.transform = CGAffineTransformIdentity;
        self.usersButton.transform = CGAffineTransformIdentity;
    }];
}

- (IBAction)unwindToWelcome:(UIStoryboardSegue *)unwindSegue
{
}

@end
