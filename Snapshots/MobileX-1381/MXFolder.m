//
//  MXFolder.m
//  MobileX
//
//  Created by Nick on 18/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXFolder.h"
#import "MXIcon.h"

@implementation MXFolder

- (id) init
{
	[super init];
	[self setNeedsDisplayOnBoundsChange:TRUE];
	[self setAnchorPoint:CGPointZero];
	
	return self;
}

- (void) setBounds:(CGRect)bounds
{
	[super setBounds:bounds];
}

- (void) setNeedsDisplay
{
	[CATransaction begin];
	[CATransaction setDisableActions:TRUE];
	_transitionStage = FALSE;
	[super setNeedsDisplay];
	[CATransaction commit];
}

- (void) drawInContext:(CGContextRef)context
{
	if (_transitionStage) return;
	
	CGRect zRect = CGRectBaseOrigin(self.frame);
	
	CGContextSetFillColorWithColor(context, WHT(0));
	CGContextAddRoundedRect(context, CGInsetRect(zRect, 1), 15);
	CGContextFillPath(context);
	
	CGRect insRect = CGInsetRect(zRect, 2);
	CGContextSetLineWidth(context, 3);
	CGContextSetStrokeColorWithColor(context, WHT(1));
	CGContextAddRoundedRect(context, insRect, 15);
	CGContextStrokePath(context);

}

- (void) fireActionOfType:(int)type
{
	CGRect expandedFrame = CGRectBaseOrigin([[[self superlayer] superlayer] frame]);

	expandedFrame = CGInsetRect(expandedFrame, 20);
	
	[[[self superlayer] superlayer] addSublayer:self];
	
	_transitionStage = TRUE;
	[self display];
	
	[CATransaction begin];
	[CATransaction setAnimationDuration:1];
	[self setFrame:expandedFrame];
	[CATransaction commit];
}


@end
