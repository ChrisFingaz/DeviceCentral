//
//  PDFGenerator.m
//  DeviceCentral
//
//  Created by Oli Griffiths on 07/11/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "PDFGenerator.h"

@interface PDFGenerator ()

@property (nonatomic) NSMutableData *data;
@property (nonatomic) CGRect frame;
@property (nonatomic) CGContextRef context;

@end

@implementation PDFGenerator

-(id)initWithDevices:(NSArray*)devices
{
    self = [super init];
    if(self){
        _devices = devices;
        self.margin = 20;
        self.data = [NSMutableData data];
        self.frame = CGRectMake(0, 0, 612, 792);
    }
    
    return self;
}


+(NSData*)generateWithDevices:(NSArray*)devices
{
    PDFGenerator *generator = [[self alloc] initWithDevices:devices];
    
    return [generator generate];
}


-(NSData*)generate
{
    // Points the pdf converter to the mutable data object and to the UIView to be converted
    UIGraphicsBeginPDFContextToData(self.data, self.frame, nil);
    self.context = UIGraphicsGetCurrentContext();
    
    //Build the PDF
    [self buildPages];
    
    // remove PDF rendering context
    UIGraphicsEndPDFContext();

    
//    // Retrieves the document directories from the iOS device
//    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
//    
//    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
//    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:@"mypdf.pdf"];
//    
//    [self.data writeToFile:documentDirectoryFilename atomically:YES];
//    NSLog(@"documentDirectoryFileName: %@",documentDirectoryFilename);
//    
    return self.data;
}


-(void)buildPages
{
    UIView *page = [self buildPage];
    int x = 0;
    int width = 100;
    int height = 130;
    int spacing = 15;
    int y = 0;
    
    for(Device *device in self.devices)
    {
        CGRect frame = CGRectMake(x * (width + (x > 0 ? spacing : 0)), y * (height + (y > 0 ? spacing : 0)), width, height);
        
        //Ensure the code is not off the page width, if so, move to new line
        if(CGRectGetMaxX(frame) > CGRectGetMaxX(page.frame)){
            y++;
            x = 0;
            frame.origin = CGPointMake(0, y * (height + (y > 0 ? spacing : 0)));
        }
        
        //Ensure the code is not off the page height, if so, create a new page
        if(CGRectGetMaxY(frame) > CGRectGetMaxY(page.frame)){
            x = 0;
            y = 0;
            frame.origin = CGPointMake(0,0);
            
            //Render current page
            [page.layer renderInContext:self.context];
            
            //Build new page
            page = [self buildPage];
            
            NSLog(@"--- New PDF page ---");
        }
        
        UIView *view = [[UIView alloc] initWithFrame:frame];
        
        UIImageView *image = [[UIImageView alloc] initWithImage:[device.QRCode resize:CGSizeMake(100,100)]];
        [view addSubview:image];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,100,frame.size.width,30)];
        label.text = device.name;
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        
        [view addSubview:label];
        
        [page addSubview:view];
        
        x++;
    }
    
    //Render last page
    [page.layer renderInContext:self.context];
}


-(UIView*)buildPage
{
    UIGraphicsBeginPDFPage();
    CGContextTranslateCTM(self.context, self.margin, self.margin);
    
    CGRect frame = UIGraphicsGetPDFContextBounds();
    UIView *page = [[UIView alloc] initWithFrame:CGRectMake(0,0,frame.size.width - self.margin*2,frame.size.height - self.margin*2)];
    return page;
}

@end
