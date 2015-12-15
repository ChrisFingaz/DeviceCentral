//
//  UserProfileViewController.h
//  DeviceCentral
//
//  Created by Chris Larsen on 10/28/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic) User *user;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailAddressLabel;
@property (weak, nonatomic) IBOutlet UITableView *checkedOutDevicesTableView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

- (IBAction)deleteUserPushed:(id)sender;

@end
