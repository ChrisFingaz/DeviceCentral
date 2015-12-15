//
//  DeviceProfileViewController.h
//  DeviceCentral
//
//  Created by Chris Larsen on 10/28/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceProfileViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) Device *device;

@property (weak, nonatomic) IBOutlet UILabel *deviceName;
@property (weak, nonatomic) IBOutlet UILabel *checkedOutToName;
@property (weak, nonatomic) IBOutlet UILabel *checkedOutDate;
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
@property (weak, nonatomic) IBOutlet UIImageView *QRImage;

- (IBAction)emailQRCode:(id)sender;
- (IBAction)printQRCode:(id)sender;

@end
