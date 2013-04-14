//
//  MXWindow+Drawing.m
//  MobileX
//
//  Created by Nick on 02/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import "MXWindow+Drawing.h"
#import "MXUIDrawing.h"

@implementation MXWindow (Drawing)

- (void) _drawWindowShadowInContext:(CGContextRef)ctx
{
	
}

- (void) _drawBorderlessWindowInContext:(CGContextRef)ctx
{
	CGRect zRect = CGRectBaseOrigin(self.frame);
	zRect = CGRectInset(zRect, SHADOW_INSET, SHADOW_INSET);
	
	CGContextAddRect(ctx, zRect);
	CGContextSetFillColorWithColor(ctx, WHTA(0,0.95));
	CGContextFillPath(ctx);
}

- (void) _drawBorderedWindowInContext:(CGContextRef)ctx
{
	CGRect zRect = CGRectBaseOrigin(self.frame);
	zRect = CGRectInset(zRect, SHADOW_INSET, SHADOW_INSET);
	
	CGContextSaveGState(ctx);
	CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 10.0, WHT(0));
	CGContextAddRoundedRect(ctx, zRect, 5);
	
	CGContextFillPath(ctx);
	CGContextRestoreGState(ctx);
	
	CGContextSetFillColorWithColor(ctx, WHTA(0,0.95));
	CGContextSetStrokeColorWithColor(ctx, WHT(0.88));
	
	CGContextSaveGState(ctx);
	
	/* set clipping */
	CGContextAddRoundedRect(ctx, zRect, 5);
	CGContextAddRect(ctx, CGRectMake(0, zRect.size.height-5, zRect.size.width, 5));
	CGContextClip(ctx);
	CGContextFillRect(ctx,zRect);
	
	[MXUIDrawing drawLinearGradientInContext:ctx
									  inRect:_titleBarRect
									  color1:WHT(0.76)
									  color2:WHT(0.60)];
	
	CGContextMoveToPoint(ctx, zRect.origin.x, zRect.origin.y);
	CGContextAddLineToPoint(ctx, zRect.size.width, zRect.origin.y);
	CGContextStrokePath(ctx);
	
	CGContextSetStrokeColorWithColor(ctx, WHT(0.25));
	CGContextMoveToPoint(ctx, _titleBarRect.origin.x, _titleBarRect.origin.y+_titleBarRect.size.height);
	CGContextAddLineToPoint(ctx, _titleBarRect.size.width, _titleBarRect.origin.y+_titleBarRect.size.height);
	CGContextStrokePath(ctx);
	
	CGContextRestoreGState(ctx);
}

@end
