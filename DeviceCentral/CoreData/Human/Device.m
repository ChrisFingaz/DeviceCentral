#import "Device.h"
#import <ObjQREncoder/QREncoder.h>

@interface Device ()

// Private interface goes here.

@end


@implementation Device

-(UIImage*)QRCode
{
    NSString *code = [@"x-device-central://" stringByAppendingString:self.id];
    UIImage* image = [QREncoder encode:code size:4 correctionLevel:QRCorrectionLevelMedium];
    return image;
}


-(BOOL)isCheckedOutValue
{
    for(History *history in self.history)
    {
        if(history.checkedInDate == nil) return YES;
    }
    
    return NO;
}

-(User*)userWithDevice
{
    for(History *history in self.history)
    {
        if(history.checkedInDate == nil && history.user != nil) return history.user;
    }
    
    return nil;
}

-(NSDate*)checkedOutDate
{
    for(History *history in self.history)
    {
        if(history.checkedInDate == nil) return history.checkedOutDate;
    }
    
    return nil;
}

@end
