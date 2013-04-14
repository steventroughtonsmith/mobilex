//
//  MXPane.m
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXPane.h"
#import "MXPaneManager.h"
#import <QuartzCore/CAContext.h>

@implementation MXPane

@synthesize isInExpose=_isInExpose;

- (id) init
{
	[super init];
		
	[self setAnchorPoint:CGPointZero];
	
	return self;
}

- (void) setPosition:(CGPoint)point
{	
	[super setPosition:point];
}

- (void) setFrame:(CGRect)rect
{
	[CATransaction begin]; 
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
	
	[super setFrame:rect];
	
	[CATransaction commit];
	
	if (_paneId == 0)
	{
		_paneId = [[MXPaneManager shared] registerPane:self];
	}
	else 
	{
		/* pane moved */
		[[MXPaneManager shared] pane:self changedFrame:rect];
	}
}

- (void) autoPosition
{
	[[MXPaneManager shared] autoPositionPane:self];
}

- (BOOL) overtakeAsFirstResponderFrom:(CALayer *)oldResponder atLocation:(CGPoint)location forType:(MTTouchType)type
{
	return _isInExpose;
}

- (void) layerInHitTestTreeWithTopLayer:(CALayer *)layer
{
	[self activate];
}

- (BOOL) isEqual:(id)object
{
	if ([object isKindOfClass:[self class]])
	{
		if ([(MXPane*)object paneId] == _paneId)
		{
			return TRUE;
		}
	}
	
	return FALSE;
}

- (BOOL) isMinimized
{
	return _isMinimized;
}

- (BOOL) isVisible
{
	if (![self isHidden] &&
		[self superlayer] != nil)
	{
		return TRUE;
	}
	else {
		return FALSE;
	}
}

- (BOOL) isFixed
{
	return FALSE;
}

- (BOOL) shouldAnimatePropertyForKey:(NSString *)key
{
	if (_isInExpose) {
		return TRUE;
	}
	else {
		return FALSE;
	}
}

- (CGRect) getSavedFrame
{
	_savedFrameLocked = FALSE;
	return _savedFrame;
}

- (void) saveFrame
{
	if (!_savedFrameLocked) {
		_savedFrameLocked = TRUE;
		_savedFrame = self.frame;
	}
}

- (void) restoreVisibilityState
{
	_visibilityStateLocked = FALSE;
	
	if (_shouldBecomeVisible == TRUE)
	{
		[self show];
	}
}

- (void) saveVisibilityStateAndHide
{
	if (!_visibilityStateLocked) {
		_visibilityStateLocked = TRUE;
		
		if ([self isVisible]) {
			_shouldBecomeVisible = TRUE;
			[self hide];
		}
		else {
			_shouldBecomeVisible = FALSE;
		}

	}
}

- (void) minimize
{
	_isMinimized = TRUE;
	[self setHidden:TRUE];
}

- (void) restore
{
	_isMinimized = FALSE;
	[self setHidden:FALSE];
}

- (void) activate
{
	if (!_active || _isInExpose)
		[[MXPaneManager shared] activatePane:self];
}

- (void) show
{
	[[MXPaneManager shared] showPane:self];
}

- (void) hide
{
	[[MXPaneManager shared] hidePane:self];
}

- (void) paneDeactivated
{
	_active = FALSE;
}

- (void) paneActivated
{
	_active = TRUE;
}

- (void) unregister
{
	[self removeFromSuperlayer];
	[[MXPaneManager shared] unregisterPane:self];
}

- (int) paneId
{
	return _paneId;
}

- (BOOL) shouldForceTopmost
{
	return FALSE;
}

- (BOOL) respondsToCommonEnumeration
{
	return FALSE;
}

- (BOOL) shouldDisplayOnRegister
{
	return TRUE;
}

- (void) _deactivateFromManager
{
	[self paneDeactivated];
}

- (void) _activateFromManager
{
	[self paneActivated];
}

- (void) _activateIfNeeded
{
	if (!_active || _isInExpose)
		[self _activateFromManager];
}

- (void) _deactivateIfNeeded
{
	if (_active)
		[self _deactivateFromManager];
}

@end
