/*
 
 Rendered close cross used for different purposes.
 
 */

#import "MXCloseCross.h"

#define INSET 2
#define LINSET 9

@implementation MXCloseCross

@synthesize obj=_obj;

- (id) init
{
	[super init];
	
	_darkFilter = [[CAFilter alloc] initWithName:kCAFilterMultiplyColor];
	[_darkFilter setValue:(id)WHT(0.5) forKey:@"inputColor"];
	
	return self;
}

- (void) onControlTouchBeginAt:(CGPoint)point
{
	[CATransaction begin];
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
	[self setFilters:[NSArray arrayWithObject:_darkFilter]];
	[CATransaction commit];
}

- (void) onControlTouchEndAt:(CGPoint)point
{
	[CATransaction begin];
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
	[self setFilters:nil];
	[CATransaction commit];
}

- (void) drawInContext:(CGContextRef)context
{
	CGRect zRect = CGRectBaseOrigin(self.frame);
	
	zRect = CGInsetRect(zRect, CROSS_SHADOW_INSET);
	
	CGContextSaveGState(context);
	CGContextSetShadowWithColor(context,
								CGSizeMake(0, 0),
								5,
								WHT(0));
	
	CGContextSetFillColorWithColor(context, WHT(1));
	CGContextAddEllipseInRect(context, zRect);
	CGContextFillPath(context);
	
	CGContextRestoreGState(context);
	
	CGRect insRect = CGInsetRect(zRect, INSET);
	CGContextSetFillColorWithColor(context, WHT(0));
	CGContextAddEllipseInRect(context, insRect);
	CGContextFillPath(context);
	
	float offset = 5;
	float linset = LINSET;
	
	CGPoint l1s = CGPointMake(0+linset+offset, 0+linset+offset);
	CGPoint l1f = CGPointMake(zRect.size.height-linset+offset, zRect.size.width-linset+offset);
	
	CGPoint l2s = CGPointMake(zRect.size.height-linset+offset, 0+linset+offset);
	CGPoint l2f = CGPointMake(0+linset+offset, zRect.size.width-linset+offset);
	
	CGContextSetStrokeColorWithColor(context, WHT(1));
	CGContextSetLineCap(context, kCGLineCapRound);
	CGContextSetLineWidth(context, 3);
	
	CGContextMoveToPoint(context, l1s.x, l1s.y);
	CGContextAddLineToPoint(context, l1f.x, l1f.y);
	CGContextStrokePath(context);
	
	CGContextMoveToPoint(context, l2s.x, l2s.y);
	CGContextAddLineToPoint(context, l2f.x, l2f.y);
	CGContextStrokePath(context);
}


@end
