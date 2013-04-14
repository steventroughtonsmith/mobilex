//
//  MXTaskbar.m
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXTaskbar.h"
#import "MXUIDrawing.h"

@implementation MXTaskbar

- (id) init
{
	[super init];
	_items = [NSMutableArray new];
	return self;
}

- (void) addItem:(MXTaskbarItem*)item
{
	[_items addObject:item];
	[self addSublayer:item];
	
	[item setFrame:CGRectMake(0, 0, 0, self.frame.size.height - 2)];
	[item addContents];
}

- (void) layoutItems
{
	float sumOfSize = 20;
	for (MXTaskbarItem* item in _items)
	{
		[item setFrame:CGRectMake(sumOfSize, -15, 0, self.frame.size.height - 2)];
		[item setNeedsDisplay];
		sumOfSize += item.frame.size.width;
	}
}

- (void) drawInContext:(CGContextRef)context
{
	CGRect shelfRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 5.5);
	CGRect sideShelfRect = CGRectMake(0, self.frame.size.height - 5.5, self.frame.size.width, 5.5);
	CGRect glossRect = CGRectMake(0, (shelfRect.size.height / 2)*-1, shelfRect.size.width, shelfRect.size.height);
	
	CGContextSetStrokeColorWithColor(context, RGB(1,0,0));
	
	CGContextSaveGState(context);
	
	/* Dock Top Path */
	CGContextMoveToPoint(context, shelfRect.origin.x, shelfRect.size.height);
	CGContextAddLineToPoint(context, 20, shelfRect.origin.y);
	CGContextAddLineToPoint(context, shelfRect.size.width - 20, shelfRect.origin.y);
	CGContextAddLineToPoint(context, shelfRect.size.width , shelfRect.size.height);
	CGContextAddLineToPoint(context, shelfRect.origin.x, shelfRect.size.height);
	
	CGContextClip(context);
	
	/* Gradient */
	[MXUIDrawing drawLinearGradientInContext:context
									  inRect:shelfRect
									  color1:WHT(0.3)
									  color2:WHT(0.8)];
	
	/* Gloss */
	CGContextSetFillColorWithColor(context, WHTA(1,0.1));
	CGContextAddEllipseInRect(context, glossRect);
	CGContextFillPath(context);
	
	CGContextRestoreGState(context);
	
	CGContextAddRect(context, sideShelfRect);
	CGContextSetFillColorWithColor(context, WHT(0.6));
	CGContextFillPath(context);
}

@end
