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