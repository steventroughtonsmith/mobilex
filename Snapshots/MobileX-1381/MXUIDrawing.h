//
//  MXUIDrawing.h
//  MobileX
//
//  Created by Nick on 29/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MXUIDrawing : NSObject {

}

+ (void) drawLinearGradientInContext:(CGContextRef)context
							  inRect:(CGRect)rect
							  color1:(CGColorRef)color1
							  color2:(CGColorRef)color2;

+ (void) drawInsetElementInContext:(CGContextRef)context
							inRect:(CGRect)zRect
							color1:(CGColorRef)color1
							color2:(CGColorRef)color2
							isDown:(BOOL)isDown;

@end
