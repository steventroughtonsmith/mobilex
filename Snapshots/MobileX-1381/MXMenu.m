//
//  MXMenu.m
//  MobileX
//
//  Created by Nick on 08/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXMenu.h"
#import "MXCG.h"
#import "MXColors.h"

@implementation MXMenu

- (id) initWithFrame:(CGRect)f
{
	[super initWithFrame:f];
	
	_items = [NSMutableArray new];
	[_items retain];
	
	return self;
}

- (BOOL) shouldDisplayOnRegister
{
	return FALSE;
}

- (void) layoutItems
{
	float initialOffset = 5;
	float yOffset = initialOffset;
	
	for (MXMenuItem* item in _items) {
		if ([item superlayer] == nil) {
			[self addSublayer:item];
			[item setFrame:CGRectMake(0,
									  yOffset,
									  self.frame.size.width,
									  50)];
		}
		
		[item addContents];
		[item setNeedsDisplay];
		yOffset += item.frame.size.height;
	}
	
	[self setFrame:CGRectMake(self.frame.origin.x,
							  self.frame.origin.y,
							  self.frame.size.width,
							  yOffset+initialOffset)];
}

- (void) addItem:(id)item
{
	[_items addObject:item];
	[self layoutItems];
}

- (void) drawInContext:(CGContextRef)context
{
	CGRect zRect = CGRectBaseOrigin(self.frame);
	
	CGContextSetFillColorWithColor(context, WHT(0.9));
	CGContextAddRoundedRect(context, zRect, 10);
	CGContextFillPath(context);
	
	CGContextSetStrokeColorWithColor(context, WHT(0.6));
	CGContextAddRoundedRect(context, zRect, 10);
	CGContextStrokePath(context);
}


@end
