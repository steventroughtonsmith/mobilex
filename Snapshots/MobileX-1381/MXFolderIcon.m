//
//  MXFolderIcon.m
//  MobileX
//
//  Created by Nick on 18/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXFolderIcon.h"


@implementation MXFolderIcon

+ (CGSize)defaultIconSize {
    return CGSizeMake(130, 150);
}

- (id) init
{
	[super init];
	
	CGRect frame;
	frame.size = [[self class] defaultIconSize];
	frame.origin = CGPointZero;
	[self setFrame:frame];
	
	float szH = 74;
	float szW = 76;
	
	_folder = [[MXFolder alloc] init];
	[_folder setFrame:CGRectMake(lroundf(self.frame.size.width / 2 - szW / 2),
									lroundf((self.frame.size.height / 2 - szH / 2)),
									szW,
									szH)];
	[self addSublayer:_folder];
	
	return self;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame;
    frame.origin = CGPointMake(lroundf(origin.x),
							   lroundf(origin.y));
    frame.size = [[self class] defaultIconSize];
	[super setFrame:frame];
}

- (void) setIcons:(NSArray*)icons
{
	_icons = icons;
	float mx = 5;
	for (MXIcon* icon in icons)
	{
		[icon setAnchorPoint:CGPointZero];
		[icon setOrigin:CGPointMake(mx, 5)];
		[icon setTransform:CATransform3DMakeScale(0.2, 0.2, 1)];
		
		mx+=4;
		[_folder addSublayer:icon];
		[icon setNeedsDisplay];
	}
}


@end
