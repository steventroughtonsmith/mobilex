//
//  MXApplicationController.h
//  CurrentLauncher
//
//  Created by _AAAAAAAA_ on 15/08/2006.
//  Copyright 2006 lol inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXApplication.h"
#import "MXPane.h"

#import <sys/sysctl.h>

@interface MXApplicationController : NSOperation {
	NSMutableDictionary* _applications;
	NSMutableDictionary* _appPanes;
	MXApplication* _activeApplication;
}

@property (retain) MXApplication* activeApplication;

+ (id)sharedInstance;

/* Application management */
- (void) loadApplications;
- (void) loadApplicationBundleAtPath:(NSString*)bundlePath isSystem:(BOOL)isSystem;

- (NSMutableDictionary*) allApplications;

- (MXApplication*) applicationForIdentifier:(NSString*)identifier;
- (MXApplication*) applicationForPid:(pid_t)pid;

/* App panes */
- (void) launcedApplication:(MXApplication*)app inPane:(MXPane*)pane;

/* for MXApplication */
- (NSString*) shortenApplicationName:(NSString*)fullName;

@end

