//
//  CheckoutViewController.m
//  DeviceCentral
//
//  Created by Oli Griffiths on 01/11/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "CheckoutViewController.h"
#import "ScanViewController.h"

@interface CheckoutViewController ()

@property (nonatomic) UsersModel *model;

@end

@implementation CheckoutViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.model = [UsersModel new];
    
    self.title = @"Checkout";
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.fetchedObjects.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static int isRetina = -1;
    
    if(isRetina == -1) isRetina = [UIScreen mainScreen].scale > 1 ? 1 : 0;
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    User *user = self.model.fetchedObjects[indexPath.row];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.bounds.size.height - 25, cell.bounds.size.width, 25)];
    nameLabel.text = user.name;
    nameLabel.textColor = [UIColor darkGrayColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:20];
    [cell addSubview:nameLabel];
    
    int padding = 20;
    UIView *imageWrapperView = [[UIView alloc] initWithFrame:CGRectMake(padding,padding,cell.bounds.size.width - padding*2, cell.bounds.size.width - padding*2)];
    imageWrapperView.layer.cornerRadius = imageWrapperView.frame.size.width / 2;
    imageWrapperView.layer.borderWidth = 0.5f;
    imageWrapperView.layer.borderColor = [UIColor colorWithR:0 G:0 B:0 A:0.2].CGColor;
    imageWrapperView.layer.shouldRasterize = YES;
    imageWrapperView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageWrapperView.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = 4.0f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [imageView setImageWithURL:[NSURL URLWithString:[user avatarURLOfSize:isRetina ? cell.bounds.size.width*2 : cell.bounds.size.width]] placeholderImage:[UIImage imageNamed:@"profile"]];
    
    [imageWrapperView addSubview:imageView];
    [cell addSubview:imageWrapperView];

    
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"checkOutToScan"])
    {
        ((ScanViewController*) segue.destinationViewController).user = self.model.fetchedObjects[((NSIndexPath*)self.collectionView.indexPathsForSelectedItems[0]).row];
    }
}


@end
