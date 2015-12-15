//
//  PasscodeViewController.h
//  DeviceCentral
//
//  Created by Janice Garingo on 10/29/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasscodeViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passcodeTextField1;
@property (weak, nonatomic) IBOutlet UITextField *passcodeTextField2;
@property (weak, nonatomic) IBOutlet UITextField *passcodeTextField3;
@property (weak, nonatomic) IBOutlet UITextField *passcodeTextField4;

@end
