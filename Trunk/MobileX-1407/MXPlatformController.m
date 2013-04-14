//
//  MXPlatformController.m
//  MobileX
//
//  Created by Nick on 25/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXPlatformController.h"
#import <sys/mman.h>
#import <sys/fcntl.h>
#import <sys/stat.h>
#import <unistd.h>
#import <IOKit/IOKitLib.h>
#import "MXPaneManager.h"
#import "MXDevice.h"

@implementation MXPlatformController

static MXPlatformController* _shinst = nil;

+ (id) shared
{
    if (_shinst == nil) {
        _shinst = [[MXPlatformController alloc] init];
    }
    return _shinst;
}

- (BOOL) hasCapability:(CFStringRef)capability
{
	if ([_currentCapabilities objectForKey:(id)capability] == NULL ||
		[_currentCapabilities objectForKey:(id)capability] == (id)kCFBooleanFalse)
	{
		return FALSE;
	}
	else 
	{
		return TRUE;
	}
	
}

- (void) noteConfigurationChangedWithKeys:(NSArray*)keys
{
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), kGSCapabilityChangedNotification, NULL, NULL, 0);
}

- (void) postCurrentConfiguration
{	
	NSData* capabilityData = [NSPropertyListSerialization dataFromPropertyList:_currentCapabilities
																		format:kCFPropertyListBinaryFormat_v1_0
															  errorDescription:nil];
	
	if (capabilityData)
	{
		/* Scrap old GSC and create a new one */
		shm_unlink("GSCapabilities");
		int32_t res = shm_open("GSCapabilities", 2562,0644);
		
		if (res == -1)
		{
			MXSLog(@"Couldn't open shared memory: %s",strerror(errno));
		}
		else
		{
			size_t size = [capabilityData length]+4;
			
			if (ftruncate(res,size) != 0)
			{
				MXSLog(@"Couldn't ftruncate shared memory: %s",strerror(errno));
			}
			else 
			{
				/* Map shared memory */
				char* gsMem = NULL;
				gsMem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, res, 0);
				
				if (gsMem != (void*)-1)
				{
					int len = [capabilityData length];
					gsMem[0] = len;
					
					/* write to shmem */
					[capabilityData getBytes:gsMem+4];
				}
				else
				{
					MXSLog(@"Couldn't mmap shared memory: %s",strerror(errno));
				}
				
				munmap(gsMem, size);
				close(res);
			}
		}
	}
	else {
		MXSLog(@"Failed to create data for capabilities.");
	}

}

- (void) discoverCurrentConfiguration
{
	_currentCapabilities = [[NSMutableDictionary alloc] init];
	[_currentCapabilities retain];
	
	/************** Telephony **************/
	CFMutableDictionaryRef services = IOServiceMatching("AppleBaseband");
	io_service_t appleBasebandService = IOServiceGetMatchingService(kIOMasterPortDefault, services);
	
	if (appleBasebandService)
	{
		[_currentCapabilities setObject:(id)kCFBooleanTrue forKey:(id)kGSContainsCellularRadioCapability];
		[_currentCapabilities setObject:(id)kCFBooleanTrue forKey:(id)kGSCellularDataCapability];
	}
	else 
	{
		MXSLog(@"No AppleBaseband service detected. Cellular data disabled.");
	}
	
	/************** Internal Flag **************/
	[_currentCapabilities setObject:(id)kCFBooleanTrue forKey:(id)kGSAppleInternalInstallCapability];
	
	/************** Primary Display Settings ****************/
	CGSize screenSize = [[MXDevice currentDevice] screenSize];

	//[_currentCapabilities setObject:[NSNumber numberWithInt:10] forKey:(id)kGSMainScreenOrientation];

	NSDictionary* screenDimensions = [NSDictionary dictionaryWithObjectsAndKeys:
									  [NSNumber numberWithInt:screenSize.width],kGSMainScreenWidth,
									  [NSNumber numberWithInt:screenSize.height],kGSMainScreenHeight,
									  nil];
	
	[_currentCapabilities setObject:screenDimensions forKey:(id)kGSScreenDimensionsCapability];
	[_currentCapabilities setObject:[NSNumber numberWithFloat:1.0] forKey:(id)kGSMainScreenScale];
	
	if ([[MXDevice currentDevice] isAppleTV]) {
		[_currentCapabilities setObject:(id)kCFBooleanTrue forKey:(id)kGSTVOutSettingsCapability];
	}
	
	/************** Wildcat Only **************/
	if ([[MXDevice currentDevice] isWildcat]) { 
		/* Causes an error of unknown origin on the iPhone */
		[_currentCapabilities setObject:(id)kCFBooleanTrue forKey:(id)kGSWiFiCapability];
	}
	
	/************** iPod **************/
	[_currentCapabilities setObject:(id)kCFBooleanTrue forKey:(id)kGSUnifiedIPodCapability];
	
	/************** Other **************/
	[_currentCapabilities setObject:(id)kCFBooleanTrue forKey:(id)kGSOpenGLES2Capability];
	[_currentCapabilities setObject:(id)kCFBooleanTrue forKey:(id)kGSOpenGLES1Capability];
	
	/************** System Version **************/
	if ([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/CoreServices/SystemVersion.plist"])
	{
		_systemVersionDictionary = [NSDictionary dictionaryWithContentsOfFile:@"/System/Library/CoreServices/SystemVersion.plist"];
	}
}

- (id) init
{
	[super init];
	
	[self discoverCurrentConfiguration];
	
	
	
	[self postCurrentConfiguration];
	[self noteConfigurationChangedWithKeys:nil];
	
	GSSystemCopyCapability(kGSUnifiedIPodCapability);
	
	return self;
}

@end
