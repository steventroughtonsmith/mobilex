//
//  MXWindow+Frame.m
//  MobileX
//
//  Created by Nick on 02/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import "MXWindow+Frame.h"


@implementation MXWindow (Frame)

- (void) _layoutWindowControlsInFrame:(CGRect)frm
{
	if (_borderStyle == kMXWindowStyleNormal) {
		[_text setFrame:frm];
		[_closeButton setFrame:CGRectMake(5.5f+SHADOW_INSET, frm.origin.y+BTNHTOFFSET+0.5f, BTNWIDTH, frm.size.height-BTNHTOFFSET*2)];
		[_closeButton setNeedsDisplay];
	}
}

- (void) _layoutWindowContents
{
	[_hostedLayer setFrame:_contentRect];
}

- (void) _updateWindowMetrics
{
	_contentRect = CGRectMake(_windowBorder.left+SHADOW_INSET,
							  _windowBorder.top+SHADOW_INSET,
							  (self.frame.size.width - (_windowBorder.right + _windowBorder.left))-SHADOW_INSET*2,
							  (self.frame.size.height - (_windowBorder.bottom + _windowBorder.top))-SHADOW_INSET*2);
	
	_titleBarRect = CGRectMake(0+SHADOW_INSET, 0+SHADOW_INSET, self.frame.size.width-SHADOW_INSET, _windowBorder.top);

	[self _layoutWindowControlsInFrame:_titleBarRect];
	
	[self _layoutWindowContents];
	
	[self setNeedsDisplay];
}

@end
