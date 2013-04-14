//
//  MXTaskbarPanePreviewItem.m
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXTaskbarPanePreviewItem.h"


@implementation MXTaskbarPanePreviewItem

- (id) init
{
	[super init];
	_preview = [[MXPanePreview layer] init];
	[_preview retain];
	return self;
}

- (void) addContents
{
	[self addSublayer:_preview];
	[_preview setFrame:CGInsetRect(CGRectBaseOrigin(self.frame),1)];
	[_preview setNeedsDisplay];
}

- (void) drawInContext:(CGContextRef)ctx
{

}

- (float) itemWidth
{
	return 70;
}

@end
