//
//  MXWindow.m
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXWindow.h"
#import "MXPaneManager.h"
#import "MXController.h"
#import "MXMultitouchHandler.h"
#import "MXUIDrawing.h"

#import "MXWindow+Drawing.h"
#import "MXWindow+Frame.h"

@implementation MXWindow

- (id) init
{
	[super init];
	
	[self addContents];
	[self setBorderStyle:kMXWindowStyleNormal];
	[self setShouldRasterize:TRUE];
	
	return self;
}

- (void) _removeWindowControls
{
	_hasAddedControls = FALSE;
	[_text removeFromSuperlayer];
	[_closeButton removeFromSuperlayer];
}

- (void) _addWindowControls
{
	if (!_hasAddedControls)
	{
		[self addSublayer:_text];
		[self addSublayer:_closeButton];
		_hasAddedControls = TRUE;
	}
}

+ (id) windowForLayer:(id)layer
{
	MXWindow* window = [[MXWindow alloc] initWithLayer:layer
											atPosition:CGPointMake(0, 0)];
	[window autoPosition];
	return window;
}

- (id) initWithHostedLayer:(id)layer
{
	return [self initWithLayer:layer atPosition:CGPointMake(0, 0)];
}

- (id) initWithLayer:(id)layer atPosition:(CGPoint)pos
{
	[self init];
	
	[self hostLayer:layer];
	[self setFrame:CGRectMake(pos.x - SHADOW_INSET,
							  pos.y - SHADOW_INSET,
							  ([layer frame].size.width+_windowBorder.left+_windowBorder.right) + SHADOW_INSET*2,
							  ([layer frame].size.height+_windowBorder.top+_windowBorder.bottom) + SHADOW_INSET*2)];
	
	return self;
}

- (void) setFrame:(CGRect)rect
{
	[super setFrame:rect];
	[self _updateWindowMetrics];
}

- (void) removeFromSuperlayer
{
	[CATransaction begin]; 
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
	[super removeFromSuperlayer];
	[CATransaction commit];
}

- (MXWindowBorderStyles) borderStyle
{
	return _borderStyle;
}

- (void) setBorderStyle:(MXWindowBorderStyles)style
{
	if (style == kMXWindowStyleNormal)
	{
		_windowBorder.top = 38;
		_windowBorder.left = _windowBorder.right = 0;
		_windowBorder.bottom = 0;
		[self _addWindowControls];
	}
	else
	{
		_windowBorder.top = 0;
		_windowBorder.left = _windowBorder.right = 0;
		_windowBorder.bottom = 0;
		[self _removeWindowControls];
	}
	
	_borderStyle = style;
	[self _updateWindowMetrics];
}

- (void) unregister {
	[_closeButton removeTarget:self];
	[super unregister];
}

- (void) close
{
	[self unregister];
}

- (void) fireActionOfType:(int)type
{
	[super fireActionOfType:type];
}

- (NSString*) text
{
	return [_text text];
}

- (BOOL) respondsToCommonEnumeration
{
	return ![self isFixed];
}

- (void) setText:(NSString*)text
{
	[_text setText:text];
}

- (void) addContents
{
	_text = [[MXText alloc] init];
	[_text setFont:[MXFont regularFontWithFamily:@"Helvetica" size:14]];
	[_text setColor:WHTA(0.15,1)];
	[_text setShadowOffset:CGSizeMake(0, 1)];
	[_text setShadowColor:WHT(0.8)];
	[_text setText:@""];

	_closeButton = [[MXWindowButton alloc] init];
	[_closeButton addTarget:self action:@selector(close)];
	
	[self _addWindowControls];
}

- (void) hostLayer:(id)layer
{
	_hostedLayer = layer;
	[self addSublayer:layer];
}

- (void) paneActivated
{
	[super paneActivated];
	[self fireActionOfType:kMXWindowActivate];
}

- (BOOL) isFixed
{
	return FALSE;
}

- (void) dealloc {
	MSLog(@"%@: dealloc", self);
	
	[_text release];
	[_closeButton release];
	
	[super dealloc];
}

- (void) drawInContext:(CGContextRef)ctx
{
	if (_borderStyle == kMXWindowStyleNormal) {
		[self _drawBorderedWindowInContext:ctx];
	}
	else {
		[self _drawBorderlessWindowInContext:ctx];
	}
}

- (void) handleDigitizerEventAt:(CGPoint)point ofType:(MTTouchType)type forLayer:(CALayer*)layer atGlobalPoint:(CGPoint)globalPoint
{
	if (![self isFixed]) {
		if (type == kMXTBegin)
		{
			_touchDownOrigin = self.frame.origin;
			_touchDownPoint = globalPoint;
			
			[self activate];
			[[MXMultitouchHandler shared] beginGlobalDraggingForLayer:self];
			
			_isMovable = TRUE;
		}
		
		if (type == kMXTEnd)
		{
			_isMovable = FALSE;
		}
		
		if (type == kMXTMoved && _isMovable)
		{
			float x = _touchDownOrigin.x - (_touchDownPoint.x - globalPoint.x);
			float y = _touchDownOrigin.y - (_touchDownPoint.y - globalPoint.y);
			
			[CATransaction begin]; 
			[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
			self.position = CGPointMake(x, y);
			[CATransaction commit];
		}
	}
}

@end
