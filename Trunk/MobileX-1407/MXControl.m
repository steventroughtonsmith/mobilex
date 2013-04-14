//
//  MXControl.m
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXControl.h"


@implementation MXControl

- (id) init
{
	[super init];
	
	/* this to ensure targets are not retained */
	_dispatchTable = (NSMutableArray*)CFArrayCreateMutable(kCFAllocatorDefault,
														   10, 
														   &kCFTypeArrayCallBacks);
	return self;
}

- (void) dealloc {
	[_dispatchTable release];
	[super dealloc];
}

- (void) removeTarget:(id)target {
	for (uint32_t i = 0; i < [_dispatchTable count]; i++) {
		id obj = [_dispatchTable objectAtIndex:i];
		if ([obj objectForKey:@"target"] == target) {
			[_dispatchTable removeObjectAtIndex:i];
			return;
		}
	}
}

- (void) addTarget:(id)target action:(SEL)action eventType:(int)type
{
	[_dispatchTable addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							   target,@"target",
							   NSStringFromSelector(action),@"selector",
							   [NSNumber numberWithInt:type],@"type",
							   nil]];
}

- (void) addTarget:(id)target action:(SEL)action withObject:(id)object
{
	[_dispatchTable addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							   target,@"target",
							   object,@"object",
							   NSStringFromSelector(action),@"selector",
							   [NSNumber numberWithInt:0],@"type",
							   nil]];
}

- (void) addTarget:(id)target action:(SEL)action
{
	[_dispatchTable addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							   target,@"target",
							   NSStringFromSelector(action),@"selector",
							   [NSNumber numberWithInt:0],@"type",
							   nil]];
}

- (void) addSenderTarget:(id)target action:(SEL)action eventType:(int)type
{
	[_dispatchTable addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							   target,@"target",
							   kCFBooleanTrue,@"needsSender",
							   NSStringFromSelector(action),@"selector",
							   [NSNumber numberWithInt:type],@"type",
							   nil]];
}

- (void) addSenderTarget:(id)target action:(SEL)action withObject:(id)object
{
	[_dispatchTable addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							   target,@"target",
							   object,@"object",
							   kCFBooleanTrue,@"needsSender",
							   NSStringFromSelector(action),@"selector",
							   [NSNumber numberWithInt:0],@"type",
							   nil]];
}

- (void) addSenderTarget:(id)target action:(SEL)action
{
	[_dispatchTable addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							   target,@"target",
							   kCFBooleanTrue,@"needsSender",
							   NSStringFromSelector(action),@"selector",
							   [NSNumber numberWithInt:0],@"type",
							   nil]];
}

- (void) addSenderTarget:(id)target action:(SEL)action withObject:(id)object eventType:(int)type
{
	[_dispatchTable addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							   target,@"target",
							   object,@"object",
							   kCFBooleanTrue,@"needsSender",
							   NSStringFromSelector(action),@"selector",
							   [NSNumber numberWithInt:type],@"type",
							   nil]];
}

- (void) addTarget:(id)target action:(SEL)action withObject:(id)object eventType:(int)type
{
	[_dispatchTable addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							   target,@"target",
							   object,@"object",
							   NSStringFromSelector(action),@"selector",
							   [NSNumber numberWithInt:type],@"type",
							   nil]];
}

- (void) fireActionOfType:(int)type
{
	for (NSDictionary* ds in _dispatchTable)
	{
		if ([[ds objectForKey:@"type"] intValue] == type)
		{
			id target = [ds objectForKey:@"target"];
			id object = [ds objectForKey:@"object"];
			BOOL needsSender = [ds boolForKey:@"needsSender"];
			SEL selector = NSSelectorFromString([ds objectForKey:@"selector"]);
			
			if (target != NULL)
			{
				if (object != NULL)
				{
					if (needsSender)
						[target performSelector:selector withObject:object withObject:self];
					else
						[target performSelector:selector withObject:object];
				}
				else 
				{
					if (needsSender)
						[target performSelector:selector withObject:self];
					else
						[target performSelector:selector];
				}
			}
		}
	}
}

- (void) onControlTouchEndAt:(CGPoint)point
{
	
}

- (void) onControlTouchBeginAt:(CGPoint)point
{
	
}

- (void) cancelTouchDown
{
	[self onControlTouchEndAt:CGPointZero];
	_ignoreNextTouchEnd = TRUE;
}

- (void) handleDigitizerEventAt:(CGPoint)point ofType:(MTTouchType)type forLayer:(CALayer*)layer
{
	if (type == kMXTEnd && !_ignoreNextTouchEnd)
	{
		[self onControlTouchEndAt:point];
		
		if (_isControlDown)
			[self fireActionOfType:0];
		
		_isControlDown = FALSE;
	}
	else if (type == kMXTBegin)
	{
		_isControlDown = TRUE;
		[self onControlTouchBeginAt:point];
	}
	else if (type == kMXTMovedOut)
	{
		_isControlDown = FALSE;
		[self onControlTouchEndAt:point];
	}
}

- (void) handleDigitizerEventAt:(CGPoint)point ofType:(MTTouchType)type forLayer:(CALayer*)layer atGlobalPoint:(CGPoint)globalPoint
{
	[self handleDigitizerEventAt:point ofType:type forLayer:layer];
}

@end
