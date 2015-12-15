//
//  ScanViewController.h
//  DeviceCentral
//
//  Created by Oli Griffiths on 28/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanViewController : BaseViewController <UITableViewDelegate, UIAlertViewDelegate, AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic) User *user;
@property (nonatomic) Device *device;

@property (nonatomic) NSArray *devices;
@property (nonatomic) BOOL isCheckingIn;

@property (weak, nonatomic) IBOutlet UIButton *switchCameraButton;
@property (weak, nonatomic) IBOutlet UIView *cameraPreviewView;
@property (weak, nonatomic) IBOutlet UIView *overlay;

- (IBAction)flipCameraPressed:(id)sender;

@end
