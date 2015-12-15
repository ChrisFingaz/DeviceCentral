//
//  DeviceListViewController.m
//  DeviceCentral
//
//  Created by Chris Larsen on 10/24/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "DeviceListViewController.h"
#import "DeviceProfileViewController.h"
#import "DeviceAddViewController.h"
#import "PDFGenerator.h"


@interface DeviceListViewController ()

@property (nonatomic) BOOL isEditing;
@property (nonatomic) NSMutableArray *selected;
@property (nonatomic) UIActionSheet *actionSheet;
@property (nonatomic) DeviceAddViewController *deviceViewController;

@end

@implementation DeviceListViewController
{
    BOOL _deleting;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    self.model = [DevicesModel new];
    self.model.delegate = self;
    
    self.selected = [NSMutableArray new];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setToolbarButtons];
    
    //Deselect any selected row
    if(self.tableView.indexPathForSelectedRow){
        [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    }
}

-(void)setToolbarButtons
{
    NSArray *buttons;
    if(self.isEditing){
        buttons = @[
                 [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(printDevices:)],
                 [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelSelectDevices:)]
                 ];
    }else{
        buttons = @[
                 [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDevice:)],
                 [[UIBarButtonItem alloc]initWithTitle:@"Select" style:UIBarButtonItemStylePlain target:self action:@selector(selectDevices:)]
                 ];
    }
    
    self.navigationController.topViewController.navigationItem.rightBarButtonItems = buttons;
}

#pragma addDevice methods
-(void)addDevice:(id)sender
{
    CustomAlertView *alertView = [[CustomAlertView alloc] init];
    
    [alertView setContainerView:[self createAddDeviceSubview]];
    [alertView setUseMotionEffects:TRUE];
    
    [alertView setButtonTitles:@[@"Add", @"Cancel"]];

    [alertView setDelegate:self];
    [alertView show];
}

- (void)customDialogButtonTouchUpInside: (CustomAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            {
                [self.deviceViewController addDevice:^{
                    [alertView close];
                }];
            }
            break;
            
        case 1:
            [alertView close];
            break;
            
        default:
            break;
    }
}

- (UIView *)createAddDeviceSubview
{
    UIStoryboard *ourStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.deviceViewController = [ourStoryboard instantiateViewControllerWithIdentifier:@"AddDeviceVC"];
    return self.deviceViewController.view;
}


#pragma selectDevices methods
-(void)selectDevices:(id)sender
{
    self.isEditing = YES;
    self.tableView.allowsMultipleSelection = YES;
    [self setToolbarButtons];
}

-(void)cancelSelectDevices:(id)sender
{
    self.isEditing = NO;
    self.tableView.allowsMultipleSelection = NO;
    [self setToolbarButtons];
}


#pragma printDevices methods
-(void)printDevices:(UIBarButtonItem*)sender
{
    if(!self.actionSheet){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                                       delegate: self
                                              cancelButtonTitle: nil
                                         destructiveButtonTitle: @"Cancel"
                                              otherButtonTitles: @"Email QR codes",@"Print QR codes", nil];
    }
    
    if(self.actionSheet.isVisible) return;
    
    //Ensure at least 1 item is selected
    if(self.tableView.indexPathsForSelectedRows.count == 0){
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"You must select at least 1 device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return;
    }
    
    [self.actionSheet showFromBarButtonItem:sender animated:YES];
}

-(void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    
    [self.tableView reloadData];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex <= 0) return;
    
    NSMutableArray *devices = [NSMutableArray new];
    for(NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows){
        [devices addObject:self.model.fetchedObjects[indexPath.row]];
    }
    
    NSData *pdf = [PDFGenerator generateWithDevices: devices];
    
    switch(buttonIndex){
        case 1:
            [self emailPDF:pdf];
            break;
            
        case 2:
            [self printPDF:pdf];
            break;
    }
}


-(void)printPDF:(NSData*)pdf
{
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    if  (pic && [UIPrintInteractionController canPrintData: pdf] ) {
        pic.delegate = self;
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = @"Print QR Codes";
        pic.printInfo = printInfo;
        pic.printingItem = pdf;
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
        ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
            if (!completed && error){
                NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
            }
        };
        
        [pic presentFromRect:self.navigationController.navigationBar.frame inView:self.navigationController.navigationBar.superview animated:YES completionHandler:completionHandler];
    }
}

-(void)emailPDF:(NSData*)pdf
{
    if (![MFMailComposeViewController canSendMail]) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"You must have a mail account configured, please setup a mail acocunt on your iPad." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"Device Central - Device List"];
    [controller setMessageBody:@"Attached is your Device Central device list" isHTML:NO];
    [controller addAttachmentData:pdf mimeType:@"application/pdf" fileName:@"Devices.pdf"];
    if (controller) [self presentViewController:controller animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source
-(void)modelDidChangeContent
{
    if(!_deleting) [self.tableView reloadData];
}

-(UIImage*)blankImage
{
    static UIImage *blankImage;
    
    if(!blankImage){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(50, 90), NO, 0.0);
        blankImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return blankImage;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    [cell.imageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    Device *device = self.model.fetchedObjects[indexPath.row];
    cell.textLabel.textColor = UIColorFromRGB(0x333333);
    cell.textLabel.text = device.name;
    cell.imageView.image = [self blankImage];
    
    if(self.isEditing){
        UILabel *check = [[UILabel alloc] initWithFrame:CGRectMake(0,0,cell.imageView.bounds.size.width, cell.imageView.bounds.size.height)];
        check.font = cell.textLabel.font;
        check.text = @"\u2B1C";
        check.textAlignment = NSTextAlignmentCenter;
        [cell.imageView addSubview:check];
    }else{
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple"]];
        image.frame = CGRectMake(0,0,50,90);
        image.contentMode = UIViewContentModeCenter;
        [cell.imageView addSubview:image];
    }
    
    //Add User Name Label
    UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 35.0, cell.frame.size.width, 24.0)] ;
    nameLbl.tag = 20;
    nameLbl.font = [UIFont fontWithName:@"Helvetica-Light" size:24];
    nameLbl.textAlignment = NSTextAlignmentRight;
    nameLbl.textColor = UIColorFromRGB(0x468fbb);
    [cell.contentView addSubview:nameLbl];
    
    //Add date / time label
    UILabel *timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 60.0, cell.frame.size.width, 24.0)] ;
    timeLbl.tag = 20;
    timeLbl.font = [UIFont fontWithName:@"Helvetica-Oblique" size:16];
    timeLbl.textAlignment = NSTextAlignmentRight;
    timeLbl.textColor = UIColorFromRGB(0x5e6264);
    [cell.contentView addSubview:timeLbl];

    timeLbl.text = device.isCheckedOutValue ? [self elapsedTimeSince:device.checkedOutDate] : nil;
    nameLbl.text = device.isCheckedOutValue ? device.userWithDevice.name :nil;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isEditing){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [cell.imageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        UILabel *check = [[UILabel alloc] initWithFrame:CGRectMake(0,0,cell.imageView.bounds.size.width, cell.imageView.bounds.size.height)];
        check.font = cell.textLabel.font;
        check.text = @"\u2611";
        check.textAlignment = NSTextAlignmentCenter;
        [cell.imageView addSubview:check];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        Device *device = self.model.fetchedObjects[indexPath.row];
        
        NSString *message = device.isCheckedOutValue ?
        [NSString stringWithFormat:@"ID: %@Checked out:\nOn:%@\nTo:%@", device.id, device.checkedOutDate, device.userWithDevice.name] : [NSString stringWithFormat:@"ID: %@", device.id];
        
        [[[UIAlertView alloc] initWithTitle:device.name message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isEditing){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
     
        [cell.imageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        UILabel *check = [[UILabel alloc] initWithFrame:CGRectMake(0,0,cell.imageView.bounds.size.width, cell.imageView.bounds.size.height)];
        check.font = cell.textLabel.font;
        check.text = @"\u2B1C";
        check.textAlignment = NSTextAlignmentCenter;
        [cell.imageView addSubview:check];
    }
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

#pragma get elapsed time
/*
 *  params      :   date (NSDate)
 *  returns     :   elapsed Value (NSString)
 */

- (NSString *)elapsedTimeSince:(NSDate *)date {
    
    NSDate *dateA = date;
    NSDate *dateB = [NSDate date];
    NSMutableArray *stringArray = [[NSMutableArray alloc]init];
   // NSString *timePassed;
    
    //We get the entire amount of time passed using date components
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
                                               fromDate:dateA
                                                 toDate:dateB
                                                options:0];
    
    //go through and add items that aren't zero to an array.
    if (components.year != 0)
    {
        NSString *years = [NSString stringWithFormat:@"%i years", components.year];
        [stringArray addObject:years];
    }
    
    if (components.month != 0)
    {
        NSString *months = [NSString stringWithFormat:@"%i months", components.month];
        [stringArray addObject:months];
    }
    
    if (components.day != 0)
    {
        NSString *days = [NSString stringWithFormat:@"%i days", components.day];
        [stringArray addObject:days];
    }
    
    if (components.hour != 0)
    {
        NSString *hours = [NSString stringWithFormat:@"%i hrs", components.hour];
        [stringArray addObject:hours];
    }
    
    if (components.minute != 0)
    {
        NSString *mins = [NSString stringWithFormat:@"%i mins", components.minute];
        [stringArray addObject:mins];
    }
    
    if (components.second != 0)
    {
        NSString *secs = [NSString stringWithFormat:@"%i secs", components.second];
        [stringArray addObject:secs];
    }
    
    
    return  [[stringArray componentsJoinedByString:@", "] stringByAppendingString:@" ago"];;
}


@end
