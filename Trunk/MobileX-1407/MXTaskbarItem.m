//
//  MXTaskbarItem.m
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXTaskbarItem.h"


@implementation MXTaskbarItem

- (id) init
{
	[super init];
	return self;
}

- (void) setFrame:(CGRect)f
{
	if ([self superlayer] != nil)
		[super setFrame:CGRectMake(f.origin.x, f.origin.y, [self itemWidth], f.size.height)];
}

- (float) itemWidth
{
	return 50;
}

@end
