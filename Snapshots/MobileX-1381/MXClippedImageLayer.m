//
//  MXClippedImageLayer.m
//  MobileX
//
//  Created by Nick on 15/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXClippedImageLayer.h"


@implementation MXClippedImageLayer

- (void) drawInContext:(CGContextRef)context
{
	CGContextSaveGState(context);
	if (_hasClipRect)
	{
		CGContextAddRect(context, _clipRect);
		CGContextClip(context);
	}
	
	[super drawInContext:context];
	CGContextRestoreGState(context);
}

- (void) unsetClipRect
{
	_hasClipRect = FALSE;
}

- (CGRect) clipRect
{
	return _clipRect;
}

- (void) setClipRect:(CGRect)rect
{
	_hasClipRect = TRUE;
	_clipRect = rect;
}


@end
