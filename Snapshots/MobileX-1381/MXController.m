//
//  MXController.m
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXController.h"

#import "MXKit.h"

#import "MXController+Internal.h"
#import "MXController+EventHandling.h"
#import "MXWindow.h"
#import "MXTaskbar.h"

#import "MXHostWindow.h"
#import "MXPanePreview.h"

#import "CARenderServer.h"

#import <IOSurface/IOSurfaceAPI.h>
#import "MXUIKitSharedImageServer.h"

#import "MXRemoteProcedureCalls.h"
#import "MXUIStatusBarServer.h"
#import "MXApplicationStateServices.h"
#import "SBSpringBoardServicesMachServer.h"

static id _shinst = NULL;

@implementation MXController

+ (id) shared
{
	if (_shinst==NULL)
	{
		_shinst = [MXController alloc];
		[_shinst init];
	}
	
	return _shinst;
}

- (void) launchApplicationForIdentfier:(NSString*)identifier
{
	MXLaunchApplicationWithIdentifier(identifier);
}

- (id) activeRenderer
{
	return _activeRenderer;
}

extern NSString* kCAWindowServerTVSignalType_Digital;

- (void) _initMainLayer
{
	_mainLayer = [[MXMainLayer layer] init];
	
	if ([[[MXDevice currentDevice] model] hasPrefix:@"AppleTV"]) {
		for (CAWindowServerDisplay* ds in [[CAWindowServer server] displays]) {
			if ([[ds name] isEqualToString:@"TVOut"]) {
				MSLog(@"TVoutInit: Configuring digital out for '%@'.", [ds name]);
				[ds setTVSignalType:kCAWindowServerTVSignalType_Digital];
			}
		}
		
		[_mainLayer setFrame:CGRectMake(0, 0, 1280, 768)];
		[[MXDevice currentDevice] _announcedScreenSize:CGSizeMake(1280, 768)];
	}
	else {
		CAWindowServerDisplay* clcd = [[[CAWindowServer server] displays] objectAtIndex:0];
		[_mainLayer setFrame:CGRectMake(0, 0, [clcd bounds].size.width, [clcd bounds].size.height)];
		[[MXDevice currentDevice] _announcedScreenSize:[clcd bounds].size];
	}
	
	[_mainLayer setBackgroundColor:RGB(0.05,0.05,0.05)];
	[_mainLayer removeAllAnimations];
	
	[_mainLayer retain];
}

void MXGSEvent(GSEventRef event)
{	
	[[MXController shared] handleEvent:event];
}

- (void) pushAutoLaunchIdentifier:(NSString*)identifier
{	
	[_autoLaunchQueue addObject:identifier];
}

- (id) mainLayer
{
	return _mainLayer;
}

- (MXUIController*) uiController
{
	return _uiController;
}

- (void) reportError:(NSString*)message {
	if (_mainLayer) {
		MXSLog(@" *** Error: %@", message);
		[_mainLayer setError:message];
	}
	else {
		MXSLog(@" *** Error (NoUI): %@", message);
	}
}

- (id) init
{
	/*
	 * Startup routine for MobileX.
	 */
	
	if (!(self = [super init])) {
		MXSLog(@"self = [super init] failed. Bailing out.");
		exit(0);
	}

	_autoLaunchQueue = [NSMutableArray new];
	_isUIKit = FALSE;
	
	/* Remote port cache for event dispatcher */
	MXPortCacheStart();
	
	/* RPC */
	MXRPCStart();
	SBStartMiGServer();
	
	/* MXKit initialization */
	[MXFont _initFontCache];
	
	/* Rendering (Quartz or UIKit) */
	[self _initMainLayer];
	[self bootstrapRenderServer:_isUIKit];
	[self bindMainLayer:_mainLayer];
	
	/* Preinitialize controllers  */
	[MXPlatformController shared];
	[MXSettingsController shared];
	
	if (!_isUIKit) {
		/*
		 * If we're running using UIKit, it 
		 * will register those for us.
		 */
		StartUIKitSharedImageServer();
		MXUISBSStart();
	}
	
	/* Event handling engine*/
	GSInitialize();
	GSEventInitialize(TRUE);
	GSEventRegisterEventCallBack(MXGSEvent);
	MXHIDStart();
	
	[self _initializationFinished];
	
	CFRunLoopRun();
	
	return self;
}

@end
