//
//  NSString+BoldWords.m
//  DeviceCentral
//
//  Created by Oli Griffiths on 04/11/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "NSString+BoldWords.h"

@implementation NSString (BoldWords)

-(NSAttributedString*)boldedWordsForFontSize:(CGFloat)fontSize;
{
    UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
    UIFont *regularFont = [UIFont systemFontOfSize:fontSize];
    UIColor *foregroundColor = [UIColor blackColor];
    
    // Create the attributes
    NSDictionary *attrs = @{NSFontAttributeName: boldFont, NSForegroundColorAttributeName: foregroundColor};
    NSDictionary *subAttrs = @{NSFontAttributeName: regularFont};
    
    const NSRange range = NSMakeRange(0,[self rangeOfString:@" "].location != NSNotFound ? [self rangeOfString:@" "].location : self.length);
    
    // Create the attributed string (text + attributes)
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self attributes:attrs];
    [attributedText setAttributes:subAttrs range:range];
    
    return attributedText;
}

@end
