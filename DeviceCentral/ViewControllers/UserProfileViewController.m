//
//  UserProfileViewController.m
//  DeviceCentral
//
//  Created by Chris Larsen on 10/28/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "UserProfileViewController.h"

@implementation UserProfileViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set user image with rounded corners
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2;
    self.avatarImageView.layer.masksToBounds = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.user = self.user;
}

-(void)setUser:(User *)user
{
    _user = user;
    
    if(!user || !self.view) return;
    
    self.title = user.name;
    self.userNameLabel.attributedText = [user.name boldedWordsForFontSize:self.userNameLabel.font.pointSize];
    self.emailAddressLabel.text = user.email;
    
    BOOL isRetina = [UIScreen mainScreen].scale > 1 ? 1 : 0;
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:[user avatarURLOfSize:isRetina ? self.avatarImageView.frame.size.width*2 : self.avatarImageView.frame.size.width]] placeholderImage:[UIImage imageNamed:@"profile"]];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.user.checkedOutDevices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    History *history = self.user.checkedOutDeviceHistory[indexPath.row];
    
    NSDateFormatter *format = [NSDateFormatter new];
    [format setDateFormat:@"MMM dd, yyyy, HH:mm:SS"];
    
    cell.textLabel.text = history.checkedInDate ?
    [NSString stringWithFormat:@"%@ : checked out on %@, checked in on %@", history.device.name, [format stringFromDate:history.checkedOutDate], [format stringFromDate:history.checkedInDate]] :
    [NSString stringWithFormat:@"%@ : checked out on %@", history.device.name, [format stringFromDate:history.checkedOutDate]];
    
    return cell;
}

- (IBAction)deleteUserPushed:(id)sender
{
    if(self.user.checkedOutDevices.count) [[[UIAlertView alloc] initWithTitle:@"Error" message:@"You cannot delete a user with checkout out devices. Please checkin the devices first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    else [[[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are you sure you want to delete this user?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil] show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        [self.user.managedObjectContext deleteObject:self.user];
        [self.user.managedObjectContext save:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
