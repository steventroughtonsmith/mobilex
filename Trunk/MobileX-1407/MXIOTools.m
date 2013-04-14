/* IO Tools: Impl */

#import "MXIOTools.h"

#import <IOMobileFramebuffer/IOMobileFrameBufferAPI.h>
#import <IOKit/IOPMLib.h>
#import <IOKit/IOKitLib.h>

#import "MXDevice.h"

void _MXIOInterestCallback (void *refcon,io_service_t service,uint32_t messageType,void *messageArgument)
{
	MXLog(@"IOPower: XXX");
}

CGSize MXIOGetScreenSize()
{
	/*
	 * The default surface has the correct screen size.
	 * So we can fetch it.
	 */
	
	io_service_t framebufferService = IOServiceGetMatchingService(kIOMasterPortDefault,
																  IOServiceMatching("AppleCLCD"));

	IOMobileFramebufferRef fb;
	IOMobileFramebufferOpen(framebufferService, mach_task_self(), 0, &fb);
	
	IOSurfaceRef defaultSurfaceBuffer;
	IOMobileFramebufferGetLayerDefaultSurface(fb, 0, &defaultSurfaceBuffer);
	
	CGSize size = CGSizeMake(IOSurfaceGetWidth(defaultSurfaceBuffer),
							 IOSurfaceGetHeight(defaultSurfaceBuffer));
	
	printf("Copied screen size from MFB: {%f,%f} \n",size.width,size.height);
	
	return size;
}
extern IOReturn IOPMAssertionCreateWithName( 
										   CFStringRef AssertionType, 
										   IOPMAssertionLevel AssertionLevel, 
										   CFStringRef AssertionName, 
										   IOPMAssertionID *AssertionID) ; 

extern IOReturn IOPMSetSystemPowerSetting( CFStringRef key, CFTypeRef value );
#define	kIOPMSleepDisabledKey	CFSTR("SleepDisabled")

void MXIOMarkBootComplete()
{
	/* the device is now awake */
	io_registry_entry_t ioPower = 
	IORegistryEntryFromPath(kIOMasterPortDefault, "IOPower:/IOPowerConnection/IOPMrootDomain");
	
	IORegistryEntrySetCFProperty(ioPower, CFSTR("System Boot Complete"), kCFBooleanTrue);
	
	/* now register for power notifications */
	IONotificationPortRef ioNotificationPort;
	io_object_t ioNotifier;
	
	IORegisterForSystemPower(NULL, &ioNotificationPort, _MXIOInterestCallback, &ioNotifier);
	CFRunLoopSourceRef rlsc = IONotificationPortGetRunLoopSource(ioNotificationPort);
	CFRunLoopAddSource(CFRunLoopGetCurrent(), rlsc, kCFRunLoopDefaultMode);
	
	if ([[[MXDevice currentDevice] model] hasPrefix:@"AppleTV"]) {
		printf("[*appleTVpm]: disabling sleep completely \n");
		
		IOPMSetSystemPowerSetting(kIOPMSleepDisabledKey, kCFBooleanTrue);
		
		printf("[*appleTVpm]: disabling idle sleep\n");
		
		IOPMAssertionID assertionID;
		
		IOReturn success = 
		IOPMAssertionCreate(kIOPMAssertionTypeNoIdleSleep, 
						   kIOPMAssertionLevelOn,
						   &assertionID);
		
		printf("[*appleTVpm]: disabling idle sleep (named)\n");
		
		IOPMAssertionCreateWithName(CFSTR("NoIdleSleepAssertion"),
									0xff,
									CFSTR("com.apple.appletv.idlesleepholdoff"),
									&assertionID);
		
		success = success;
	}
}
