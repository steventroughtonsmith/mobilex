//
//  SKWifiManager.m
//  MobileDiagnostics
//
//  Created by Nick on 10/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WifiManager.h"

static id _sharedInstance = NULL;

@implementation WifiManager

+ (id) sharedInstance
{
	if (_sharedInstance == NULL)
	{
		_sharedInstance = [[self class] alloc];
		[_sharedInstance init];
	}
	
	return _sharedInstance;
}

- (NSArray*) networks {
	return [_networks copy];
}

- (BOOL) wifiEnabled {
	
#if TARGET_CPU_ARM
	CFNumberRef v = WiFiManagerClientCopyProperty(_wifiManager, CFSTR("AllowEnable"));
	
	BOOL r;
	
	if (v != NULL) {
		r = [(NSNumber*)v boolValue];
		CFRelease(v);
	}
	
	return r;
	
#else
	return NO;
#endif
}

- (void) setWifiEnabled:(BOOL)wifiEnabled {
#if TARGET_CPU_ARM

	WiFiManagerClientSetProperty(_wifiManager, CFSTR("AllowEnable"), wifiEnabled ? kCFBooleanTrue : kCFBooleanFalse);
#endif
}

- (id)init
{
    self = [super init];
    if (self) {

		/* Allocate things */
		_networks = [NSMutableArray new];
	#if TARGET_CPU_ARM
	
        /* Start WiFi manager */
		_wifiManager = WiFiManagerClientCreate(NULL);
		
		WiFiManagerClientScheduleWithRunLoop(_wifiManager,
											 CFRunLoopGetCurrent(),
											 kCFRunLoopDefaultMode);
		
		MSLog(@"WiFi: Starting the WiFi manager ...");
		
		CFArrayRef devices = WiFiManagerClientCopyDevices(_wifiManager, NULL);
		if (devices != NULL && CFArrayGetCount(devices) > 0) {
			_device = CFArrayGetValueAtIndex(devices, 0);
			MSLog(@"WiFi: WiFi manager started with %@",_device);
			
			CFRunLoopWakeUp(CFRunLoopGetCurrent());
		}
		else {
			/* no devices are available */
			MSLog(@"WiFi:XXX: No devices are available. Maybe the entitlements are missing?\n");
			assert(devices != NULL && CFArrayGetCount(devices) > 0);
		}
#endif
    }
    
    return self;
}

- (void) _joinComplete:(int)result network:(WiFiNetworkRef)network {
	MSLog(@"WiFi: Joined %@.", network);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"WifiManagerJoinComplete"
														object:nil];
}

void JoinFinished(WiFiDeviceClientRef device, WiFiNetworkRef network, int error, int error2, void* refcon) {
	
	[(WifiManager*)refcon _joinComplete:error2 network:network];
}

- (void) joinNetwork:(NSDictionary*)network password:(NSString*)password {
#if TARGET_CPU_ARM

	WiFiNetworkRef net =
	WiFiNetworkCreate(NULL, (CFDictionaryRef)network);
	
	if (password != nil) {
		WiFiNetworkSetPassword(net, (CFStringRef)password);
	}
	
	/* took me a while to realize that 'Associate' means 'Join'  */
	WiFiDeviceClientAssociateAsync(_device, net, JoinFinished, self);
#endif
}

- (void) _scanComplete:(CFArrayRef)networks {
#if TARGET_CPU_ARM

	if (networks == NULL)
	{
		MSLog(@"WiFi: (networks == NULL), ignoring scan results");
		return;
	}
	
	MSLog(@"WiFi: Scan complete with %d networks.", CFArrayGetCount(networks));
	
	for (int i = 0; i < CFArrayGetCount(networks); i++) {
		WiFiNetworkRef net = (WiFiNetworkRef)CFArrayGetValueAtIndex(networks, i);
		NSDictionary* record = (NSDictionary*)WiFiNetworkCopyRecord(net);
		
		[_networks addObject:record];
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"WifiManagerScanComplete"
														object:nil];
#endif
}

void ScanFinished(WiFiDeviceClientRef device, CFArrayRef networks, int error, void* refcon) {
	[(WifiManager*)refcon _scanComplete:networks];
}

- (void) scan {
	[_networks removeAllObjects];
#if TARGET_CPU_ARM

	
	NSDictionary* scanDict = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSNumber numberWithInt:14], @"SCAN_MERGE",
							  [NSNumber numberWithInt:1], @"SCAN_PHY_MODE",
							  [NSNumber numberWithInt:1], @"SCAN_TYPE",
							  [NSNumber numberWithInt:1], @"SCAN_NUM_SCANS",
							  [NSNumber numberWithInt:-170], @"SCAN_RSSI_THRESHOLD",
							  nil];
	
	WiFiDeviceClientScanAsync(_device, (CFDictionaryRef)scanDict, ScanFinished, self);
#endif
}

@end
