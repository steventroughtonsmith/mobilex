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

@interface CADisplay : NSObject {
@private
	void* _impl;
}

+(id)displays;
+(id)mainDisplay;
+(id)TVOutDisplay;
@property(readonly, nonatomic) NSString *name;
@property(readonly, nonatomic) NSString *deviceName;
@property(readonly) unsigned int displayId;
@property(readonly) NSString *uniqueId;
@property(readonly, nonatomic) NSArray *availableModes;
//@property(retain, nonatomic) CADisplayMode *currentMode;
//@property(readonly, nonatomic) CADisplayMode *preferredMode;
@property(copy, nonatomic) NSString *colorMode;
@property BOOL allowsVirtualModes;
@property(readonly, nonatomic) struct CGRect bounds;
@property(readonly) int tag;
@property(readonly, getter=isSupported) BOOL supported;
@property(readonly, getter=isExternal) BOOL external;
@property(readonly) double refreshRate;
@property(readonly, getter=isOverscanned) BOOL overscanned;
@property(readonly) float overscanAmount;
@property(copy, nonatomic) NSString *overscanAdjustment;
@property(readonly, getter=isCloned) BOOL cloned;
@property(readonly, getter=isCloningSupported) BOOL cloningSupported;
- (id)description;

@end

#import <QuartzCore/CAContext.h>

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
extern NSString* kCAWindowServerOrientation_LandscapeLeft;
- (void) _initMainLayer
{
	_mainLayer = [[MXMainLayer layer] init];
	
#if TARGET_CPU_ARM
	
	if ([[[MXDevice currentDevice] model] hasPrefix:@"AppleTV"]) {
		
		for (CAWindowServerDisplay* ds in [[CAWindowServer server] displays]) {
			if ([[ds name] isEqualToString:@"TVOut"]) {
				MSLog(@"TVoutInit: Configuring digital out for '%@'.", [ds name]);
				[ds setTVSignalType:kCAWindowServerTVSignalType_Digital];
				MSLog(@"TVoutInit: TVmode %@", [ds TVMode]);
				
				[ds setOrientation:kCAWindowServerOrientation_LandscapeLeft];
			}
		}
		
		
		CGSize res = [[MXSettingsController shared] screenResolution];
		
		res.width = 1280.0;
		res.height = 720.0;
		
		[_mainLayer setFrame:CGRectMake(0, 0, 1280., 720.)];
		
		
		[[MXDevice currentDevice] _announcedScreenSize:CGSizeMake(res.width,res.height)];
	}
	else {
		CAWindowServerDisplay* clcd = [[[CAWindowServer server] displays] objectAtIndex:0];
		[_mainLayer setFrame:CGRectMake(0, 0, [clcd bounds].size.width, [clcd bounds].size.height)];
		[[MXDevice currentDevice] _announcedScreenSize:[clcd bounds].size];
	}
#else
	[_mainLayer setFrame:CGRectMake(0, 0, 768., 1024.)];
	[[MXDevice currentDevice] _announcedScreenSize:CGSizeMake(768., 1024.)];

#endif
	
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

- (uint32_t) contextId {
	return _quartzContextId;
}


- (id) init
{
	/*
	 * Startup routine for MobileX.
	 */
	
	//patchCoreAnimation();
	
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
	
	[MXSettingsController shared];
	
	/* Rendering (Quartz or UIKit) */
	[self _initMainLayer];
	[self bootstrapRenderServer:_isUIKit];
	[self bindMainLayer:_mainLayer];
	
	/* Preinitialize controllers  */
	[MXPlatformController shared];
	
#if !TARGET_CPU_ARM
	_isUIKit = TRUE;
#endif
	if (!_isUIKit) {
		/*
		 * If we're running using UIKit, it 
		 * will register those for us.
		 */
		StartUIKitSharedImageServer();
		MXUISBSStart();
	}
	
	if ([[MXDevice currentDevice] isAppleTV]) {
		[MXLaunchdUtilities deleteJobWithLabel:@"com.apple.frontrow.hidmonitord"];
		[MXLaunchdUtilities deleteJobWithLabel:@"com.apple.frontrow"];
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
