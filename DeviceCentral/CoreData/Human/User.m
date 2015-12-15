#import "User.h"


@interface User ()

// Private interface goes here.

@end


@implementation User

- (NSMutableOrderedSet*)checkedOutDevices
{
    NSMutableOrderedSet *set = [NSMutableOrderedSet new];
    
    for(History *history in self.history)
    {
        if(history.checkedInDate == nil && history.device != nil) [set addObject:history.device];
    }
    
    return set;
}

- (NSArray*)checkedOutDeviceHistory
{
    NSMutableArray *array = [NSMutableArray new];
    
    for(History *history in self.history)
    {
        if(history.checkedInDate == nil && history.device != nil) [array addObject:history];
    }
    
    return array;
}

-(NSString*)avatarURLOfSize:(int)width;
{
    return [NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@?s=%i&d=404", [self.email MD5String], width];
}

@end
