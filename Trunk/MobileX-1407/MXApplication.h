/*
 
 # MXApplication
 # SpringBoardSupport
 
 This is the main class responsible for UIKit applications.
 It represents one application bundle.
 It also provides the essential services for app management.
 
*/

#import <Foundation/Foundation.h>
#import "MXLaunchdUtilities.h"
#import "MXBundle.h"
#import "MXProcess.h"

/* Mach stuff */
#import <mach/mach.h>
#import "MXImage.h"

@interface MXApplication : NSObject {
	
	/* CF Values */
	NSString *_bundleIdentifier;
    NSString *_displayIdentifier;
    NSString *_path;
    NSString *_iconFileName;
    NSString *_bundleVersion;
    NSString *_longDisplayName;
	NSString *_displayName;
	MXBundle *_bundle;
	NSString *_applicationServiceName;
	NSString *_applicationUIServiceName;
	NSString *_logPath;
	
	/* SB Values */
	NSArray *_machServices;
	BOOL _isSystemApplication;
	BOOL _isHidden;
	
	/* MX Values */
	NSDictionary *_checkInRecord;
	
	/* App Support */
	MXProcess* _process;
	
	mach_port_t _clientPort;
	mach_port_t _serverPort;
	mach_port_t _eventPort; /* cached event port */

	BOOL _isUIKit;
	int _activationCount;

	uint32_t _watchdogMisses;
	
	BOOL _isRunning;
	BOOL _isStarting;
	BOOL _isSuspended;
	
	BOOL _isAnonymous;
	
	BOOL _watchDogFiredOnce;
	
	NSTimer *_watchDogTimer;
	
	unsigned _contextId;
	
	id _delegate;
	
	BOOL _isClassic;
}

@property (retain) NSString *displayName;
@property (readonly) NSString *longDisplayName;
@property (readonly) NSString *bundleIdentifier;
@property (readonly) MXBundle *bundle;
@property (assign) unsigned contextId;
@property (readonly) MXProcess* process;
@property (assign) id delegate;
@property (assign) BOOL isHidden;
@property (readonly) NSDictionary* checkInRecord;

@property (assign) BOOL isClassic;

@property (readonly) BOOL isSuspended;

- (NSString*) pathForIcon;
- (BOOL) hasPrerenderedIcon;

- (id) _initEmptyApplication:(NSString*)displayName;
- (id) initWithBundle:(MXBundle*)bundle
				 path:(NSString*)path
			 roleInfo:(NSDictionary*)role
  isSystemApplication:(BOOL)isSystem;

- (void) loadCheckInRecord:(NSDictionary*)dict;

- (void) launch;
- (void) activate;
- (void) suspend;
- (void) resume;
- (void) kill;

- (void) sendSimpleEventOfType:(int)type;
- (void) setOrientation:(int)orientation;

- (mach_port_t) eventPort;

- (void) _watchDogTimerFired;
- (void) _invalidateWatchDogTimer;
- (void) _startWatchDogTimer;

- (void) setFrontmost:(BOOL)frontmost;
- (MXImage *)iconImage;

- (BOOL) isRunning;

- (NSDictionary*) serialize;

@end

@interface NSObject (MXApplicationDelegate)

- (void) applicationExited:(MXApplication*)application;
- (void) applicationSuspended:(MXApplication*)application;
- (void) applicationResumed:(MXApplication*)application;
- (void) applicationActivated:(MXApplication*)application;
- (void) application:(MXApplication*)application failedToLaunchWithError:(int)error;

@end
