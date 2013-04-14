//
//  MXHostWindow.m
//  MobileX
//
//  Created by Nick on 02/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import "MXHostWindow.h"
#import "MXPortCache.h"
#import "MXSettingsController.h"

@implementation MXHostWindow

@synthesize application=_application;
@synthesize isFullscreen=_isFullscreen;
@synthesize fixed=_fixed;

- (void) setIsFullscreen:(BOOL)fs
{
	if (fs) {
		[self setBorderStyle:kMXWindowStyleBorderless];
	}
	else {
		[self setBorderStyle:kMXWindowStyleNormal];
	}
	
	[_hostedLayer setIsFullscreen:fs];
	_isFullscreen = fs;
}

- (MXRenderLayer*) renderLayer
{
	return _hostedLayer;
}

- (void) setApplication:(MXApplication *)app
{
	_application = app;
	[_application setDelegate:self];
}

- (void) hostLayer:(id)layer
{
	if ([layer isKindOfClass:[MXRenderLayer class]])
	{
		[super hostLayer:layer];
	}
	else 
	{
		NSLog(@" *** A host window cannot host a layer other than a render layer.");
	}
}

- (BOOL) isFixed
{
	return _fixed;
}

- (void) close
{
	if ([MXSettingsController boolForKey:XXX_SUSPENDONCLOSE] && !_isInExpose)
	{
		NSLog(@"Suspending %@.",_application);
		[_hostedLayer willSuspend];
		[_application sendSimpleEventOfType:2005];
		[_application suspend];
		[self minimize];
	}
	else {
		NSLog(@"Killing %@.",_application);
		[_application kill];
	}
}

- (void) applicationSuspended:(MXApplication*)application
{
	[_hostedLayer suspended];
}

- (void) applicationResumed:(MXApplication*)application
{
	[_hostedLayer resumed];
}

- (void) application:(MXApplication *)application failedToLaunchWithError:(int)error
{
	[self unregister];
}

- (void) fireActionOfType:(int)type
{
	[super fireActionOfType:type];
}

- (void) paneActivated
{
	[super paneActivated];
	[_application setFrontmost:TRUE];
	
	if ([_application isSuspended]) {
		[_application resume];
	}
}

- (void) paneDeactivated
{
	[super paneDeactivated];
	[_application setFrontmost:FALSE];
}

- (void) applicationActivated:(MXApplication *)application
{
	[self show];
	MXPortCacheCheckIn([application eventPort], self);
	
	/* Force activation */
	[self activate];
}

- (void) applicationExited:(MXApplication *)application
{
	[self unregister];
}

@end
