//
//  MXApplicationController.m
//  CurrentLauncher
//
//  Created by _AAAAAAAA_ on 15/08/2006.
//  Copyright 2006 lol inc. All rights reserved.
//

#import "MXApplicationController.h"
#import "MXPlatformController.h"
#import "MXApplicationStateServices.h"
#import "MXController.h"

static MXApplicationController* _sharedInstance = nil;

@implementation MXApplicationController

@synthesize activeApplication=_activeApplication;

+ (id)sharedInstance
{
    if (_sharedInstance == nil) {
        _sharedInstance = [[super allocWithZone:NULL] init];
    }
    return _sharedInstance;
}

- (id) init
{
	[super init];
	_applications = [[NSMutableDictionary alloc] init];
	_appPanes = [[NSMutableDictionary alloc] init];
	return self;
}

- (void) _loadBundleApplicationsIfNeeded
{
	/*
	 * Loads internal MX bundles as defined in Bundles.plist
	 */
	
	NSString* dictPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Bundles.plist"];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:dictPath])
	{
		NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:dictPath];
		NSArray* bndls = [dict objectForKey:@"Bundles"];
		
		NSAssert([bndls isKindOfClass:[NSArray class]],@"Bundles.plist/Bundles isn't an array");
		
		for (NSString* b in bndls)
		{
			NSString* bPath = [[[[NSBundle mainBundle] bundlePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:b];
			if ([[NSFileManager defaultManager] fileExistsAtPath:bPath])
			{
				[[MXApplicationController sharedInstance] loadApplicationBundleAtPath:bPath
																			 isSystem:TRUE];
			}
		}
	}
	else {
		[[MXController shared] reportError:@"Missing 'Bundles.plist' file."];
	}
}

- (void) _loadedApplication:(MXApplication*)app withRole:(NSString*)role
{
	if (app != nil) {
		if (role != nil)
			[_applications setObject:app forKey:[NSString stringWithFormat:@"%@-%@",[app bundleIdentifier],role]];
		else
			[_applications setObject:app forKey:[app bundleIdentifier]];
		
		if ([app checkInRecord] != nil)
		{
			if ([[app checkInRecord] boolForKey:@"Autolaunch"])
			{
				[[MXController shared] pushAutoLaunchIdentifier:[app bundleIdentifier]];
			}
		}
	}
}

/* adds a bunch of dummies for icon list testing */
- (void) _addDummyApps
{
	for (int i = 0; i < 100;i++)
	{
		[self _loadedApplication:[[MXApplication alloc] _initEmptyApplication:[NSString stringWithFormat:@"App-%d",i]]
						withRole:nil];
	}
}

- (NSArray*) rolesForRoleDefinitions:(NSArray*)definitions
{
	NSMutableArray* roles = [NSMutableArray arrayWithCapacity:[definitions count]];
	for (NSDictionary* def in definitions)
	{
		/* check if this role is applicable */
		BOOL requirementsMet = TRUE;
		NSDictionary* cDict = [def objectForKey:@"Capabilities"];
		for (NSString* capabilityName in cDict)
		{
			if ([cDict boolForKey:capabilityName] !=
				[[MXPlatformController shared] hasCapability:(CFStringRef)capabilityName])
				requirementsMet = FALSE;
		}
		
		if (requirementsMet)
		{
			for (NSDictionary* role in [def objectForKey:@"Roles"])
			{
				[roles addObject:role];
			}
		}
	}
	return roles;
}

- (void) loadRolesWithBundle:(MXBundle*)bundle
				  bundlePath:(NSString*)path
		 isSystemApplication:(BOOL)isSystem
				 defaultTags:(NSArray*)tags
seatbeltEnvironmentVariables:(NSDictionary*)sVars
{
	if ([[path pathExtension] isEqualToString:@"app"])
	{
		MXApplication* app;
		
		NSDictionary* infoDict = [bundle infoDictionary];
		if ([infoDict objectForKey:@"UIRoleInfo"] != nil)
		{
			if (!isSystem) {
				MXSLog(@"Application %@ wants UI roles but isn't a system app.",[bundle bundleIdentifier]);
				return;
			}
			
			NSArray* roles = [self rolesForRoleDefinitions:[infoDict objectForKey:@"UIRoleInfo"]];
			for (NSDictionary* role in roles)
			{
				app = [[MXApplication alloc] initWithBundle:bundle
																	  path:path 
																  roleInfo:role
													   isSystemApplication:isSystem];
				
				[self _loadedApplication:app withRole:[role objectForKey:@"Role"]];
			}
		}
		else 
		{
			app = [[MXApplication alloc] initWithBundle:bundle
																  path:path 
															  roleInfo:nil
												   isSystemApplication:isSystem];
			
			[self _loadedApplication:app withRole:nil];
		}
		
		if ([infoDict objectForKey:@"SBAppTags"] != nil)
		{
			if (!isSystem) {
				MXSLog(@"Ignoring SBAppTags for a non-system app %@.",[bundle bundleIdentifier]);
				return;
			}
			
			NSArray* tags = [infoDict objectForKey:@"SBAppTags"];
			for (NSString* tag in tags)
			{
				if ([tag isEqualToString:@"hidden"])
					[app setIsHidden:TRUE];
			}
		}

		
	}
	else 
	{
		MXSLog(@"Bundle %@ has an unexpected type. Expecting 'app'.",[bundle bundleIdentifier]);
	}
}

- (void) applicationExited:(MXApplication*)app
{
	/* remove pane */
	[[_appPanes objectForKey:[app bundleIdentifier]] unregister];
	[_appPanes removeObjectForKey:[app bundleIdentifier]];
}

- (void) launcedApplication:(MXApplication*)app inPane:(MXPane*)pane
{
	[_appPanes setObject:pane forKey:[app bundleIdentifier]];
}

- (void) loadApplicationDictionary:(NSDictionary*)dict isSystem:(BOOL)isSystem
{
	NSString* bundlePath = [dict objectForKey:@"Path"];
	if (bundlePath == nil) {
		return;
	}
	
	MXBundle* appBundle = [[MXBundle alloc] initWithPath:[dict objectForKey:@"Path"]];
	
	[self loadRolesWithBundle:appBundle
				   bundlePath:bundlePath
		  isSystemApplication:isSystem
				  defaultTags:[NSArray arrayWithObject:@"aaaaa"]
 seatbeltEnvironmentVariables:nil];
}

- (NSMutableDictionary*) allApplications
{
	return _applications;
}

- (NSString*) shortenApplicationName:(NSString*)fullName
{
	NSString* shortAppName = fullName;
	
	int newLength = 11;
	if (shortAppName.length > newLength)
	{
		shortAppName = [shortAppName substringToIndex:newLength];
		shortAppName = [shortAppName stringByAppendingString:@"..."];
	}
	
	return shortAppName;
}

- (MXApplication*) applicationForPid:(pid_t)pid
{
	for (NSString* ident in _applications)
	{
		MXApplication* app = [_applications objectForKey:ident];
		if ([[app process] isRunning]) {
			if ([[app process] pid] == pid) {
				return app;
			}
		}
	}
	
	return nil;
}

- (id) applicationForIdentifier:(NSString*)identifier
{
	return [_applications objectForKey:identifier];
}

- (void) loadApplicationBundleAtPath:(NSString*)bundlePath isSystem:(BOOL)isSystem
{
	if ([[NSFileManager defaultManager] fileExistsAtPath:[bundlePath stringByAppendingPathComponent:@"Info.plist"]])
	{
		NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithContentsOfFile:
									 [bundlePath stringByAppendingPathComponent:@"Info.plist"]];
		
		[dict setObject:bundlePath forKey:@"Path"];
		[self loadApplicationDictionary:dict isSystem:isSystem];
	}
	else {
		MSLog(@"Bundle at %@ is missing Info.plist",bundlePath);
	}

}

- (void) _loadApplicationsDictionariesInDirectory:(NSString*)scanPath isSystem:(BOOL)isSystem;
{
	NSFileManager* fileManager = [[NSFileManager alloc] init];
	
	NSArray* fileList = [fileManager contentsOfDirectoryAtPath:scanPath error:nil];
	
	for (NSString* file in fileList)
	{
		if ([file hasSuffix:@".app"])
		{
			NSString* fullPath = [scanPath stringByAppendingPathComponent:file];
			[self loadApplicationBundleAtPath:fullPath isSystem:isSystem];
		}
	}
	
	[fileManager release];
}

- (void) _loadUserApps
{
	NSFileManager* fileManager = [[NSFileManager alloc] init];
	
	NSArray* fileList = [fileManager contentsOfDirectoryAtPath:@"/User/Applications/" error:nil];
	
	for (NSString* file in fileList)
	{
		[self _loadApplicationsDictionariesInDirectory:[@"/User/Applications/" stringByAppendingPathComponent:file] isSystem:FALSE];
	}
}

- (void) loadApplications
{
	[_applications removeAllObjects];

	[self _loadBundleApplicationsIfNeeded];
	
#if TARGET_CPU_ARM
	
	[self _loadApplicationsDictionariesInDirectory:@"/Applications/" isSystem:TRUE];
#else
	[self _loadApplicationsDictionariesInDirectory:@"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator5.1.sdk/Applications/" isSystem:TRUE];

#endif
	[self _loadUserApps];
}

@end
