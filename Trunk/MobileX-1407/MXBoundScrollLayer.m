//
//  MXBoundScrollLayer.m
//  WaterFountain
//
//  Created by Nick on 07/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import "MXBoundScrollLayer.h"
#import "MXColors.h"

@implementation MXBoundScrollLayer

- (void) setPosition:(CGPoint)p
{
	/* blurry scroll = annoying */
	[super setPosition:CGPointMake(lroundf(p.x), lroundf(p.y))];
}

- (BOOL) shouldAnimatePropertyForKey:(NSString *)key
{
	return TRUE;	
}

- (void) scrollToPoint:(CGPoint)point
{
	self.position = CGPointMake(point.x* -1,point.y* -1);
}

@end
