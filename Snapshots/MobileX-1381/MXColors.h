//
//  MXColors.h
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXColors : NSObject {

}

+ (CGColorRef) colorWithRed:(float)red green:(float)green blue:(float)blue alpha:(float)alpha;
+ (CGColorRef) colorWithRed:(float)red green:(float)green blue:(float)blue;

@end

/* ahhhhhhhh!!!! ahhhhh!!!! OH YEAH!!!!! RGHHGHHGHHBHBHGH!!! */
#define RGB(r,g,b) [MXColors colorWithRed:r green:g blue:b]
#define RGBA(r,g,b,a) [MXColors colorWithRed:r green:g blue:b alpha:a]
#define WHT(w) [MXColors colorWithRed:w green:w blue:w]
#define WHTA(w,a) [MXColors colorWithRed:w green:w blue:w alpha:a]