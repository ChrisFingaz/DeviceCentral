//
//  ScanViewController.m
//  DeviceCentral
//
//  Created by Oli Griffiths on 28/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ScanViewController.h"
#import "CompleteViewController.h"

@interface ScanViewController ()


@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCaptureDeviceInput *activeDevice;
@property (nonatomic) AVCaptureMetadataOutput *activeOutput;
@property (nonatomic) NSString *QRCode;
@property (nonatomic) BOOL isFlipping;
@property (nonatomic) BOOL isFront;

@property (nonatomic) UIToolbar *blurToolbar;

@end


@implementation ScanViewController
{
    AVAudioPlayer *_audioPlayer;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    if(![self frontFacingCameraIfAvailable]){
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No camera found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return;
    }

    [self setupCamera];
    
    self.isFront = YES;
    
    CGFloat borderWidth = 2.0f;
    self.overlay.layer.borderColor = [UIColor yellowColor].CGColor;
    self.overlay.layer.borderWidth = borderWidth;
    self.overlay.alpha = 0.5f;
    
    self.switchCameraButton.layer.cornerRadius = 10;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSelector:@selector(startCamera) withObject:nil afterDelay:0.01];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stopCamera];
}

- (void)setupCamera
{
    self.captureSession = [[AVCaptureSession alloc] init];
    
    //Create output
    self.activeOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.activeOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //Setup capture output
    [self.captureSession addOutput:self.activeOutput];
    
    //Create preview view
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    preview.frame = CGRectMake(0, 0, self.cameraPreviewView.bounds.size.width, self.cameraPreviewView.bounds.size.height);
    [self.cameraPreviewView.layer insertSublayer:preview atIndex:2];
    
    //Default to the front camera
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"camera"] isEqualToString:@"rear"]){
        [self useRearCamera];
    }else{
        [self useFrontCamera];
    }
}

-(void)useFrontCamera
{
    [self useCaptureDevice:[self frontFacingCameraIfAvailable]];
}

-(void)useRearCamera
{
    [self useCaptureDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo]];
}

-(void)useCaptureDevice:(AVCaptureDevice*)device
{
    if(self.activeDevice.device == device) return;
    
    [self removeCamera];
    
    //Create device input
    self.activeDevice = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    //Capture input
    [self.captureSession addInput:self.activeDevice];
    
    //Set meta types to QR code
    self.activeOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
}

-(void)removeCamera
{
    if(self.activeDevice) [self.captureSession removeInput:self.activeDevice];
}

-(void)startCamera
{
    if(self.isFront) [self startFrontCamera];
    else [self startRearCamera];
    
    self.QRCode = nil;
}

-(void)startFrontCamera
{
    if(self.captureSession && !self.captureSession.isRunning){
        [self useFrontCamera];
        [self.captureSession startRunning];
    }
}

-(void)startRearCamera
{
    if(self.captureSession && !self.captureSession.isRunning){
        [self useRearCamera];
        [self.captureSession startRunning];
    }
}

-(void)stopCamera
{
    if(self.captureSession && self.captureSession.isRunning){
        [self.captureSession stopRunning];
    }
}

-(void)playError
{
    //Read the audio file.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"error" ofType:@"mp3"];
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
    _audioPlayer = [(AVAudioPlayer*)[AVAudioPlayer alloc] initWithData:myData error:nil];
    [_audioPlayer play];
}

-(void)dealloc
{
    //Remove session output
    if(self.captureSession){
        [self.captureSession removeOutput:self.activeOutput];
    }
}

- (AVCaptureDevice *)frontFacingCameraIfAvailable
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDevice *captureDevice = nil;
    
    for (AVCaptureDevice *device in videoDevices)
    {
        if (device.position == AVCaptureDevicePositionFront)
        {
            captureDevice = device;
            break;
        }
    }
            
    //  couldn't find one on the front, so just get the default video device.
    if (!captureDevice){
        captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return captureDevice;
}
            

- (void)dismissCamera
{
    DevicesModel *devicesModel = [DevicesModel new];
    Device *device = (Device *)[devicesModel fetchWithId:self.QRCode];
    
    if(!device){
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Device not recognized" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        [self playError];
        return;
    }
    
    [self stopCamera];
    
    if(self.isCheckingIn)
    {
        [self completeCheckInForDevice:device];
    }
    else
    {
        [self completeCheckoutForDevice:device andUser:self.user];
    }
    
}

- (void)completeCheckInForDevice:(Device *)device
{
    if(!device.isCheckedOutValue){
        self.device = device;
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"This device is not checked out" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        [self playError];
        return;
    }
    
    NSLog(@"Checking in device: %@", device.name);
    for(History *history in device.history)
    {
        if(!history.checkedInDate){
            history.checkedInDate = [NSDate new];
            self.user = history.user;
        }
    }
    
    [device.managedObjectContext save:nil];
    
    self.device = device;
    [self performSegueWithIdentifier:@"scanToComplete" sender:nil];
}

-(void)completeCheckoutForDevice:(Device*)device andUser:(User*)user
{
    if(device.isCheckedOutValue && device.userWithDevice == user){
        self.device = device;
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"You have already checked out this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        [self playError];
        return;
        
    }else if(device.isCheckedOutValue){
        self.device = device;
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"This device is already checked out to %@, would you like to check back in and checkout at the same time?", device.userWithDevice.name] delegate:self cancelButtonTitle:@"No" otherButtonTitles: @"Yes", nil] show];
        [self playError];        
        [self startCamera];
        return;
    }
    
    NSLog(@"Checking out device: %@", device.name);
    
    HistoryModel *model = [HistoryModel new];
    History *history = (History*) [model newObject];
    
    history.device = device;
    history.user = user;
    history.checkedOutDate = [NSDate new];
    
    [model saveContext];
    
    self.device = device;
    self.user = user;
    
    [self performSegueWithIdentifier:@"scanToComplete" sender:nil];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self startCamera];
    
    if(buttonIndex == 1){
        for(History *history in self.device.history){
            if(!history.checkedInDate){
                history.checkedInDate = [NSDate new];
                [history.managedObjectContext save:nil];
            }
        }
        
        [self completeCheckoutForDevice:self.device andUser:self.user];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"scanToComplete"])
    {
        ((CompleteViewController*)segue.destinationViewController).user = self.user;
        ((CompleteViewController*)segue.destinationViewController).device = self.device;
        ((CompleteViewController*)segue.destinationViewController).isCheckingIn = self.isCheckingIn;
    }
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if(self.QRCode || self.isFlipping) return;
    
    for(AVMetadataObject *metadata in metadataObjects)
    {
        if([metadata.type isEqualToString:AVMetadataObjectTypeQRCode])
        {
            if(!self.QRCode)
            {
                NSString *QRCode = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                
                NSLog(@"QR code found : %@", QRCode);
                
                if([[QRCode substringToIndex:19] isEqualToString:@"x-device-central://"])
                {
                    self.QRCode = [QRCode substringFromIndex:19];
                    NSLog(@"Defice code found : %@", self.QRCode);
                    
                    [self dismissCamera];
                    break;
                }
            }
        }
    }
}

-(void)myAnimationStopped:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if(self.isFront) [self useRearCamera];
    else [self useFrontCamera];
    
    self.isFlipping = NO;
    self.isFront = !self.isFront;
    
    [self startCamera];
    [self unblurCamera];
}

-(void)unblurCamera
{
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self.blurToolbar.alpha = 0;
                     }
                     completion:^(BOOL finished){
                        [self.blurToolbar removeFromSuperview];
                     }];
}

- (IBAction)flipCameraPressed:(id)sender
{
    if(self.isFlipping) return;
    
    [[NSUserDefaults standardUserDefaults] setObject:self.isFront ? @"rear" : @"front" forKey:@"camera"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.isFlipping = YES;
    
    CGFloat duration = 0.2f;
    
    //Fade the preview out
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self.cameraPreviewView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self stopCamera];
                         self.isFront = !self.isFront;
                         [self startCamera];
                         
                         //Fade the preview back in
                         [UIView animateWithDuration:duration*2
                                               delay:0
                                             options:UIViewAnimationOptionTransitionCrossDissolve
                                          animations:^{
                                              self.cameraPreviewView.alpha = 1;
                                          }
                                          completion:^(BOOL finished){
                                              self.isFlipping = NO;
                                          }];
                     }];
}

@end
