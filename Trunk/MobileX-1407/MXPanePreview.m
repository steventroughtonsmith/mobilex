//
//  MXPanePreview.m
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXPanePreview.h"
#import "MXPaneManager.h"
#import "MXColors.h"
#import "MXCG.h"

@implementation MXPanePreview

- (id) init
{
	[super init];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(setNeedsDisplay)
												 name:@"MTWindowStateChanged"
											   object:nil];
	
	return self;
}

- (void) drawPanePreviewInContext:(CGContextRef)context inRect:(CGRect)rect
{
	//CGContextSetFillColorWithColor(context, MXTHColorFill());
	CGContextAddRect(context, rect);
	CGContextFillPath(context);
	
	//CGContextSetStrokeColorWithColor(context, MXTHColorBorder1());
	CGContextAddRect(context, rect);
	CGContextStrokePath(context);
}

- (void) drawInContext:(CGContextRef)context
{
	CGContextSetShouldAntialias(context, FALSE);
	NSArray* panes = [[MXPaneManager shared] allPanes];
	CGSize glSize = [[MXPaneManager shared] screenSize];
	float w = glSize.width / self.frame.size.width;
	float h = glSize.height / self.frame.size.height;
	
	for (MXPane* p in panes)
	{
		CGRect pFr = p.frame;
		
		[self drawPanePreviewInContext:context
								inRect:CGRectMake(lroundf(pFr.origin.x / w),
												  lroundf(pFr.origin.y / h),
												  lroundf(pFr.size.width / w),
												  lroundf(pFr.size.height / h))];
	}
	
	if ([[MXPaneManager shared] activePane] != NULL)
	{
		CGRect pFr = [[MXPaneManager shared] activePane].frame;
		
		[self drawPanePreviewInContext:context
								inRect:CGRectMake(lroundf(pFr.origin.x / w),
												  lroundf(pFr.origin.y / h),
												  lroundf(pFr.size.width / w),
												  lroundf(pFr.size.height / h))];
	}
}

@end
