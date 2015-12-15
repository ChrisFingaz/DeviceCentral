//
//  CompleteViewController.m
//  DeviceCentral
//
//  Created by Chris Larsen on 10/29/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "CompleteViewController.h"
#import "UIView+Bounce.h"
#import <MediaPlayer/MediaPlayer.h>

@interface CompleteViewController ()

@end

@implementation CompleteViewController
{
    AVAudioPlayer *_audioPlayer;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    
    if(self.isCheckingIn){
        self.thanksLabel.text = [NSString stringWithFormat:@"Thanks for checking back in: %@", self.device.name];
    }else{
        self.thanksLabel.text = [NSString stringWithFormat:@"Thanks %@ for checking out: %@", self.user.name, self.device.name];
    }
    
    [self.tickImageView bounce:3];
    
    //Read the audio file.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"success" ofType:@"mp3"];
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
    _audioPlayer = [(AVAudioPlayer*)[AVAudioPlayer alloc] initWithData:myData error:nil];
    [_audioPlayer play];
    
    //Auto rewind
    [self performSelector:@selector(rewind) withObject:@YES afterDelay:4];
}

-(void)rewind
{
    if(self.navigationController.visibleViewController == self){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
