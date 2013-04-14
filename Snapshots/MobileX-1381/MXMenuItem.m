//
//  MXMenuItem.m
//  MobileX
//
//  Created by Nick on 08/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXMenuItem.h"
#import "MXCG.h"
#import "MXColors.h"
#import "MXUIDrawing.h"

@implementation MXMenuItem

@synthesize caption=_caption;

+ (id) menuItemWithCaption:(NSString*)caption
{
	MXMenuItem* item = [[MXMenuItem alloc] init];
	[[item caption] setText:caption];
	return item;
}

+ (id) menuItemWithCaption:(NSString*)caption
					target:(id)target
					action:(SEL)action
{
	MXMenuItem* item = [MXMenuItem menuItemWithCaption:caption];
	[item addTarget:target action:action];
	return item;
}

- (id) init
{
	[super init];
	
	[self removeAllAnimations];
	
	_caption = [MXText text:@"" inRect:CGRectBaseOrigin(self.frame)];
	[_caption setFont:[MXFont regularFontWithFamily:@"Helvetica" size:16]];
	[_caption retain];
	
	[self addSublayer:_caption];
	
	return self;
}

- (void) addContents
{
	[_caption setFrame:CGRectBaseOrigin(self.frame)];
}

- (void) drawInContext:(CGContextRef)context
{
	CGRect zRect = CGRectBaseOrigin(self.frame);
	
	CGContextSetFillColorWithColor(context, WHTA(0,0));
	CGContextFillRect(context,zRect);
	
	if (_isDown)
	{
		[MXUIDrawing drawLinearGradientInContext:context
										  inRect:zRect
										  color1:WHT(0.5)
										  color2:WHT(0.4)];
	}
}

- (void) onControlTouchEndAt:(CGPoint)point
{
	_isDown = FALSE;
	[self setNeedsDisplay];
	[_caption setColor:WHT(0)];
}

- (void) onControlTouchBeginAt:(CGPoint)point
{
	_isDown = TRUE;
	[self setNeedsDisplay];
	[_caption setColor:WHT(1)];
}

@end
