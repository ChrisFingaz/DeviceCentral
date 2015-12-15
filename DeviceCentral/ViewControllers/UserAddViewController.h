//
//  UserAddViewController.h
//  DeviceCentral
//
//  Created by Janice Garingo on 10/31/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserAddViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailtextField;
@property (nonatomic) IBOutlet UIView *doneButton;
@property (nonatomic) IBOutlet UIButton *cancelButton;

@end
