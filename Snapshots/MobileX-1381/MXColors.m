//
//  MXColors.m
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXColors.h"

@implementation MXColors

+ (CGColorRef) colorWithRed:(float)red green:(float)green blue:(float)blue alpha:(float)alpha
{
	float components[4] = {red, green, blue, alpha};
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef bgColor = CGColorCreate(colorSpace, components);
	
	return bgColor;
}

+ (CGColorRef) colorWithRed:(float)red green:(float)green blue:(float)blue
{
	return [MXColors colorWithRed:red green:green blue:blue alpha:1];
}

@end
