//
//  MXButton.m
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXButton.h"
#import "MXCG.h"
#import "MXUIDrawing.h"
#import "MXColors.h"

@implementation MXButton

- (id) init
{
	[super init];
	_caption = [[MXText alloc] init];
	[_caption setColor:WHT(0)];
	[_caption setSize:14];
	[self removeAllAnimations];
	[self setMasksToBounds:FALSE];
	return self;
}

- (id) text
{
	return [_caption text];
}

- (void) setText:(NSString *)t
{
	[_caption setText:t];
}

- (void) onControlTouchEndAt:(CGPoint)point
{
	_isDown = FALSE;
	[self displayWithoutAnimation];
}

- (void) onControlTouchBeginAt:(CGPoint)point
{
	_isDown = TRUE;
	[self displayWithoutAnimation];
}

- (void) addContents
{
	[_caption setFrame:CGRectBaseOrigin(self.frame)];
	[self addSublayer:_caption];
}

- (void) drawInContext:(CGContextRef)ctx
{
	CGRect zRect = CGRectLroundf(CGRectBaseOrigin(self.frame));
	
	if (_isDown)
		[MXUIDrawing drawInsetElementInContext:ctx
										inRect:zRect
										color1:WHT(0.5)
										color2:WHT(0.8)
										isDown:TRUE];
	else
		[MXUIDrawing drawInsetElementInContext:ctx
										inRect:zRect
										color1:WHT(0.9)
										color2:WHT(0.6)
										isDown:FALSE];

}

@end
