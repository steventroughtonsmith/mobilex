/*
 * main.m
 */

#import <Foundation/Foundation.h>
#import <IOKit/IOKitLib.h>
#include <IOKit/hid/IOHIDNotification.h>
#include <IOKit/hid/IOHIDSession.h>
#include <IOKit/hid/IOHIDEventSystem.h>
#include <IOKit/hid/IOHIDDisplay.h>


CF_EXPORT void CFLog(int32_t level, CFStringRef format, ...);
typedef CFTypeRef IOHIDEventSystemClientRef;

void hidCallback(IOHIDEventRef ev) {
	printf("[hid] ev type %d\n", IOHIDEventGetType(ev));
}

int main(int argc, char *argv[]) {
	NSAutoreleasePool* p = [[NSAutoreleasePool alloc] init];
	
	IOHIDEventSystemClientRef cl = 
	IOHIDEventSystemClientCreate(kCFAllocatorDefault);
	
	CFShow(cl);
	
	IOHIDEventSystemClientRegisterEventCallback(cl, hidCallback, NULL, NULL/*refcon*/);
	
	IOHIDEventSystemClientScheduleWithRunLoop(cl, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
	
	NSDictionary* matching = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSNumber numberWithInt:1],@"PrimaryUsage",
							  [NSNumber numberWithInt:0x80],@"PrimaryUsagePage",
							  nil];
	
	IOHIDEventSystemClientSetMatching(cl, matching);
	
	NSArray* svcs = IOHIDEventSystemClientCopyServices(cl);
	
	CFShow(svcs);
	
	CFRunLoopRun();
	
	return 0;
}
