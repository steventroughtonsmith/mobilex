//
//  MXTaskbarIconItem.m
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXTaskbarIconItem.h"

@implementation MXTaskbarIconItem

- (id) init
{
	[super init];
	_icon = [[MXImageLayer layer] init];
	[_icon setCentered:TRUE];
	return self;
}

- (void) setIcon:(MXImage*)img
{
	[_icon setImage:img];
}

- (void) addContents
{
	_iconFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
	
	[self addSublayer:_icon];
	[_icon setFrame:_iconFrame];
}

- (void) onControlTouchEndAt:(CGPoint)point
{
	_isDown = FALSE;
	[self setNeedsDisplay];
}

- (void) onControlTouchBeginAt:(CGPoint)point
{
	_isDown = TRUE;
	[self setNeedsDisplay];
}

- (void) drawInContext:(CGContextRef)ctx
{

}

- (float) itemWidth
{
	return 70;
}

@end
