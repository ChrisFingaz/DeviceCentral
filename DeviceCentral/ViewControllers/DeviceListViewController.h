//
//  DeviceListViewController.h
//  DeviceCentral
//
//  Created by Chris Larsen on 10/24/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ModelDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) DevicesModel *model;

@end
