//
//  WelcomeViewController.h
//  DeviceCentral
//
//  Created by Oli Griffiths on 28/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIButton *checkinButton;
@property (weak, nonatomic) IBOutlet UIButton *checkoutButton;
@property (weak, nonatomic) IBOutlet UIButton *devicesButton;
@property (weak, nonatomic) IBOutlet UIButton *usersButton;


@end
