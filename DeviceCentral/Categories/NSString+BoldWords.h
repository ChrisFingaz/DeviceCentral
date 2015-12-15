//
//  NSString+BoldWords.h
//  DeviceCentral
//
//  Created by Oli Griffiths on 04/11/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BoldWords)

-(NSAttributedString*)boldedWordsForFontSize:(CGFloat)fontSize;

@end
