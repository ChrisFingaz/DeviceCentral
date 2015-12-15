//
//  CompleteViewController.h
//  DeviceCentral
//
//  Created by Chris Larsen on 10/29/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompleteViewController : BaseViewController

@property (nonatomic) BOOL isCheckingIn;
@property (nonatomic) User *user;
@property (nonatomic) Device *device;

@property (weak, nonatomic) IBOutlet UIImageView *tickImageView;
@property (weak, nonatomic) IBOutlet UILabel *thanksLabel;

@end
