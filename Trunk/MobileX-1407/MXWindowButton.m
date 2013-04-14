//
//  MXWindowButton.m
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXWindowButton.h"
#import "MXCG.h"
#import "MXWindow.h"
#import "MXUIDrawing.h"

#define CW 20
#define CH 20

@implementation MXWindowButton

- (void) onControlTouchEndAt:(CGPoint)point
{
	_isDown = FALSE;
	[self setNeedsDisplay];
}

- (void) onControlTouchBeginAt:(CGPoint)point
{
	_isDown = TRUE;
	[self setNeedsDisplay];
}

- (void) drawInContext:(CGContextRef)ctx
{
	CGRect zRect = CGRectMake(10,
							  ((self.frame.size.height / 2)-(CH/2))-1,
							  CW,
							  CH);
	
	CGContextSetStrokeColorWithColor(ctx, WHTA(1,0.9));
	CGContextAddEllipseInRect(ctx, CGRectMake(zRect.origin.x, zRect.origin.y+1, zRect.size.width, zRect.size.height));
	CGContextStrokePath(ctx);
	
	CGContextSetFillColorWithColor(ctx, RGB(0.51,0,0));
	//CGContextAddEllipseInRect(ctx, zRect);
	CGContextFillPath(ctx);
	
	CGContextSaveGState(ctx);
	CGContextAddEllipseInRect(ctx, zRect);
	CGContextClip(ctx);
	
	if (!_isDown) {
		[MXUIDrawing drawLinearGradientInContext:ctx
										  inRect:zRect
										  color1:RGB(0.96,0.1,0.1)
										  color2:RGB(1,0.71,0.71)];
	}
	else {
		[MXUIDrawing drawLinearGradientInContext:ctx
										  inRect:zRect
										  color1:RGB(1,0.71,0.71)
										  color2:RGB(0.96,0.1,0.1)];
	}
	
	CGContextRestoreGState(ctx);
	
	
	if (!_isDown) {
		CGContextSaveGState(ctx);
		CGContextAddEllipseInRect(ctx, CGRectMake(zRect.origin.x + 5, zRect.origin.y + 2, zRect.size.width / 2, zRect.size.height / 3));
		CGContextClip(ctx);
		
		[MXUIDrawing drawLinearGradientInContext:ctx
										  inRect:zRect
										  color1:WHTA(1,0.3)
										  color2:WHTA(1,0.1)];
		
		
		CGContextRestoreGState(ctx);
	}
	
	CGContextSaveGState(ctx);
	CGContextAddEllipseInRect(ctx, CGRectMake(zRect.origin.x + 5, zRect.origin.y + zRect.size.width - 8, zRect.size.width / 2, zRect.size.height / 3));
	CGContextClip(ctx);
	
	[MXUIDrawing drawLinearGradientInContext:ctx
									  inRect:zRect
									  color1:WHTA(1,0.3)
									  color2:WHTA(1,0.1)];
	
	
	CGContextRestoreGState(ctx);
	
	CGContextSetStrokeColorWithColor(ctx, RGBA(0.6,0.15,0.15,0.7));
	CGContextAddEllipseInRect(ctx, zRect);
	CGContextStrokePath(ctx);
	
	
	

	

	

}

@end
