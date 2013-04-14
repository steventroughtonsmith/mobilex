//
//  MXScroller.m
//  WaterFountain
//
//  Created by Nick on 07/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import "MXScroller.h"
#import "MXCG.h"
#import "MXColors.h"

@implementation MXScroller

@synthesize scrollerStyle=_style;
@synthesize maxFrame=_maxFrame;

- (BOOL) ignoresHitTesting
{
	return TRUE;
}

- (void) setMaxFrame:(CGRect)rect
{
	
}

- (void) setFrame:(CGRect)rect
{
	_oldFrame = rect;
	[super setFrame:rect];
}

- (void) setPosition:(CGPoint)pos
{
	pos.x = lroundf(pos.x);
	pos.y = lroundf(pos.y);
	
	if (pos.x < 0 && FALSE) {
		[CATransaction begin]; 
		[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
		[super setBounds:CGRectMake(self.bounds.origin.x,
									self.bounds.origin.y,
									_oldFrame.size.width + pos.x,
									_oldFrame.size.height)];
		[CATransaction commit];
	}
	else {
		[super setBounds:CGRectMake(self.bounds.origin.x,
									self.bounds.origin.y,
									_oldFrame.size.width,
									_oldFrame.size.height)];
		[super setPosition:pos];
	}
}

- (void) drawInContext:(CGContextRef)context
{
	CGRect rect = CGRectBaseOrigin(self.bounds);
	rect = CGRectMake(0,
					  0,
					  lroundf(rect.size.width)-1,
					  lroundf(rect.size.height)-1);
	
	if (_style == kMXScrollLayerIndicatorStyleWhite)
	{
		CGContextSetFillColorWithColor(context, WHTA(0.9,0.5));
		CGContextAddRoundedRect(context, rect, 3);
		CGContextFillPath(context);
	}
	else if (_style == kMXScrollLayerIndicatorStyleBlack)
	{
		CGContextSetFillColorWithColor(context, WHTA(0.2,0.8));
		CGContextAddRoundedRect(context, rect, 4);
		CGContextFillPath(context);
	}
	else if (_style == kMXScrollLayerIndicatorStyleNone)
	{
		
	}
	else
	{
		/* default */
		CGContextSetFillColorWithColor(context, WHTA(0.2,0.8));
		CGContextAddRoundedRect(context, rect, 4);
		CGContextFillPath(context);
		
		CGContextSetStrokeColorWithColor(context, WHTA(0.9,0.2));
		CGContextAddRoundedRect(context, rect, 4);
		CGContextStrokePath(context);
	}
}

@end
