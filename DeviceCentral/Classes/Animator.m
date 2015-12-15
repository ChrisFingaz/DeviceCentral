//
//  Animator.m
//  NavigationTransitionTest
//
//  Created by Chris Eidhof on 9/27/13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import "Animator.h"

@implementation Animator
{
    AVAudioPlayer *_audioPlayer;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    BOOL isRoot = fromViewController.navigationController.viewControllers[0] == fromViewController;
    
    if(isRoot){
        
        //Read the audio file.
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"door-open" ofType:@"mp3"];
        NSData *myData = [NSData dataWithContentsOfFile:filePath];
        
        _audioPlayer = [(AVAudioPlayer*)[AVAudioPlayer alloc] initWithData:myData error:nil];
        [_audioPlayer play];
        
        [[transitionContext containerView] addSubview:toViewController.view];
        [[transitionContext containerView] sendSubviewToBack:toViewController.view];
        toViewController.view.alpha = 0;
        toViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toViewController.view.transform = CGAffineTransformIdentity;
            toViewController.view.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }else{
        
        //Read the audio file.
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"door-close" ofType:@"mp3"];
        NSData *myData = [NSData dataWithContentsOfFile:filePath];
        
        _audioPlayer = [(AVAudioPlayer*)[AVAudioPlayer alloc] initWithData:myData error:nil];
        [_audioPlayer play];
        
        [[transitionContext containerView] addSubview:toViewController.view];
        toViewController.view.alpha = 0;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            toViewController.view.alpha = 1;
            
        } completion:^(BOOL finished) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
            
    }
}

@end
