//
//  UserListViewController.m
//  DeviceCentral
//
//  Created by Chris Larsen on 10/24/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "UserListViewController.h"
#import "UserProfileViewController.h"
#import "UserAddViewController.h"
#import "ImageCell.h"

@implementation UserListViewController
{
    BOOL _deleting;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.model = [UsersModel new];
    self.model.delegate = self;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupNavigationBar];

    //Deselect any selected row
    if(self.tableView.indexPathForSelectedRow){
        [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    }
}

- (void)setupNavigationBar
{
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    
    if([Admin isLoggedIn] || 1)
    {
        self.navigationItem.rightBarButtonItem = addBarButtonItem;
    }else{
        //TODO: Show admin login button
    }
}

- (void)addItem:(id)sender
{
    [self performSegueWithIdentifier:@"userListToAddUser" sender:nil];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"userListToUser"])
    {
        ((UserProfileViewController*) segue.destinationViewController).user = self.model.fetchedObjects[self.tableView.indexPathForSelectedRow.row];
    }
}

#pragma mark - Table view data source
-(void)modelDidChangeContent
{
    if(!_deleting) [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.model.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    static UIImage *blankImage;
    static int isRetina = -1;
    
    if(isRetina == -1) isRetina = [UIScreen mainScreen].scale > 1 ? 1 : 0;
    
    if(!blankImage){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(50, 90), NO, 0.0);
        blankImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    //Get the user object
    User *user = self.model.fetchedObjects[indexPath.row];
    
    ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    //Set cell label
    cell.textLabel.attributedText = [user.name boldedWordsForFontSize:cell.textLabel.font.pointSize];
    cell.textLabel.frame = CGRectMake(cell.avatarImage.frame.size.width,0,cell.bounds.size.width - cell.avatarImage.frame.size.width, cell.bounds.size.height);
    [cell.textLabel sizeToFit];
    
    //Create image using blank png and overlaying custom image
    cell.imageView.image = blankImage;

    //Set image
    [cell.avatarImage setImageWithURL:[NSURL URLWithString:[user avatarURLOfSize:isRetina ? cell.avatarImage.frame.size.width*2 : cell.avatarImage.frame.size.width]] placeholderImage:[UIImage imageNamed:@"profile"]];
    
    //Create devices checked out array
    NSMutableArray *devices = [NSMutableArray new];
    for(Device *device in user.checkedOutDevices) {
        [devices addObject:device.name];
    }
    
    UILabel *devicesLabel = [UILabel new];
    devicesLabel.font = [UIFont systemFontOfSize:24];
    devicesLabel.text = [devices componentsJoinedByString:@", "];
    devicesLabel.textColor = [UIColor colorWithR:70 G:143 B:187 A:1];
    [devicesLabel sizeToFit];
    
    //Set label position & width
    CGFloat left = cell.contentView.bounds.size.width - devicesLabel.frame.size.width - 5;
    CGFloat offset = cell.textLabel.frame.origin.x + cell.textLabel.frame.size.width + 30;
    if(left < offset) left = offset - 5;
    devicesLabel.frame = CGRectMake(left, 0, cell.contentView.bounds.size.width - left, 90);
    [cell.contentView addSubview:devicesLabel];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *user = (User*) self.model.fetchedObjects[indexPath.row];
    
    if(user.checkedOutDevices.count){
        NSMutableArray *devices = [NSMutableArray new];
        
        for(Device *device in user.checkedOutDevices) [devices addObject:device.name];
        
        [[[UIAlertView alloc] initWithTitle:user.name message:[NSString stringWithFormat:@"The following devices are checked out by this user: \n\n%@", [devices componentsJoinedByString:@"\n"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }else{
        [[[UIAlertView alloc] initWithTitle:user.name message:@"No devices checked out" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return true;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        _deleting = YES;
        [self.model deleteObjectAtIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        _deleting = NO;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

@end
