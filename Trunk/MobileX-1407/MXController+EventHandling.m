//
//  MXController+EventHandling.m
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXController+EventHandling.h"
#import "MXPane.h"
#import "MXPaneManager.h"
#import "MXMultitouchHandler.h"
#import "MXHIDController.h"
#import "MXRPCCommon.h"

#import <GraphicsServices/GraphicsServices.h>
#import <notify.h>

@implementation MXController (MXCEventHandling)

- (void) _handleMultitouchEvent:(float)x y:(float)y touchType:(MTTouchType)type finger:(int)finger
{
	CGPoint gp = CGPointMake(x, y);
	[[MXMultitouchHandler shared] handleMultitouchEvent:gp type:type];
MXSLog(@"_handleMultitouchEvent");
	   }

- (void) _processDigitizerEvent:(GSEventRef)event
{
	GSHandInfo handInfo = GSEventGetHandInfo(event);
	GSPathInfo pathInfo = GSEventGetPathInfoAtIndex(event, 0);
	
	/* this is annoying */
	CGPoint location = CGPointMake(MXScale()*(pathInfo.pathLocation.x), MXScale()*(pathInfo.pathLocation.y));
	
	MXSLog(@"_processDigitizerEvent: %i at %f,%f", handInfo.type, location.x, location.y);
	
	if (handInfo.type == kGSHandInfoTypeTouchDown) 
	{
		[self _handleMultitouchEvent:location.x y:location.y touchType:kMXTBegin finger:1];
	}
	else if (handInfo.type == kGSHandInfoTypeTouchUp)
	{
		[self _handleMultitouchEvent:location.x y:location.y touchType:kMXTEnd finger:1];
	}
	else if (handInfo.type == kGSHandInfoTypeTouchMoved)
	{
		[self _handleMultitouchEvent:location.x y:location.y touchType:kMXTMoved finger:1];
	}
	
}

- (void) _processBrightnessChangedEvent:(GSEventRef)event
{
	/* This will work as long as the GSEvent isn't garbage */
	
	NSData* data = [(NSDictionary*)GSEventCreatePlistRepresentation(event) objectForKey:@"Data"];
	float* d = (float*)[data bytes];
	MXHIDSetDisplayBrightness(*d);
}

- (void) clientApplicationLaunched:(GSEventRef)event
{
	/* I've got no idea why there is an offset. */
	GSEventRecord* rec = (char*)event + 8;
	
	int infSz = rec->infoSize;
	int pid = rec->senderPID;
	//MSLog(@"%d %d %@",infSz,pid,GSEventCreatePlistRepresentation(event));
	
	//MSLog(@"off %d",sizeof(GSEventRecord))
	//;	CPProbeInMemStruct(rec, sizeof(GSEventRecord),sizeof(GSEventRecord)+infSz);
}

static NSTimer *exposeTimer;

- (void)homeButtonHeld {
    [[MXPaneManager shared] toggleExpose];
    exposeTimer = nil;
}

- (void) _processButtonEvent:(MXHardwareButton)button isDown:(BOOL)isDown
{
	if (button == kMXHardwareButtonMenu)
    {
        if (!isDown) {
            if (exposeTimer != nil) {
                if ([[MXPaneManager shared] exposeActive]) {
                    [[MXPaneManager shared] toggleExpose];
                } else {
                    notify_post("com.mx.menubutton");
                }
				
                [exposeTimer invalidate];
                exposeTimer = nil;
            }
        } else if (isDown) {
            if (exposeTimer == nil) {
                exposeTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(homeButtonHeld) userInfo:nil repeats:NO];
            }
        }
    }
	else if (button == kMXHardwareButtonPower)
	{
		if (!isDown) [[MXSleepController shared] toggleSleepState];
	}
	else if (button == kMXHardwareButtonVolumeUp && !isDown)
	{
		[[MXPaneManager shared] toggleReveal];
	}
	else if (button == kMXHardwareButtonVolumeDown && !isDown)
	{
		[[[MXController shared] mainLayer] takeScreenshot];
	}
}

- (void) handleEvent:(void*)event
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	GSEventType evt = GSEventGetType(event);
	
	if (GSEventIsHandEvent(event))
		evt = kGSEventHand;
	
	switch (evt) {
		case kGSEventVolumeUpButtonDown:
			[self _processButtonEvent:kMXHardwareButtonVolumeUp isDown:TRUE]; 
			break;
		case kGSEventVolumeUpButtonUp:
			[self _processButtonEvent:kMXHardwareButtonVolumeUp isDown:FALSE]; 
			break;
		case kGSEventVolumeDownButtonDown:
			[self _processButtonEvent:kMXHardwareButtonVolumeDown isDown:TRUE]; 
			break;
		case kGSEventVolumeDownButtonUp:
			[self _processButtonEvent:kMXHardwareButtonVolumeDown isDown:FALSE]; 
			break;
		case kGSEventLockButtonUp:
			[self _processButtonEvent:kMXHardwareButtonPower isDown:FALSE]; 
			break;
		case kGSEventLockButtonDown:
			[self _processButtonEvent:kMXHardwareButtonPower isDown:TRUE]; 
			break;
		case kGSEventMenuButtonUp:
			[self _processButtonEvent:kMXHardwareButtonMenu isDown:FALSE]; 
			break;
		case kGSEventMenuButtonDown:
			[self _processButtonEvent:kMXHardwareButtonMenu isDown:TRUE]; 
			break;			
		case kGSEventHand:
			[self _processDigitizerEvent:event];
			break;
		case kGSEventResetIdleTimer:
			break;
		case kGSEventAnotherApplicationFinishedLaunching:
			[self clientApplicationLaunched:event];
			break;
		case kGSEventSetBacklightLevel:
			[self _processBrightnessChangedEvent:event];
			break;
		default:
		{
#if TARGET_CPU_ARM
			
			MXSLog(@"Unknown event of type: %d",evt);
#else
			MXSLog(@"Handling simulated touch event");
			
			[self _processDigitizerEvent:event];
#endif
			break;
		}
	}
	
	[pool release];
}

@end
