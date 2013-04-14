/* HID: Header */

#import "MXHIDController.h"
#import "MXController+EventHandling.h"
#import "MXMultitouchHandler.h"
#import "MXIOTools.h"

#import <GraphicsServices/GraphicsServices.h>
#include <dispatch/dispatch.h>

static BOOL _debugHidMultitouch;

static BOOL _isEventPump;
static IOHIDEventSystemRef __hidSystem;
static CGSize _mainScreenSize;
static int _deviceType;
static dispatch_queue_t _mtq;

#pragma mark Event Handling 

float MXScale()
{
	if (_deviceType == 2) {
		return 2;
	}
	else {
		return 1;
	}
}

void MXHIDHandleACEvent(IOHIDEventRef event)
{
	float x = IOHIDEventGetFloatValue(event, kIOHIDEventFieldAccelerometerX);
	float y = IOHIDEventGetFloatValue(event, kIOHIDEventFieldAccelerometerY);
	float z = IOHIDEventGetFloatValue(event, kIOHIDEventFieldAccelerometerZ);
	
	x = x; y = y; z = z; /* lol */
	
	//MSLog(@"AC: %f %f %f",x,y,z);
}

void MXHIDHandleKBEvent(IOHIDEventRef event)
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	int isDown = IOHIDEventGetIntegerValue(event, kIOHIDEventFieldKeyboardDown);
	
	//46 - ringer
	
	GSEventRecord record;
	memset(&record, 0, sizeof(record));
	
	record.timestamp = GSCurrentEventTimestamp();
	
	/*
	 usage kb
	 233: button up
	 234: button down
	 
	 64: home button
	 48: lock button
	 */
	
	switch (IOHIDEventGetIntegerValue(event, kIOHIDEventFieldKeyboardUsage))
	{
		case 64: /* Home button */
			if (isDown == 1)
			{
				record.type = kGSEventMenuButtonDown;
			}
			else 
			{
				record.type = kGSEventMenuButtonUp;
			}
			break;
		case 48: /* Lock button */
			if (isDown == 1)
			{
				record.type = kGSEventLockButtonDown;
			}
			else 
			{
				record.type = kGSEventLockButtonUp;
			}
			break;
		case 234:
			if (isDown == 1)
			{
				record.type = kGSEventVolumeDownButtonDown;
			}
			else 
			{
				record.type = kGSEventVolumeDownButtonUp;
			}
			break;
		case 233: /* vol up  */
			if (isDown == 1)
			{
				record.type = kGSEventVolumeUpButtonDown;
			}
			else 
			{
				record.type = kGSEventVolumeUpButtonUp;
			}
			break;
			
	}
	
	/* Only we need to handle button events */
	GSSendSystemEvent(&record);
	
	[pool release];
}

static CAWindowServerDisplay* _mainDisplay = NULL;

void hid_convertForPosition(CGPoint pos, mach_port_t* port, CGPoint* finalPosition, CGPoint* globalPosition)
{
	__block CGPoint position = pos;
	Float32 scaleFactor = MXScale();
	
	if (!_isEventPump && !_mainDisplay) {
		NSArray* windowServerDisplays = [[CAWindowServer serverIfRunning] displays];
		_mainDisplay = [windowServerDisplays objectAtIndex:0];
	}
	
	if (_deviceType == 1 &&
		!_isEventPump) /* Wildcat only */
	{
		/*
		 * Reverse X and Y around and 
		 * invert the Y coordinate on Wildcat
		 * based devices (because the screen's native mode is landscape).
		 * 
		 * Unless we are the event pump in which case everything is normal.
		 */
		
		Float32 x = position.x;
		position.x = position.y;
		position.y = 1.0 - x;
	}
	
	if (_isEventPump) {
		/* Apps running with 'com.apple.eventpump' behave in a more uniform way*/
		position.x = position.x * _mainScreenSize.height;
		position.y = position.y * _mainScreenSize.width;
	}
	else {
		position.x = position.x * _mainScreenSize.width;
		position.y = position.y * _mainScreenSize.height;
	}
	
	position.y = roundf(position.y);
	position.x = roundf(position.x);
	
	if (globalPosition != NULL) 
		*globalPosition = CGPointMake(position.x / scaleFactor, position.y / scaleFactor);
	
	if (!_isEventPump) {
		uint32_t context = [_mainDisplay contextIdAtPosition:position];
		
		if (port != NULL)
			*port = [_mainDisplay clientPortOfContextId:context];
		
		/* 
		 *
 		 * XXX: This is the source of all problems 
		 *
		 * Apple decided to be fucktarded so this function no longer works
		 * properly with non-fullscreen apps (since all of iOS's apps are 
		 * fullscreen). This means that I will have to write my own version of it
		 * in order to get back multitouch support.
		 *
		 * Fuck everything about this.
		 */
		position = [_mainDisplay convertPoint:position toContextId:context];
	
	}
	else {
		if (port != NULL)
			*port = 0;
	}
	
	
	position.x = position.x / scaleFactor;
	position.y = position.y / scaleFactor;
	
	*finalPosition = position;
}

void hid_xxHandleMultitouchEvent(IOHIDEventRef event)
{
	/* new multitouch handling code */
	
	CFArrayRef children = IOHIDEventGetChildren(event);
	CFIndex childrenCount = 0;
	
	if (children && (childrenCount = CFArrayGetCount(children))) 
	{
		/* gs structures */
		size_t gsInfoSize = 
		sizeof(GSHandInfo) + (sizeof(GSPathInfo) * childrenCount);
		
		size_t gsFullEventSize = 
		sizeof(GSEventRecord) + gsInfoSize;
		
		GSEventTouch* gsEvent = 
		(GSEventTouch*)calloc(1, gsFullEventSize);
		
		CGPoint globalPosition;
		mach_port_t destinationPort;
		
		for (int i = 0; i < childrenCount; i++) 
		{
			IOHIDEventRef child = 
			(IOHIDEventRef)CFArrayGetValueAtIndex(children, i);
			
			uint32_t mt_mask = IOHIDEventGetIntegerValue(child, kIOHIDEventFieldDigitizerEventMask);
			boolean_t mt_touch = IOHIDEventGetIntegerValue(child, kIOHIDEventFieldDigitizerTouch);
			
			CGPoint position;
			CGPoint originalPosition = CGPointMake(IOHIDEventGetFloatValue(event, kIOHIDEventFieldDigitizerX),
												   IOHIDEventGetFloatValue(event, kIOHIDEventFieldDigitizerY));
			
			position = originalPosition;
			
			if (i == 0) {
				/* Initialize the event structure using the root path */
				
				/* gs record */
				gsEvent->record.infoSize = gsInfoSize;
				gsEvent->record.timestamp = GSCurrentEventTimestamp();
				gsEvent->record.location = position;
				gsEvent->record.windowLocation = position;
				gsEvent->record.type = kGSEventHand;
				
				/* gs hand data */
				gsEvent->data.pathInfosCount = childrenCount;
				if (mt_mask == 3 || mt_mask == 1)
				{
					if (mt_touch) {
						/* InRange  Touching */
						gsEvent->data.type = kGSHandInfoTypeTouchDown;
						gsEvent->data.deltaX = 1;
						gsEvent->data.deltaY = 1;
						
						/* Not sure about this flag */
						gsEvent->data.wat = 1; 
					}
					else {
						/* OutOfRange  UnTouch*/
						gsEvent->data.type = kGSHandInfoTypeTouchUp;
						gsEvent->data.deltaX = 1;
						gsEvent->data.deltaY = 0;
					}
				}
				else if (mt_mask == 4) 
				{
					/* InRange  Touching  dPosition */
					gsEvent->data.type = kGSHandInfoTypeTouchMoved;
					gsEvent->data.deltaX = 1;
					gsEvent->data.deltaY = 1;
				}
				else if (mt_mask == 2) 
				{
					/* InRange  UnTouch */
					gsEvent->data.type = kGSHandInfoTypeTouchUp;
					gsEvent->data.deltaX = 1;
					gsEvent->data.deltaY = 0;
				}
				else 
				{
					/* 
					 * Unknown mask
					 * Will not be sent as UIKit will not understand it.
					 */
					
					free(gsEvent);
					return;
				}
			}
			
			/* gs path data */
			void* memOffset = (((char*)gsEvent) + sizeof(*gsEvent)) + ((int)(sizeof(GSPathInfo)) * i);
			GSPathInfo* pathInfo = (GSPathInfo*)memOffset;
			
			pathInfo->pathPressure = IOHIDEventGetFloatValue(child, kIOHIDEventFieldDigitizerPressure);
			pathInfo->pathIndex = IOHIDEventGetIntegerValue(child, kIOHIDEventFieldDigitizerIndex);
			pathInfo->pathIdentity = IOHIDEventGetIntegerValue(child, kIOHIDEventFieldDigitizerIdentity);
			pathInfo->pathMajorRadius = IOHIDEventGetFloatValue(child, kIOHIDEventFieldDigitizerMajorRadius);
			
			if (mt_touch) 
				pathInfo->pathProximity = 0x03; /* close */
			else 
				pathInfo->pathProximity = 0x10; /* far */
			
			pathInfo->pathLocation.x = position.x;
			pathInfo->pathLocation.y = position.y;
		}
		
		
		
		/* fixup the points */
		for (uint32_t i = 0; i < childrenCount; i++) {
			void* memOffset = (((char*)gsEvent) + sizeof(*gsEvent)) + ((int)(sizeof(GSPathInfo)) * i);
			GSPathInfo* pathInfo = (GSPathInfo*)memOffset;
			CGPoint old = pathInfo->pathLocation;
			
			/* ohai */
			hid_convertForPosition(pathInfo->pathLocation,
								   (mach_port_t*)&destinationPort,
								   &pathInfo->pathLocation,
								   (CGPoint*)&globalPosition);
		}
		
		
		if (destinationPort != 0 && [[MXMultitouchHandler shared] handleMultitouchEventInPort:destinationPort
																					  atPoint:globalPosition
																						 type:gsEvent->data.type]) 
		{
			GSSendEvent(&gsEvent->record, destinationPort);
		}
		else 
		{
			GSSendSystemEvent(&gsEvent->record);
		}
		
		free(gsEvent);
	}
	else
	{
		failmsg("No event children in digitizer event.");
	}
}

void hid_handleMultitouchEvent(IOHIDEventRef event)
{
	hid_xxHandleMultitouchEvent(event);
}

void MXHIDHandleMTEvent (IOHIDEventRef event)
{
	/* legacy multitouch code
	   (leaks memory)
	 */
	
	CFArrayRef eventChildren = IOHIDEventGetChildren(event);
	
	if (eventChildren != NULL)
	{
		CFIndex eventChildrenCount = CFArrayGetCount(eventChildren);
		
		if (eventChildrenCount != 0)
		{
			/** **/
			int infoSize = sizeof(GSHandInfo) + (sizeof(GSPathInfo) * eventChildrenCount);
			int fullEventSize = sizeof(GSEventRecord) + infoSize;
			GSEventTouch* event_struct = (GSEventTouch*)calloc(1, fullEventSize);
			
			CAWindowServerDisplay* display;
			unsigned char proximity;
			mach_port_t port;
			CGPoint originalLocation;
			
			if (_debugHidMultitouch)
				MSLog(@"HID Multitouch: %d Events",eventChildrenCount);
			
			for (int i = 0; i < eventChildrenCount; i++) 
			{
				IOHIDEventRef childEvent = (IOHIDEventRef)CFArrayGetValueAtIndex(eventChildren, i);
				
				int event_type = IOHIDEventGetType(childEvent);
				
				int event_index = IOHIDEventGetIntegerValue(childEvent, kIOHIDEventFieldDigitizerIndex);
				
				if (_debugHidMultitouch)
					MSLog(@"    pathID %d childType %d",event_index,event_type);
				
				if (event_type != kIOHIDEventTypeDigitizer)
				{
					failmsg("Digitizer event's child is not a digitizer event");
				}
				else 
				{
					int event_flags = IOHIDEventGetEventFlags(childEvent);
					int event_touch = IOHIDEventGetIntegerValue(childEvent, kIOHIDEventFieldDigitizerTouch);
					int event_mask = IOHIDEventGetIntegerValue(childEvent, kIOHIDEventFieldDigitizerEventMask);
					int event_ident = IOHIDEventGetIntegerValue(childEvent, kIOHIDEventFieldDigitizerIdentity);
					float event_x = IOHIDEventGetFloatValue(childEvent, kIOHIDEventFieldDigitizerX);
					float event_y = IOHIDEventGetFloatValue(childEvent, kIOHIDEventFieldDigitizerY);
					float event_z = IOHIDEventGetFloatValue(childEvent, kIOHIDEventFieldDigitizerZ);
					float event_pressure = IOHIDEventGetFloatValue(childEvent, kIOHIDEventFieldDigitizerPressure);
					float major_radius = IOHIDEventGetFloatValue(childEvent, kIOHIDEventFieldDigitizerMajorRadius);
					
					if (i == 0 && !_isEventPump) {
						NSArray* windowServerDisplays = [[CAWindowServer serverIfRunning] displays];
						display = [windowServerDisplays objectAtIndex:0];
					}
					
					if (_deviceType == 1 &&
						!_isEventPump) /* iPad */
					{
						/* store x's value */
						float ____x = event_x;
						/* reverse x and y */
						event_x = event_y;
						/* flip y around */
						event_y = 1.0 - ____x;
					}
					
					/* BEGIN BLACK MAGIC */
					if (_isEventPump) {
						/* iPads are weird ... */
						event_x = event_x * _mainScreenSize.height;
						event_y = event_y * _mainScreenSize.width;
					}
					else {
						event_x = event_x * _mainScreenSize.width;
						event_y = event_y * _mainScreenSize.height;
					}
					
					CGPoint location = CGPointMake(lround(event_x), lround(event_y));
					originalLocation = location;
					
					if (!_isEventPump) {
						if (i == 0) {
							port = [display clientPortAtPosition:location];
						}
						
						location = [display convertPoint:location toContextId:[display contextIdAtPosition:location]];
					}
					else {
						port = 0;
					}

					
					location.x = location.x / MXScale();
					location.y = location.y / MXScale();
					
					originalLocation.x = originalLocation.x / MXScale();
					originalLocation.y = originalLocation.y / MXScale();
					/* END BLACK MAGIC */
					
					if (_debugHidMultitouch)
						MSLog(@"       identity %d flags %d touch %d mask %d x %f y %f z %f pressure %f majorRadius: %f",event_ident,event_flags,event_touch,event_mask,event_x,event_y,event_z,event_pressure,major_radius);
			
					
					if (i == 0) {
						event_struct->record.windowLocation = location;
						
						AbsoluteTime time = IOHIDEventGetTimeStamp(event);
						uint64_t ts = *(uint64_t*)(&time);
						
						event_struct->record.timestamp = ts;
						event_struct->record.type = kGSEventHand;
						
						/*
						 Down : 1
						 Up   : 6
						 Moved: 2
						 */
						
						if(event_mask == 3 || event_mask == 1)
						{
							if (event_touch == 1)
							{
								/* TouchDown */
								
								event_struct->data.type = kGSHandInfoTypeTouchDown;
								event_struct->data.deltaX = 1;
								event_struct->data.deltaY = 1;
								event_struct->data.wat = 1; /* wat? */
								proximity = 0x03;
							}
							else 
							{
								/* TouchUp */
								
								event_struct->data.type = kGSHandInfoTypeTouchUp;
								event_struct->data.deltaX = 1;
								event_struct->data.deltaY = 0;
								proximity = 0x10;
							}
						}
						else if (event_mask == 4)
						{
							/* TouchMoved */
							
							event_struct->data.type = kGSHandInfoTypeTouchMoved;
							event_struct->data.deltaX = 1;
							event_struct->data.deltaY = 1;
							proximity = 0x03;
						}
						else {
							return;
						}

						event_struct->data.pathInfosCount = eventChildrenCount;
						event_struct->record.infoSize = infoSize;
					}
				
					/* work out the pathInfo offset */
					void* memOffset = (((char*)event_struct) + sizeof(*event_struct)) + ((int)(sizeof(GSPathInfo)) * i);
					GSPathInfo* pathInfo = (GSPathInfo*)memOffset;
					
					pathInfo->pathPressure = event_pressure;
					pathInfo->pathIndex = event_index;
					pathInfo->pathIdentity = event_ident;
					pathInfo->pathMajorRadius = major_radius;
					pathInfo->pathProximity = proximity;
					
					pathInfo->pathLocation.x = location.x;
					pathInfo->pathLocation.y = location.y;
				}
	
			}
			
			if (port != 0)
			{				
				if ([[MXMultitouchHandler shared] handleMultitouchEventInPort:port
																	  atPoint:originalLocation
																		 type:event_struct->data.type])
				{
					GSSendEvent(&event_struct->record,port);
				}
			}
			else 
			{
				GSSendSystemEvent(&event_struct->record);
			}
			
			/**/
			free(event_struct);
		}
	}
}

void MXHIDHandleEvent (void* target, void* refcon, IOHIDServiceRef service, IOHIDEventRef event)
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	if (IOHIDEventGetType(event) == kIOHIDEventTypeDigitizer)
	{
		hid_handleMultitouchEvent(event);
	}
	else if (IOHIDEventGetType(event) == kIOHIDEventTypeKeyboard)
	{
		MXHIDHandleKBEvent(event);
	}
	else if (IOHIDEventGetType(event) == kIOHIDEventTypeAccelerometer)
	{
		MXHIDHandleACEvent(event);
	}
	else if (IOHIDEventGetType(event) == kIOHIDEventTypeAmbientLightSensor)
	{
		
	}
	else {
		MSLog(@"Unknown HID event: %d",IOHIDEventGetType(event));
	}

	[pool release];
}

#pragma mark Service Operations

IOHIDServiceRef MXHIDGetService(int UsagePage,int Usage)
{
	CFDictionaryRef services = (CFDictionaryRef)[NSDictionary dictionaryWithObjectsAndKeys:
												 [NSNumber numberWithInt:UsagePage],@"PrimaryUsagePage",
												 [NSNumber numberWithInt:Usage],@"PrimaryUsage",
												 nil];
	
	CFArrayRef servMatches = IOHIDEventSystemCopyMatchingServices(__hidSystem, services, NULL, NULL, NULL, NULL);
	
	assert(servMatches != NULL);
	
	IOHIDServiceRef serv = (IOHIDServiceRef)CFArrayGetValueAtIndex(servMatches, 0);
	CFRetain(serv);
	
	return serv;
}

IOHIDServiceRef MXHIDGetAccelerometerService()
{
	return MXHIDGetService(65280, 3);
}

#pragma mark Properties

void MXHIDSetDebugStateForService(IOHIDServiceRef service, BOOL debug)
{
	IOHIDServiceSetProperty(service, CFSTR("PrintHIDEvents"), debug ? kCFBooleanTrue : kCFBooleanFalse);
	//IOHIDServiceSetProperty(service, CFSTR("DebugHMLite"), debug ? kCFBooleanTrue : kCFBooleanFalse);
}

void MXHIDSetUILocked(BOOL locked)
{
	IOHIDEventSystemSetProperty(__hidSystem,
								CFSTR("UILocked"),
								locked ? kCFBooleanTrue : kCFBooleanFalse);
}

float MXHIDGetDisplayBrightness()
{
	CFNumberRef br = IOHIDEventSystemGetProperty(__hidSystem, CFSTR("DisplayBrightness"));
	return [(NSNumber*)br floatValue];
}

void MXHIDSetDisplayBrightness(float brightness)
{
	IOHIDEventSystemSetProperty(__hidSystem, CFSTR("DisplayBrightness"), [[NSNumber alloc] initWithFloat: brightness]);
}

#pragma mark Misc

static void hid_calibrateMultitouch() {
	IOHIDServiceRef svc = MXHIDGetService(13, 12);
	Float32 fval = 1.2347;
	CFNumberRef num;
	
	num = CFNumberCreate(kCFAllocatorDefault, kCFNumberFloatType, &fval);
	IOHIDServiceSetProperty(svc, CFSTR("FingerTipVerticalOffset"), num); 
	CFRelease(num);
	
	num = CFNumberCreate(kCFAllocatorDefault, kCFNumberFloatType, &fval);
	IOHIDServiceSetProperty(svc, CFSTR("EllipseTipGain"), num); 
	CFRelease(num); 
	
	fval = 160 * MXScale();
	num = CFNumberCreate(kCFAllocatorDefault, kCFNumberFloatType, &fval);
	IOHIDServiceSetProperty(svc, CFSTR("QuantizationDPI"), num);
	CFRelease(num);
}

#import "MXDevice.h"
IOHIDEventSystemRef _MXHIDStartInternal(BOOL isEventPump)
{
	_mtq = dispatch_queue_create("fuckEverythingAboutThis", 0);
	
	_isEventPump = isEventPump;
	_debugHidMultitouch = TRUE;
	
	if (__hidSystem != NULL) {
		MXLog(@" *** Cannot start another HID system instance!");
		return NULL;
	}
	
	if (_isEventPump) {
		/*
		 * We can't use CAWindowServer as it isn't available
		 * This is the only other way to find out the screen size
		 * This will fetch it from the Framebuffer service
		 */
		
		_mainScreenSize = MXIOGetScreenSize();
	}
	else {
		NSArray* windowServerDisplays = [[CAWindowServer serverIfRunning] displays];
		CAWindowServerDisplay* display = [windowServerDisplays objectAtIndex:0];
		
		_mainScreenSize = [display bounds].size;
	}

	__hidSystem = IOHIDEventSystemCreate(kCFAllocatorDefault);
	
	if ([[[MXDevice currentDevice] model] hasPrefix:@"iPhone3"]) {
		_deviceType = 2;
	}
	else if ([[[MXDevice currentDevice] model] hasPrefix:@"iPad"]) {
		_deviceType = 1;
	}
	else if ([[[MXDevice currentDevice] model] hasPrefix:@"AppleTV"]) {
		_deviceType = 3;
	}
	else {
		_deviceType = 0;
	}
	
	if (__hidSystem == NULL)
	{
		MXLog(@"Couldn't create hid system");
		return NULL;
	}
	else 
	{
		Boolean result = IOHIDEventSystemOpen(__hidSystem, MXHIDHandleEvent, NULL, NULL, NULL);
		
		if (result)
		{
			/* Configure HID Services */
			MXHIDSetDisplayBrightness(1.0f);
			
			if (_deviceType == 3) {
				MXLog(@"Device is an AppleTV (%d) so ignoring all HID events.",_deviceType);
				return __hidSystem;
			}
			
			/* Accelerometer report interval */
			NSNumber* interval = [[NSNumber alloc] initWithInt:1000000];
			IOHIDServiceSetProperty(MXHIDGetAccelerometerService(), CFSTR("ReportInterval"), interval);
			[interval release];
			
			//MXHIDSetDebugStateForService(MXHIDGetService(13, 12), TRUE);
			hid_calibrateMultitouch();
			
			/* Completed */
			MXLog(@"Hid system started (Device:%d)",_deviceType);
			return __hidSystem;
		}
		else 
		{
			MXLog(@"Couldn't open hid system");
			return NULL;
		}
		
	}
}

IOHIDEventSystemRef MXHIDStartEventPump()
{
	return _MXHIDStartInternal(TRUE);
}

IOHIDEventSystemRef MXHIDStart()
{
	return _MXHIDStartInternal(FALSE);
}