#import "_User.h"

@interface User : _User {}

@property (nonatomic, readonly) NSArray *checkedOutDeviceHistory;


-(NSString*)avatarURLOfSize:(int)width;


@end
