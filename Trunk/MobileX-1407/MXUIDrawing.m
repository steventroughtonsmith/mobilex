//
//  MXUIDrawing.m
//  MobileX
//
//  Created by Nick on 29/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXUIDrawing.h"
#import "MXCG.h"
#import "MXColors.h"

@implementation MXUIDrawing

+ (void) drawLinearGradientInContext:(CGContextRef)context
							  inRect:(CGRect)rect
							  color1:(CGColorRef)color1
							  color2:(CGColorRef)color2
{
	CGColorSpaceRef myColorspace=CGColorSpaceCreateDeviceRGB();
	CGFloat locations[2] = { 1.0, 0.0 };
	CGGradientRef myGradient = CGGradientCreateWithColors(myColorspace, (CFArrayRef)[NSArray arrayWithObjects:(id)color2,(id)color1,nil], locations);

	CGPoint myStartPoint, myEndPoint;
	myStartPoint.x = rect.origin.x;
	myStartPoint.y = rect.origin.y;
	myEndPoint.x = rect.origin.x;
	myEndPoint.y = rect.origin.y+rect.size.height;
	CGContextDrawLinearGradient (context, myGradient, myStartPoint, myEndPoint, 0);	
}

+ (void) drawInsetElementInContext:(CGContextRef)ctx
							inRect:(CGRect)zRect
							color1:(CGColorRef)color1
							color2:(CGColorRef)color2
							isDown:(BOOL)isDown
{
	CGContextAddRoundedRect(ctx, CGRectMake(zRect.origin.x+0.5, zRect.origin.y+0.5, zRect.size.width-1, zRect.size.height-1), 5);
	CGContextSetLineWidth(ctx, 1);
	CGContextSetStrokeColorWithColor(ctx, WHT(0.3));
	CGContextStrokePath(ctx);
	
	CGContextSaveGState(ctx);
	
	CGContextAddRoundedRect(ctx, CGInsetRect(zRect,1), 5);
	CGContextClip(ctx);
	
	/* gradient fill */
	[MXUIDrawing drawLinearGradientInContext:ctx
									  inRect:zRect
									  color1:color1
									  color2:color2];
	
	if (isDown)
	{
		CGRect oRect = CGCtxRectOutset(ctx, zRect, 10);
		CGContextAddRoundedRect(ctx, oRect, 5);
		CGContextSetStrokeColorWithColor(ctx, RGB(1,0,0));
		CGContextSetShadowWithColor(ctx, CGSizeMake(3, 3), 5, WHT(0));
		CGContextStrokePath(ctx);
	}

	
	CGContextRestoreGState(ctx);
}

@end
