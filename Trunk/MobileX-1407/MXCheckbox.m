//
//  MXCheckbox.m
//  MobileX
//
//  Created by Nick on 05/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import "MXCheckbox.h"
#import "MXCG.h"
#import "MXUIDrawing.h"
#import "MXColors.h"

@implementation MXCheckbox

- (void) setIsChecked:(BOOL)b
{
	_isChecked = b;
	[self displayWithoutAnimation];
}

- (BOOL) isChecked
{
	return _isChecked;
}

- (void) fireActionOfType:(int)type
{
	[super fireActionOfType:type];
	
	if (type == 0)
	{
		[self setIsChecked:!_isChecked];
	}
}

- (void) drawInContext:(CGContextRef)ctx
{
	CGRect zRect = CGRectLroundf(CGRectBaseOrigin(self.frame));
	
	if ([self isChecked])
		[MXUIDrawing drawInsetElementInContext:ctx
										inRect:zRect
										color1:RGB(0.1,0.4,0.1)
										color2:RGB(0.2,0.9,0.2)
										isDown:TRUE];
	else
		[MXUIDrawing drawInsetElementInContext:ctx
										inRect:zRect
										color1:RGB(0.8,0.3,0.3)
										color2:RGB(0.4,0.2,0.2)
										isDown:FALSE];
	
}

@end
