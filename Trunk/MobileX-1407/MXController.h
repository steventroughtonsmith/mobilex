//
//  MXController.h
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MXMainLayer.h"
#import "MXRenderLayer.h"
#import "MXPortCache.h"

#import "MXUIController.h"
#import "MXSleepController.h"
#import "MXDesktopController.h"
#import "MXPlatformController.h"
#import "MXSettingsController.h"
#import "MXApplicationController.h"
#import "MXPreferencesWindowController.h"

#import "MXPaneManager.h"
#import "MXPaneManager+Expose.h"
#import "MXPaneManager+Reveal.h"

#import "WifiManager.h"

@interface MXController : NSObject {
	MXMainLayer* _mainLayer;
	MXRenderLayer* _activeRenderer;
	MXUIController* _uiController;
	
	NSMutableArray* _autoLaunchQueue;
	
	id _quartzContext;
	uint32_t _quartzContextId;
	BOOL _isUIKit;
}

+ (id) shared;

- (id) mainLayer;
- (id) activeRenderer;
- (MXUIController*) uiController;
- (uint32_t) contextId;

- (void) pushAutoLaunchIdentifier:(NSString*)identifier;
- (void) launchApplicationForIdentfier:(NSString*)identifier;

- (void) reportError:(NSString*)message;

@end
