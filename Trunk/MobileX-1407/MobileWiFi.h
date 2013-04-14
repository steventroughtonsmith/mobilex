/*
 * MobileWiFi
 */

#import <Foundation/Foundation.h>

/**/
typedef CFTypeRef WiFiManagerClientRef;
typedef CFTypeRef WiFiDeviceClientRef;
typedef CFTypeRef WiFiNetworkRef;


/* WiFiNetwork */
WiFiNetworkRef WiFiNetworkCreate(CFAllocatorRef allocator, CFDictionaryRef network);
CFStringRef WiFiNetworkGetSSID(WiFiNetworkRef network);
CFDictionaryRef WiFiNetworkCopyRecord(WiFiNetworkRef network);
CFTypeRef WiFiNetworkGetProperty(WiFiNetworkRef network, CFStringRef property);
BOOL WiFiNetworkRequiresPassword(WiFiNetworkRef network);
BOOL WiFiNetworkIsWAPICERT(WiFiNetworkRef network);
BOOL WiFiNetworkIsWPA(WiFiNetworkRef network);
BOOL WiFiNetworkIsEAP(WiFiNetworkRef network);
BOOL WiFiNetworkIsWEP(WiFiNetworkRef network);
BOOL WiFiNetworkIsApplePersonalHotspot(WiFiNetworkRef network);
void WiFiNetworkSetPassword(WiFiNetworkRef network, CFStringRef password);

/**/
WiFiManagerClientRef WiFiManagerClientCreate(CFAllocatorRef allocator);

WiFiNetworkRef WiFiDeviceClientCopyCurrentNetwork(CFAllocatorRef allocator);

/**/
CFArrayRef WiFiManagerClientCopyDevices(WiFiManagerClientRef client, CFAllocatorRef allocator);
CFTypeRef WiFiManagerClientCopyProperty(WiFiManagerClientRef client, CFStringRef property);
void WiFiManagerClientSetProperty(WiFiManagerClientRef client, CFStringRef property, CFTypeRef value);

/**/
int WiFiDeviceClientScanAsync(WiFiDeviceClientRef device,
							  CFDictionaryRef properties,
							  void* callback,
							  void* refcon);
								  
void WiFiManagerClientScheduleWithRunLoop(WiFiManagerClientRef client,
										  CFRunLoopRef runloop,
										  CFStringRef mode);

void WiFiManagerClientRegisterDeviceAttachmentCallback(WiFiManagerClientRef client,
													   void* callback,
													   void* refcon);

void WiFiManagerClientRegisterNotificationCallback(WiFiManagerClientRef client,
												   void* callback,
												   void* refcon);