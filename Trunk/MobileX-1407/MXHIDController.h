/* HID: Header */

/*
 This isn't really a "controller". More like a bunch of C functions.
 */

#import <Foundation/Foundation.h>

#include <IOKit/hid/IOHIDNotification.h>
#include <IOKit/hid/IOHIDSession.h>
#include <IOKit/hid/IOHIDEventSystem.h>
#include <IOKit/hid/IOHIDDisplay.h>

#include <QuartzCore/CAWindowServer.h>
#include <QuartzCore/CAWindowServerDisplay.h>

/* HID Starter */
IOHIDEventSystemRef MXHIDStart();

/* Brightness */
float MXHIDGetDisplayBrightness();
void MXHIDSetDisplayBrightness(float brightness);

/* UILock */
void MXHIDSetUILocked(BOOL locked);

typedef enum __hidButtonMapping {
	kAtvBtnLeft = 0x8b,
	kAtvBtnRight = 0x8a,
	kAtvBtnDown = 0x8d,
	kAtvBtnUp = 0x8c,
	kAtvBtnPlay = 0xcd,
	kAtvBtnMenu = 0x86,
	kAtvBtnSelect = 0x41,
	
	kDevBtnHome = 64,
	kDevBtnLock = 48,
	kDevBtnVolDown = 234,
	kDevBtnVolUp = 233,
} hidButtonMapping;

void hid_convertForPosition(CGPoint pos, mach_port_t* port, CGPoint* finalPosition, CGPoint* globalPosition);