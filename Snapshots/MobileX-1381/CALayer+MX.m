//
//  CALayer+MX.m
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "CALayer+MX.h"


@implementation CALayer (MX)

- (id) initWithFrame:(CGRect)f
{
	id s = [self init];
	[s setFrame:f];
	[self addContents];
	[self setNeedsDisplay];
	return self;
}

- (void) displayWithoutAnimation
{
	[CATransaction begin];
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
	
	[self setNeedsDisplay];
	
	[CATransaction commit];
}

- (BOOL) wantsToRespondToEventOfType:(MTTouchType)type
{
	return FALSE;
}

- (void) layerInHitTestTreeWithTopLayer:(CALayer*)layer
{
	
}

- (BOOL) overtakeAsFirstResponderFrom:(CALayer*)oldResponder
						   atLocation:(CGPoint)location
							  forType:(MTTouchType)type
{
	return FALSE;
}

- (void) cancelTouchDown
{
	
}

- (void) addContents
{
	
}

@end
