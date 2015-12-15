//
//  DeviceProfileViewController.m
//  DeviceCentral
//
//  Created by Chris Larsen on 10/28/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "DeviceProfileViewController.h"
#import <ObjQREncoder/QREncoder.h>

@implementation DeviceProfileViewController
{
    NSMutableArray *_history;
}

static const CGFloat kPadding = 10;

-(void)setDevice:(Device *)device
{
    _device = device;
    
    NSDateFormatter *format = [NSDateFormatter new];
    [format setDateFormat:@"MMM dd, yyyy, HH:mm:SS"];
    
    self.deviceName.text = device.name;
    self.checkedOutToName.text = device.isCheckedOutValue ? device.userWithDevice.name : NSLocalizedString(@"Not checked out", nil);
    self.checkedOutDate.text = device.isCheckedOutValue ? [format stringFromDate:device.checkedOutDate] : @"";
    
    _history = [NSMutableArray new];
    for(History *history in device.history){
        if(history.checkedInDate) [_history addObject:history];
    }
    
    
    NSString *code = [self.device.objectID.URIRepresentation absoluteString];
    UIImage* image = [QREncoder encode:code size:4 correctionLevel:QRCorrectionLevelMedium];
    
    self.QRImage.image = image;
    [self.QRImage layer].magnificationFilter = kCAFilterNearest;
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.device = self.device;
}


//Actions
- (IBAction)emailQRCode:(id)sender {
    
    NSLog(@"emailing QRCode");
    
}

- (IBAction)printQRCode:(id)sender {
    NSLog(@"printing QRCode");
    
    /*
     Printing docs
    // https://developer.apple.com/library/IOs/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/Printing/Printing.html
     */
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _history.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDateFormatter *format = [NSDateFormatter new];
    [format setDateFormat:@"MMM dd, yyyy, HH:mm:SS"];
    
    History *history = _history[indexPath.row];
    cell.textLabel.text = history.checkedInDate ? [NSString stringWithFormat:@"%@ : checked out on %@, checked in on %@", history.user.name, [format stringFromDate:history.checkedOutDate], [format stringFromDate:history.checkedInDate]] : [NSString stringWithFormat:@"%@ : checked out on %@", history.user.name, [format stringFromDate:history.checkedOutDate]];
    
    return cell;
}
@end
