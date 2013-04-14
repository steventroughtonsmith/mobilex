/*
 
 # MXApplication
 # SpringBoardSupport
 
 This is the main class responsible for UIKit applications.
 It represents one application bundle.
 It also provides the essential services for app management.
 
 */

#import "BootstrapServices.h"

#import "MXApplication.h"
#import "MXApplicationController.h"
#import "MXSettingsController.h"

#import <GraphicsServices/GraphicsServices.h>

@implementation MXApplication

@synthesize displayName=_displayName;
@synthesize bundle=_bundle;
@synthesize bundleIdentifier=_bundleIdentifier;
@synthesize longDisplayName=_longDisplayName;
@synthesize contextId=_contextId;
@synthesize process=_process;
@synthesize delegate=_delegate;
@synthesize isHidden=_isHidden;
@synthesize isClassic=_isClassic;
@synthesize isSuspended=_isSuspended;

- (NSDictionary*) serialize
{
	id icon = [self pathForIcon];
	
	if (icon == nil)
		icon = @"";
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			_bundleIdentifier,@"BundleIdentifier",
			_displayName,@"DisplayName",
			icon,@"IconPath",
			[NSNumber numberWithBool:[self hasPrerenderedIcon]],@"HasPrerenderedIcon",
			[NSNumber numberWithBool:_isRunning],@"IsRunning",
			[NSNumber numberWithBool:_isHidden],@"IsHidden",
			[NSNumber numberWithBool:_isSystemApplication],@"IsSystemApplication",
			nil];
}

- (BOOL) bundleHasFile:(NSString*)file
{
	BOOL hasFile = ([[NSFileManager defaultManager] fileExistsAtPath:[_path stringByAppendingPathComponent:file]]);
	return hasFile;
}

- (MXImage *)iconImage {
	MXImage *icon = [[MXImage alloc] init];
	[icon loadImageAtPath:[self pathForIcon]];
	return [icon autorelease];
}

- (NSString*) _displayNameForDictionary:(NSDictionary*)dict
{
	NSString* displayName = [dict objectForKey:@"UIRoleDisplayName"];
	
	if (displayName == nil || [displayName isEqualToString:@""])
		displayName = [dict objectForKey:@"CFBundleDisplayName"];
	
	if (displayName == nil || [displayName isEqualToString:@""])
		displayName = [dict objectForKey:@"CFBundleName"];
	
	if (displayName == nil || [displayName isEqualToString:@""])
		displayName = [dict objectForKey:@"CFBundleExecutable"];
	
	if (displayName == nil || [displayName isEqualToString:@""])
		displayName = @"Unknown";
	
	return displayName;
}

- (NSDictionary*) checkInRecord
{
	return _checkInRecord;
}
	
- (void) loadCheckInRecord:(NSDictionary*)dict
{
	_checkInRecord = dict;
	[_checkInRecord retain];
}

#define VERIFY_CLASS(key,_class) if ([dict objectForKey:key] != nil) {\
if ([[dict objectForKey:key] isKindOfClass:[_class class]]) {} else {\
MSLog(@"%@: Key '%@' isn't of correct type (%@ instead of %@)",self,key,[[dict objectForKey:key] class],[_class class]);\
return FALSE;\
}}

- (BOOL) _verifyInfoDictionary:(NSDictionary*)dict
{
	VERIFY_CLASS(@"DisplayIdentifier",NSNumber);
	VERIFY_CLASS(@"CFBundleIconFiles",NSArray);
	VERIFY_CLASS(@"MXCheckIn",NSDictionary);
	VERIFY_CLASS(@"UIJetsamPriority",NSNumber);
	VERIFY_CLASS(@"CFBundleIconFile",NSString);
	
	return TRUE;
}

- (void) _loadInfoDictionary:(NSDictionary*)dict
{
	/**** Display Name ****/
	_displayName = [self _displayNameForDictionary:dict];
	
	/**** Icon ****/
	if (!_isSystemApplication)
	{
		/* AppStore applications are more standartized */
		if ([dict objectForKey:@"CFBundleIconFiles"] != nil)
		{
			NSArray* iconFiles = [dict objectForKey:@"CFBundleIconFiles"];
			
			if ([iconFiles count] > 1) {
				_iconFileName = [iconFiles objectAtIndex:1];
			}
			else if ([iconFiles count] == 1) {
				_iconFileName = [iconFiles objectAtIndex:0];
			}				
		}
		else if ([dict objectForKey:@"CFBundleIconFile"] != nil)
		{
			_iconFileName = [dict objectForKey:@"CFBundleIconFile"];
		}
	}
	else 
	{
		if ([dict objectForKey:@"Role"] != nil)
		{
			/* See if we can load the role icon */
			NSString* roleIcon = [NSString stringWithFormat:@"icon-%@.png",[dict objectForKey:@"Role"]];
			NSString* roleIcon72 = [NSString stringWithFormat:@"icon-%@-72.png",[dict objectForKey:@"Role"]];
			
			if ([self bundleHasFile:roleIcon72])
				_iconFileName = roleIcon72;
			else if ([self bundleHasFile:roleIcon])
				_iconFileName = roleIcon;
		}
	}
	
	/* Now try common paths */
	if (_iconFileName == nil)
	{
		/* no role or no role icon */
		if ([self bundleHasFile:@"icon-72.png"])
			_iconFileName = @"icon-72.png";
		else if ([self bundleHasFile:@"icon.png"])
			_iconFileName = @"icon.png";
		else if ([self bundleHasFile:@"Icon-72.png"])
			_iconFileName = @"Icon-72.png";
		else if ([self bundleHasFile:@"Icon.png"])
			_iconFileName = @"Icon.png";
		else
			_iconFileName = NULL;
	}
	
	[_iconFileName retain];
	
	if ([dict objectForKey:@"MXCheckIn"] != nil) {
		[self loadCheckInRecord:[dict objectForKey:@"MXCheckIn"]];
	}
}

- (void) setFrontmost:(BOOL)frontmost
{
	if (frontmost)
	{
		[_process setPriority:1];
	}
	else 
	{
		/* throttle down UI */
		[_process setPriority:-1];
	}
}

- (id) _initEmptyApplication:(NSString*)displayName
{
	_displayName = displayName;
	_bundleIdentifier = [@"com.mx.test." stringByAppendingFormat:@"%d",arc4random()];
	_isSystemApplication = FALSE;
	_iconFileName = NULL;
	
	return self;
}

- (id) initWithBundle:(MXBundle*)bundle
				 path:(NSString*)path
			 roleInfo:(NSDictionary*)role
  isSystemApplication:(BOOL)isSystem
{
	_bundle = bundle;
	NSMutableDictionary* infoDict = [[_bundle infoDictionary] mutableCopy]; 
	if (infoDict == nil) {
		return nil;
	}
	
	/* Some important variables */
	_bundleIdentifier = [_bundle bundleIdentifier];
	
	if (![self _verifyInfoDictionary:infoDict])
	{
		MSLog(@"%@: Failed Info.plist type check, not loading",self);
		return nil;
	}
	
	_logPath = [@"/var/root/" stringByAppendingPathComponent:[_bundleIdentifier stringByAppendingString:@".mx.log"]];
	_applicationUIServiceName = [_bundleIdentifier stringByAppendingString:@".UIKit.migserver"];
	_isSystemApplication = isSystem;
	_path = path;
	
	/* Add the UIRole crap */
	[infoDict addKeysFromDictionary:role];
	
	/* Parse the rest of UI stuff */
	[self _loadInfoDictionary:infoDict];
	
	[_logPath retain];
	[_applicationUIServiceName retain];
	[_path retain];
	
	return self;
}

- (NSString*) description
{
	return [NSString stringWithFormat:@"<MXApp %@>",_bundleIdentifier];
}

- (BOOL) hasPrerenderedIcon
{
	if (_isSystemApplication)
	{
		return TRUE;
	}
	else 
	{
		return [[_bundle infoDictionary] boolForKey:@"UIPrerenderedIcon"];
	}
}

- (NSString*) pathForIcon
{
	if (_iconFileName == NULL)
		return NULL;
	else
		return [_path stringByAppendingPathComponent:_iconFileName];
}

- (BOOL) _bootstapApplicationEventPort
{
	/*
	 Check for *.UIKit.migserver
	 This is how UIKit applications publicize themselves
	 */
	kern_return_t kr;
	kr = bootstrap_look_up(bootstrap_port, [_applicationUIServiceName UTF8String], &_serverPort);
	
	if (kr != KERN_SUCCESS)
	{
		MSLog(@"'%@' does not seem to have an active MiG server. Will try again ...",_bundleIdentifier);
		return false;
	}
	else 
	{
		/*
		 A UIKit application
		 NativeLaunchpad: com.apple.SpringBoard
		 */
		_applicationServiceName = _applicationUIServiceName;
		_isUIKit = TRUE;
		
		kr = mach_port_allocate(mach_task_self(),MACH_PORT_RIGHT_RECEIVE, &_clientPort); 
		if (kr != KERN_SUCCESS)
		{
			MSLog(@"Failed to create a response port for %@",_bundleIdentifier);
			return false;
		} 
	}
	
	return true;
}

- (mach_port_t) eventPort
{
	/* Looks up an event port for the current application
	   The event port is cached for speed.
	 */
	
	if (_eventPort == 0) {
		mach_port_t port;
		kern_return_t kr;
		
		kr = bootstrap_look_up(bootstrap_port, [_bundleIdentifier UTF8String], &port);
		
		if (kr == KERN_SUCCESS) {
			_eventPort = port;
			return _eventPort;
		}
		else {
			return 0;
		}
	}
	else {
		return _eventPort;
	}
}

#import <notify.h>


- (void) commonExited
{
    
    char* buffer = calloc(1, 40);
    sprintf(buffer, "com.mx.applicationsuspend");
    
    notify_post(buffer);
    
    free(buffer);

    
	int exitSig = 0;
	
	if (!_isAnonymous)
		exitSig = [MXLaunchdUtilities lastExitStatusForLabel:[_process jobLabel]];
	
	if (exitSig == 0) {
		MSLog(@"Application %@ exited normally.",self);
	}
	else {
		MSLog(@"Application %@ exited with signal %d: '%s'.",self, exitSig,strsignal(exitSig));
	}

	/* Remove the dead job if needed */
	if (!_isAnonymous)
		[MXLaunchdUtilities deleteJobWithLabel:[_process jobLabel]];
	
	[[MXApplicationController sharedInstance] applicationExited:self];
	
	if (_delegate != nil)
		[_delegate applicationExited:self];
}

- (void) sendSimpleEventOfType:(int)type
{
	GSSendSimpleEvent(type, [self eventPort]);
}


- (void) suspend
{
	MSLog(@"Suspending %@ ...",_bundleIdentifier);
	
    
    char* buffer = calloc(1, 40);
    sprintf(buffer, "com.mx.applicationsuspend");
    
    notify_post(buffer);
    
    free(buffer);

    
	GSEventSuspension event;
	
	memset(&event, 0, sizeof(event));
	
	event.record.type = kGSEventApplicationSuspendEventsOnly;
	event.record.timestamp = GSCurrentEventTimestamp();
	
	event.data.unk0 = 0;
	event.data.unk1 = 0x00000021;

	event.record.infoSize = sizeof(event.data);
	GSSendEvent(&event.record,[self eventPort]);
	
	_isSuspended = TRUE;
	
	if (_delegate != nil)
		[_delegate applicationSuspended:self];
}

- (void) _setActivationSetting:(int)setting
{
	_activationCount += 1;
	
	GSEventActivation event;
	
	memset(&event, 0, sizeof(event));
	
	event.record.type = setting;
	event.record.timestamp = GSCurrentEventTimestamp();
	
	event.data.activationCount = _activationCount;
	event.data.activationCountTwo = 1; /* not too bothered with this */

	event.data.statusBarStyle = 6; /* status bar style */
	
	/*
	 * Launching device orientation
	 * Always 1.
	 */
	event.data.orientation = 1;
	
	event.data.classicAppZoomedIn = FALSE; 
	event.data.statusBarHidden = FALSE;
	event.data.isClassic = _isClassic;
	event.data.isSystemApplication = _isSystemApplication;
	
	event.data.startTime = [NSDate timeIntervalSinceReferenceDate];
	
	event.record.infoSize = sizeof(event.data);
	GSSendEvent(&event.record,[self eventPort]);
	
	MSLog(@"%@: Set activation setting to %d", self, setting);
	
	_isSuspended = FALSE;
}

- (void) setOrientation:(int)orientation
{
	/*
	 
	 +------+
	 |      |
	 |     o|
	 |      |
	 +------+
	 
	 Default:
	 0: Default
	 
	 Portrait:
	 1: Bottom Bezel
	 2: Top bezel
	 
	 Landscape:
	 3: Left bezel
	 4: Right bezel
	 
	 */
	
	int sz = sizeof(int);
	
	GSEventRecord* record = malloc(sizeof(GSEventRecord) + sz);
	record->timestamp = GSCurrentEventTimestamp();
	record->type = kGSEventDeviceOrientationChanged;
	record->infoSize = sz;
	
	int* ptr = (int*)(((char*)record) + sizeof(GSEventRecord));
	*ptr = orientation;
	
	GSSendEvent(record, [self eventPort]);
	free(record);
}

- (void) resume
{	
	MSLog(@"Resuming %@ ...",_bundleIdentifier);
	
	[self _setActivationSetting:kGSEventApplicationResume];
	
	if (_delegate != nil)
		[_delegate applicationResumed:self];
}

- (void) activate
{	
    
    char* buffer = calloc(1, 40);
    sprintf(buffer, "com.mx.applicationactivate");
    
    notify_post(buffer);
    
    free(buffer);
    
	/* They don't even use this anymore */
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
										 (CFStringRef)[_bundleIdentifier stringByAppendingString:@"-activated"],
										 NULL,
										 NULL,
										 0); 
	
	[self _setActivationSetting:kGSEventApplicationLaunch];
	
	/* eh? */
	GSSendSimpleEvent(kGSEventSetAppThreadPriority, [self eventPort]);
	
	if (_delegate != nil)
		[_delegate applicationActivated:self];
}

- (void) kill
{
	/* SIGTERM */
	[_process killWithSignal:15];
}

- (void) clearLogs
{
	/* Get rid of old logs */
	if ([[NSFileManager defaultManager] fileExistsAtPath:_logPath])
		[[NSFileManager defaultManager] removeItemAtPath:_logPath error:nil];
}

- (void) launch
{	
	/* Let's fire it up! */
	_isStarting = TRUE;
	
	if ([_bundle executablePath] == nil) {
		MSLog(@"The '%@' bundle at %@ does not have an executable path.",_displayName,[_bundle bundlePath]);
		
		if (_delegate != nil)
			[_delegate application:self failedToLaunchWithError:0];
		
		return;
	}
	
	/* Is the application already running? */
	
	/* Mach services */
	NSMutableArray* machServices = [NSMutableArray new];
	if ([[_bundle infoDictionary] objectForKey:@"SBMachServices"] != nil)
	{
		if (_isSystemApplication)
		{
			for (id svc in [[_bundle infoDictionary] objectForKey:@"SBMachServices"])
			{
				if ([svc isKindOfClass:[NSString class]])
				{
					[machServices addObject:svc];
				}
			}
		}
		else {
			MSLog(@"Ignoring the SBMachServices key as %@ isn't a system app.",_bundleIdentifier);
		}
	}
	
	long long jetsamPriority = 1;
	if ([[_bundle infoDictionary] objectForKey:@"UIJetsamPriority"] != nil)
	{
		jetsamPriority = [[[_bundle infoDictionary] objectForKey:@"UIJetsamPriority"] longValue];
		if (jetsamPriority < 0)
		{
			jetsamPriority = 1;
			MSLog(@"Ignoring a negative UIJetsamPriority key.");
		}
	}
	
	/* To log or not to log? */
	NSString* finalLogPath = nil;
	if ([MXSettingsController boolForKey:XXX_LOGAPPS]) {
		finalLogPath = _logPath;
	}
	else {
		finalLogPath = nil;
	}

	BOOL isAttaching = FALSE;
	
	mach_port_t port;
	if (bootstrap_look_up(bootstrap_port, [_bundleIdentifier UTF8String], &port) == KERN_SUCCESS)
	{
		for (NSString* label in [MXLaunchdUtilities allJobLabels]) {
			if ([label hasSuffix:[NSString stringWithFormat:@"anonymous.%@",[[_bundle executablePath] lastPathComponent]]]) {
				MSLog(@"%@: Running anonymously. Attaching ...",self);
				isAttaching = TRUE;
				
				_isAnonymous = TRUE;
				_process = [[MXProcess alloc] initWithRunningPid:[MXLaunchdUtilities pidForLabel:label]
														jobLabel:label
												   eventPortName:_bundleIdentifier];
				
				break;
			}
		}
		
		if (!isAttaching) 
		{
			MSLog(@"%@: Is running non-anonymously. Not launching.",self);
			return;
		}
	}

	
	if (!isAttaching) {
		/* Create a process */	
		_process = [MXProcess launchedProcessWithBundleIdentifier:_bundleIdentifier
												  path:[_bundle executablePath]
											 arguments:nil
										   environment:XXObjForKey(XXX_APPENVVARS)
									standardOutputPath:finalLogPath
									 standardErrorPath:finalLogPath
										  machServices:(NSArray*)machServices
										threadPriority:1
											 frontmost:TRUE
							  backgroundJetsamPriority:jetsamPriority
									   waitForDebugger:FALSE
										   disableASLR:FALSE
								allowedLockedFilePaths:nil
								 terminateOnSuspension:0];
		
		if (!_process) {
			MSLog(@"%@: Failed to start application, not launching watchdog.", self);
			return;
		}
		
		MSLog(@"Launched process '%@'",[_process jobLabel]);
	}
	
	[self _startWatchDogTimer];
	
}

- (BOOL) isRunning
{
	/* Watchdog only runs on alive processes */
	return (_watchDogTimer != NULL);
}

- (void) _watchDogTimerFired
{
	/* Ping the PID */
	if (kill([_process pid], 0) == 0)
	{
		/* Activate the application */
		if (!_isRunning)
		{
			if ([self _bootstapApplicationEventPort]) {
				[self activate];
				_isRunning = TRUE;
				_watchdogMisses = 0;
			}
			else {
				_watchdogMisses += 1;
				if (_watchdogMisses > 5) {
					_watchdogMisses = 0;
					MSLog(@"%@: Can't bootstrap the MIG server after 5 tries, killing.",self);
					[self kill];
				}
			}
		}
	}
	else if (errno == ESRCH)
	{
		/* Process is dead */
		
		if (!_isRunning && _watchDogFiredOnce)
		{
			MSLog(@"Application '%@' is already shutting down.",[_process jobLabel]);

			/* If the timer isn't invalidated, everything goes to hell */ 
			_watchDogFiredOnce = FALSE;
			return;
		}
		
		/* Kill the timer */
		[self _invalidateWatchDogTimer];
		
		_isRunning = FALSE;
		_eventPort = 0;
		
		/* delegate */
		[self commonExited];
	}
	else {
		/* shouldn't happen? */
	}
	
	_watchDogFiredOnce = TRUE;
}

- (void) _invalidateWatchDogTimer
{
	[_watchDogTimer invalidate];
	_watchDogTimer = NULL;
}

- (void) _startWatchDogTimer
{
	_watchDogFiredOnce = FALSE;
	
	if (_watchDogTimer == NULL)
	{
		/* prevents a new timer from being created before the old one is destroyed */
		
		/* XXX: Bug: sometimes apps take longer than 1 second to announce themselves */
		_watchDogTimer = [NSTimer scheduledTimerWithTimeInterval:1
														  target:self
														selector:@selector(_watchDogTimerFired)
														userInfo:nil
														 repeats:YES];
		
		[[NSRunLoop mainRunLoop] addTimer:_watchDogTimer forMode:NSDefaultRunLoopMode];
	}
}

@end
