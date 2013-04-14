//
//  MXSettingsController.m
//  MxWmSrvApp
//
//  Created by Nick on 04/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import "MXSettingsController.h"

static id _shinst = NULL;

@implementation MXSettingsController

+ (id) shared
{
	if (_shinst==NULL)
	{
		_shinst = [MXSettingsController alloc];
		[_shinst init];
	}
	
	return _shinst;
}

- (NSDictionary*) getAppOverridesForIdentifier:(NSString*)identifier
{
	NSDictionary* overrides = [self objectForKey:@"MXAppOverrides"];
	return [overrides objectForKey:identifier];
}

- (NSMutableDictionary*) _defaultSettingsDictionary
{
	NSMutableDictionary* d = [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"/var/root/wallpaper.png",XXX_WALLPAPER,
							  CF_FALSE,XXX_FULLSCREENAPPS,
							  CF_FALSE,XXX_LOGAPPS,
							  CF_TRUE,XXX_SUSPENDONCLOSE,
							  CF_FALSE,XXX_SUPRESSAUTOLAUNCH,
							  CF_FALSE,@"MXUseIconStateFile",
							  nil];
	
	return d;
}

- (NSString*) getSettingsPath
{
	return @"/User/Library/Preferences/com.mx.mx.plist";
}

- (void) _writeSettingsToFile
{
	[[NSFileManager defaultManager] removeItemAtPath:[self getSettingsPath] error:nil];
	[_settings writeToFile:[self getSettingsPath] atomically:TRUE];
}

- (void) _createSettingsPlist
{
	_settings = [self _defaultSettingsDictionary];	
	[self _writeSettingsToFile];
}

- (id) init
{
	[super init];
	
	//XXX: Debug
	[[NSFileManager defaultManager] removeItemAtPath:[self getSettingsPath] error:nil];
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:[self getSettingsPath]]) {
		[self _createSettingsPlist];
	}
	else {
		_settings = [NSMutableDictionary dictionaryWithContentsOfFile:[self getSettingsPath]];
	}
	
	[_settings retain];
	
	return self;
}

- (void) setObject:(id)object forKey:(id)key
{
	[_settings setObject:object forKey:key];
	[self _writeSettingsToFile];
}

- (id) objectForKey:(id)key
{
	return [_settings objectForKey:key];
}

- (BOOL) boolForKey:(id)key
{
	return [_settings boolForKey:key];
}

+ (id) objectForKey:(id)key
{
	return [[MXSettingsController shared] objectForKey:key];
}

+ (BOOL) boolForKey:(id)key
{
	return [[MXSettingsController shared] boolForKey:key];
}

@end
