    //
//  DeviceAddViewController.h
//  DeviceCentral
//
//  Created by Oli Griffiths on 05/11/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceAddViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *identifierTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *osSegment;

-(void)addDevice:(void (^)(void))complete;

@end
