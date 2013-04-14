//
//  MXMultitouchHandler.m
//  MobileX
//
//  Created by Nick on 03/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import "MXMultitouchHandler.h"
#import "MXController.h"
#import "MXPortCache.h"

static id _shinst = NULL;

@implementation MXMultitouchHandler

+ (id) shared
{
	if (_shinst==NULL)
	{
		_shinst = [MXMultitouchHandler alloc];
		[_shinst init];
	}
	
	return _shinst;
}

- (void) beginGlobalDraggingForLayer:(id)layer
{
	_dragLayer = layer;
}

/* 
  Event handling routing for remote contexts
  If this returns FALSE the context host won't get the event
 */
- (BOOL) handleMultitouchEventInPort:(mach_port_t)port atPoint:(CGPoint)location type:(GSHandInfoType)type
{
	id window = MXPortCacheLookup(port);
	
	if (window != nil) {
		if ([(MXPane*)window isInExpose])
		{
			[(MXPane*)window activate];
			return FALSE;
		}
	}
	
	if (type == kGSHandInfoTypeTouchDown)
	{
		[(MXPane*)window activate];		
		return TRUE;
	}
	else if (type == kGSHandInfoTypeTouchUp)
	{
		/* release moving lock */
		_dragLayer = nil;
		
		return TRUE;
	}
	else if (type == kGSHandInfoTypeTouchMoved)
	{
		if (_dragLayer != nil)
		{
			/* do the move operation instead */
			[_dragLayer handleDigitizerEventAt:CGPointZero ofType:kMXTMoved forLayer:nil atGlobalPoint:location];
			return FALSE;
		}
		
		return TRUE;
	}
	else {
		return TRUE;
	}
}

/* Normal event handling routine */
- (void) handleMultitouchEvent:(CGPoint)location type:(MTTouchType)type
{
	CALayer* mainLayer = [[MXController shared] mainLayer];
	CALayer* hitLayer = [mainLayer hitTest:location];
	CALayer* currentLayer = hitLayer;
	CALayer* firstResponder = nil;
	CALayer* lastResponderForEvent = nil;
	BOOL firstResponderShouldHandleEvent = TRUE;
	
	/* 
	  This is to ensure that there is ALWAYS a touch down event
	  Even when the HID driver glitches and doesn't handle it
	 */
	if (type == kMXTEnd) {
		/* reset */
		_hasHadTouchDown = FALSE;
	}
	else if (type == kMXTBegin) {
		/* this is normal */
		_hasHadTouchDown = TRUE;
	}
	else if (!_hasHadTouchDown && type == kMXTMoved)
	{
		/* 
		  Weird event without a "touch down"
		  Make this a touch down instead
		 */
		type = kMXTBegin;
		_hasHadTouchDown = TRUE;
	}
	
	/* Handle global dragging if there is a layer currently being dragged */
	if (_dragLayer != nil) {
		if (type == kMXTMoved) {
			CGPoint relativePoint = [mainLayer convertPoint:location toLayer:_dragLayer];
			[_dragLayer handleDigitizerEventAt:relativePoint
										ofType:kMXTMoved
									  forLayer:_dragLayer
								 atGlobalPoint:location];
			return;
		}
		else {
			_dragLayer = nil;
		}
	}
	
	/* Main touch handling loop */
	while (currentLayer != nil) {
		/* Check if the current layer is the first layer to be able to respond to touch events  */
		if ([currentLayer respondsToSelector:@selector(handleDigitizerEventAt:ofType:forLayer:atGlobalPoint:)] &&
			firstResponder == nil) {
			lastResponderForEvent = firstResponder = currentLayer;
		}
		else {
			if ([currentLayer overtakeAsFirstResponderFrom:firstResponder
												atLocation:location
												   forType:type]) {
				/* the current layer wants to become the first responder */
				lastResponderForEvent = firstResponder = currentLayer;
			}
			else {
				/* the current layer wants to be a "second hand responder" for an event */
				if ([currentLayer wantsToRespondToEventOfType:type]) {
					lastResponderForEvent = currentLayer;
					CGPoint relativePoint = [mainLayer convertPoint:location toLayer:currentLayer];
					[currentLayer handleDigitizerEventAt:relativePoint ofType:type forLayer:hitLayer atGlobalPoint:location];
				}
			}
		}

		/* Notfiy the current layer that it is in the hit test tree */
		[currentLayer layerInHitTestTreeWithTopLayer:hitLayer];
		
		/* Move one layer up */
		currentLayer = [currentLayer superlayer];
	}
	
	/* Check if the last responder lost its drag thing */
	if (_lastResponder != lastResponderForEvent) {
		[_lastResponder handleDigitizerEventAt:location
										ofType:kMXTMovedOut
									  forLayer:_lastResponder
								 atGlobalPoint:location];
	}
	
	/* Fire the event to the first responder */
	if (firstResponderShouldHandleEvent) {
		/* Fire the event for the first responder */
		CGPoint relativePoint = [mainLayer convertPoint:location toLayer:firstResponder];
		[firstResponder handleDigitizerEventAt:relativePoint ofType:type forLayer:hitLayer atGlobalPoint:location];
	}
	
	/* Set last responder */
	_lastResponder = lastResponderForEvent;
}


@end
