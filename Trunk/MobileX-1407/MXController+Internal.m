//
//  MXController+Internal.m
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXController+Internal.h"
#import "SBSpringBoardServicesMachServer.h"
#import "MXApplication.h"
#import "MXIOTools.h"
#import "MXApplicationStateServices.h"
#import "MXVNCController.h"

#import <QuartzCore/CAContext.h>
#import <Foundation/NSTask.h>

#import "MXSystemMenu.h"
#import "uiKitProxy.h"

@implementation MXController (MXCInternal)

- (void) _initAppUI
{
	_uiController = [[MXUIController alloc] initWithLayer:_mainLayer];
}

- (void) _checkApplications {
	BOOL hasAtLeastOneAppRunning = FALSE;
	NSDictionary* apps = [[MXApplicationController sharedInstance] allApplications];
	
	for (NSString* app in apps) {
		if ([[apps objectForKey:app] isRunning]) {
			hasAtLeastOneAppRunning = TRUE;
			break;
		}
	}
	
	if (!hasAtLeastOneAppRunning) {
		[self reportError:@"Launchpad isn't running. Make sure 'Bundles.plist' has at least one autorun app in it and it isn't crashing."];
	}
}

- (void) _autoLaunchRequiredApplications
{
	if (![MXSettingsController boolForKey:XXX_SUPRESSAUTOLAUNCH]) {
		for (NSString* identifier in _autoLaunchQueue)
		{
			MXLaunchApplicationWithIdentifier(identifier);
		}
	}
	
	[NSTimer scheduledTimerWithTimeInterval:4.0
									 target:self
								   selector:@selector(_checkApplications)
								   userInfo:nil
									repeats:FALSE];
}

- (void) bindMainLayer:(CALayer*)layer {
	if (_quartzContext) {
		[(CAContext*)_quartzContext setLayer:layer];
	}
	else {
		NSLog(@"Bind.");
	}
	
	[layer setNeedsDisplay];
}

- (void) _uiKitThread {
	/* start UIKit */
	uiKitProxyStart();
}

extern NSString* kCAContextDefinesDisplayBounds;

- (void) bootstrapRenderServer:(BOOL)useUIKit {
	if (useUIKit) {
		/*
		 * Hm.
		 *
		 * This runs a UIApplication proxy which then
		 * hosts our main layer. This solves most of
		 * image sharing / statusbar issues but fucks up
		 * lots of other stuff because this wasn't designed
		 * to be run with UIKit. I might make it compatible at some
		 * point in the future.
		 *
		 * Don't use this.
		 */
		
		[NSThread detachNewThreadSelector:@selector(_uiKitThread)
								 toTarget:self
							   withObject:nil];
	}
	else {
		/* start quartz */
		
		CAContext* thisContext;
		
		[CAContext setClientPort:GSGetPurpleApplicationPort()];
		
		if ([[[MXDevice currentDevice] model] hasPrefix:@"AppleTV"]) {
			/* do special init for ATV */
			[CAWindowServer server];
			
			if (!XXBoolForKey(XXX_NOATVSCALER)) {
				MXSLog(@"TVout windowserver init.");
				
				thisContext = 
				[CAContext localContextWithOptions:[NSDictionary dictionaryWithObjectsAndKeys:
													(id)kCFBooleanTrue,kCAContextDefinesDisplayBounds,
													nil]];
			}
			else {
				MXSLog(@"TVout windowserver init [noscaler].");
				
				thisContext = 
				[CAContext localContextWithOptions:[NSDictionary dictionaryWithObjectsAndKeys:
													(id)kCFBooleanFalse,kCAContextDefinesDisplayBounds,
													nil]];
			}
			
			//CAContext* definingContext = thisContext;
			/*[thisContext setLevel:0];
			[thisContext setLayer:[[CALayer alloc] initWithFrame:CGRectMake(-40,
																			-40,
																			[[MXSettingsController shared] screenResolution].width+80, 
																			[[MXSettingsController shared] screenResolution].height+80)]];
			
			[[thisContext layer] setBackgroundColor:RGB(1, 0, 0)];
			
			
			thisContext = [CAContext remoteContext];
			[thisContext setLevel:1];*/
			[thisContext setLevel:5];
		}
		else {
			/* normal CLCD */
			[CAWindowServer server];
			
			MXSLog(@"CLCD windowserver init.");
			
			thisContext = 
			[CAContext localContext];
		}
		
		_quartzContextId = [thisContext contextId];
		_quartzContext = thisContext;
		
		
	}
}

- (void) applicationDidFinishLaunching
{
	/* kill the semi-dead UIkit apps */
	for (NSString* label in [MXLaunchdUtilities allJobLabels])
	{
		if ([label hasPrefix:@"UIKitApplication:"])
		{
			[MXLaunchdUtilities deleteJobWithLabel:label];
		}
	}
	
	/* Announce */
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
										 CFSTR("SBSpringBoardDidLaunchNotification"),
										 NULL,
										 NULL,
										 0); 
	
	MXIOMarkBootComplete();
	
	/* Load applications */
	[[MXApplicationController sharedInstance] loadApplications];
	
	/* Start the UI */
	[self _initAppUI];
	
	/* Preferences */
	[MXPreferencesWindowController shared];

	[self _autoLaunchRequiredApplications];
	
	if (XXBoolForKey(XXX_ENABLEVNCSERVER)) {
		[MXVNCController shared];
	}
	
	
	[WifiManager sharedInstance];
	[MXSystemMenu shared];
}

- (void) startSpringBoard
{
	if ([[NSFileManager defaultManager] fileExistsAtPath:[[NSBundle mainBundle] executablePath]])
	{
		/* start self with -s argument */
		NSTask* t = [[NSTask alloc] init];
		[t setLaunchPath:[[NSBundle mainBundle] executablePath]];
		[t setArguments:[NSArray arrayWithObject:@"-s"]];
		[t launch];
	}
}

- (void) activateRenderLayer:(MXRenderLayer*)layer
{
	_activeRenderer = layer;
}

- (void) _initializationFinished
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	[self applicationDidFinishLaunching];
	
	[pool release];
}

@end
