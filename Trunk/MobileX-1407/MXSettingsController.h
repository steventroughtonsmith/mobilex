//
//  MXSettingsController.h
//  MxWmSrvApp
//
//  Created by Nick on 04/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * I don't know why the 'XXX'.
 * I just wanted a unique prefix for code completion.
 * 'XXX' seems unique enough.
 * Sorry if the project management thing complains.
 */

#define XXX_WALLPAPER @"MXWallpaper"
#define XXX_FULLSCREENAPPS @"MXFullScreenApps"
#define XXX_LOGAPPS @"MXEnableApplicationLogging"
#define XXX_SUSPENDONCLOSE @"MXSuspendOnClose"
#define XXX_SUPRESSAUTOLAUNCH @"MXSupressAutolaunch"
#define XXX_APPENVVARS @"MXCustomAppEnvVars"
#define XXX_ENABLEVNCSERVER @"MXEnableVncServer"

#define XXX_NOATVSCALER @"MXAtvDisableScaler"
#define XXX_RESOLUTIONW @"MXAtvResolutionWidth"
#define XXX_RESOLUTIONH @"MXAtvResolutionHeight"

#define CF_TRUE (id)kCFBooleanTrue
#define CF_FALSE (id)kCFBooleanFalse

/* shortcuts */
#define XXSettings [MXSettingsController shared]
#define XXBoolForKey(x) [[MXSettingsController shared] boolForKey:x]
#define XXObjForKey(x) [[MXSettingsController shared] objectForKey:x]

@interface MXSettingsController : NSObject {
	NSMutableDictionary* _settings;
}

+ (id) shared;

- (void) setObject:(id)object forKey:(id)key;

- (id) objectForKey:(id)key;
- (BOOL) boolForKey:(id)key;

+ (id) objectForKey:(id)key;
+ (BOOL) boolForKey:(id)key;

- (CGSize) screenResolution;

@end
