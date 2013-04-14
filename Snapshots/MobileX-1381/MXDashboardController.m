//
//  MXDashboardController.m
//  MobileX
//
//  Created by Nick on 14/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXDashboardController.h"


@implementation MXDashboardController

- (id) init
{
	[super init];
	
	_layer = [[MXDashboardLayer alloc] initWithFrame:[[MXDevice currentDevice] screenSizeAsRect]];
	[_layer retain];
	
	return self;
}

- (void) toggleState
{
	if (_isShowing) {
		[_layer hide];
		_isShowing = FALSE;
	}
	else {
		[_layer show];
		_isShowing = TRUE;
	}

}

@end
