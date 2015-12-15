//
//  UserListViewController.h
//  DeviceCentral
//
//  Created by Chris Larsen on 10/24/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) UsersModel *model;

@end
