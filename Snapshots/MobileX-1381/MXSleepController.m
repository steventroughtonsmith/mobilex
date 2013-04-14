//
//  MXSleepController.m
//  MobileX
//
//  Created by Nick on 14/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXSleepController.h"
#import "MXHIDController.h"
#import "MXQuartzWindowServer.h"

static id _shinst = NULL;

@implementation MXSleepController

+ (id) shared
{
	if (_shinst==NULL)
	{
		_shinst = [MXSleepController alloc];
		[_shinst init];
	}
	
	return _shinst;
}

- (void) _disableSoftSleep
{
	MXHIDSetDisplayBrightness(_savedBrightness);
	
	MXHIDSetUILocked(FALSE);
	MXQuartzSetCABlanked(FALSE);
}

- (void) _enableSoftSleep
{
	_savedBrightness = MXHIDGetDisplayBrightness();
	MXHIDSetDisplayBrightness(0);
	
	MXHIDSetUILocked(TRUE);
	MXQuartzSetCABlanked(TRUE);
}

- (void) sleep
{
	_isSleeping = TRUE;
	
	[self _enableSoftSleep];
}

- (void) wake
{
	_isSleeping = FALSE;
	
	[self _disableSoftSleep];
}

- (void) toggleSleepState
{
	if (_isSleeping) {
		[self wake];
	}
	else {
		[self sleep];
	}

}

@end
