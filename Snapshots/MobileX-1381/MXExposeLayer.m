//
//  MXExposeLayer.m
//  MobileX
//
//  Created by Nick on 16/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXExposeLayer.h"


@implementation MXExposeLayer

/*
 fuck quartz for making me do this
 setBackgroundColor: is slow as shit
 */

- (void) activate
{
	_active = TRUE;
	[self setNeedsDisplay];
}

- (void) deactivate
{
	_active = FALSE;
	[self setNeedsDisplay];
}

- (BOOL) ignoresHitTesting
{
	return !_active;
}

- (void) drawInContext:(CGContextRef)context
{
	if (!_active) return;
	
	CGContextSetFillColorWithColor(context, WHTA(0,0.7));
	CGContextFillRect(context, CGRectBaseOrigin(self.frame));
}

@end
