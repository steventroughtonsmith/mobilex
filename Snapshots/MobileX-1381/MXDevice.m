//
//  MXDevice.m
//  MxWmSrvApp
//
//  Created by Nick on 01/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import "MXDevice.h"
#import <IOKit/IOKitLib.h>

static id _shared = NULL;

@implementation MXDevice

+ (id) currentDevice
{
	if (_shared == NULL)
		_shared = [[MXDevice alloc] init];
	
	return _shared;
}

- (CFMutableDictionaryRef) _platformExpertPropertyDictionary
{	
	CFMutableDictionaryRef properties = NULL;
	io_registry_entry_t entry = 0;
	entry = IORegistryEntryFromPath(kIOMasterPortDefault, "IODeviceTree:/");
	IORegistryEntryCreateCFProperties(entry, &properties, NULL, 0);
	
	return properties;
}

- (NSString*) model
{
	return [[NSString alloc] initWithData:[_platformExpertDict objectForKey:@"model"]
								 encoding:NSASCIIStringEncoding];
}

- (BOOL) isWildcat
{
	if ([[self model] hasPrefix:@"iPad"]) {
		return TRUE;
	}
	else {
		return FALSE;
	}
}

- (id) init
{
	[super init];
	
	CFMutableDictionaryRef platformExDct = [self _platformExpertPropertyDictionary];
	_platformExpertDict = [(NSDictionary*)platformExDct copy];
	CFRelease(platformExDct);
	[_platformExpertDict retain];
	
	return self;
}

- (CFMutableDictionaryRef) _powerSourcePropertyDictionary
{
	CFMutableDictionaryRef matching , properties = NULL;
	io_registry_entry_t entry = 0;
	matching = IOServiceMatching("IOPMPowerSource");
	
	entry = IOServiceGetMatchingService(kIOMasterPortDefault, matching);
	IORegistryEntryCreateCFProperties(entry, &properties, NULL, 0);
	IOObjectRelease(entry);
	
	return properties;
}

- (BOOL) isCharging
{
	CFMutableDictionaryRef propertyDict = [self _powerSourcePropertyDictionary];
	
	BOOL isCharging = [(NSDictionary*)propertyDict boolForKey:@"IsCharging"];
	
	CFRelease(propertyDict);
	
	return isCharging;
}

- (float) batteryLevel
{
	/* Work out battery percentage */
	
	CFMutableDictionaryRef propertyDict = [self _powerSourcePropertyDictionary];
	
	float batteryLevel = [[(NSDictionary*)propertyDict objectForKey:@"CurrentCapacity"] floatValue] /
						 [[(NSDictionary*)propertyDict objectForKey:@"MaxCapacity"] floatValue];

	CFRelease(propertyDict);
	
	return batteryLevel;
}

- (void) _announcedScreenSize:(CGSize)size
{
	_screenSize = size;
}

- (CGRect) screenSizeAsRect
{
	return CGRectMake(0, 0, _screenSize.width, _screenSize.height);
}

- (CGSize) screenSize
{
	return _screenSize;
}

- (NSString*) addDeviceIdiomToString:(NSString*)string
{
	return nil;
}

@end
