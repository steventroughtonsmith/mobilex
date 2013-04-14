//
//  MXDashboardLayer.m
//  MobileX
//
//  Created by Nick on 14/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXDashboardLayer.h"
#import <QuartzCore/CAFilter.h>

@implementation MXDashboardLayer

- (id) init
{
	[super init];
	
	[self setBackgroundColor:WHTA(0,0.5)];
	
	CAFilter* blur = [CAFilter filterWithName:kCAFilterGaussianBlur];
	[blur setValue:[NSNumber numberWithInt:2] forKey:@"inputRadius"];
	[self setBackgroundFilters:[NSArray arrayWithObject:blur]];
	
	return self;
}

- (BOOL) shouldDisplayOnRegister {
	return FALSE;
}

- (BOOL) shouldForceTopmost {
	return TRUE;
}

@end
