//
//  CheckoutViewController.h
//  DeviceCentral
//
//  Created by Oli Griffiths on 01/11/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "BaseViewController.h"

@interface CheckoutViewController : BaseViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
