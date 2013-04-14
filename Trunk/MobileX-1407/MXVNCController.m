//
//  MXVNCController.m
//  MobileX
//
//  Created by Nick on 31/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
#if TARGET_CPU_ARM

#import "MXVNCController.h"
#import "MXDevice.h"
#import "CARenderServer.h"
#import "MXMainLayer.h"
#import <IOSurface/IOSurfaceAPI.h>
#import "MXPaneManager.h"
#import "MXHostWindow.h"
#import "MXApplication.h"
#include "keysym.h"

static id _shinst = NULL;

typedef IOReturn IOSurfaceAcceleratorReturn;
extern CFStringRef kIOSurfaceAcceleratorForceMaxSpeedKey;
typedef struct __IOSurfaceAccelerator *IOSurfaceAcceleratorRef;

IOSurfaceAcceleratorReturn IOSurfaceAcceleratorCreate(CFAllocatorRef allocator,
													  uint32_t type,
													  IOSurfaceAcceleratorRef *outAccelerator);

IOSurfaceAcceleratorReturn IOSurfaceAcceleratorTransferSurface(IOSurfaceAcceleratorRef accelerator,
															   IOSurfaceRef sourceSurface,
															   IOSurfaceRef destSurface,
															   CFDictionaryRef dict,
															   void *unknown);


void
set_int(CFMutableDictionaryRef dict, CFStringRef key, uint32_t val)
{
	CFNumberRef num =
	CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &val);
	
	CFDictionarySetValue(dict, key, num);
	
	CFRelease(num);
}

void single_touch(CGFloat x, CGFloat y, uint8_t type) {
	
	CGPoint final = CGPointMake(0, 0);

	NSArray* windowServerDisplays = [[CAWindowServer serverIfRunning] displays];
	CAWindowServerDisplay* mainDisplay = [windowServerDisplays objectAtIndex:0];
	
	uint32_t context = [mainDisplay contextIdAtPosition:CGPointMake(x, y)];
	
	mach_port_t port = [mainDisplay clientPortOfContextId:context];
	final = [mainDisplay convertPoint:CGPointMake(x, y) toContextId:context];
	
	x = final.x;
	y = final.y;
	
	SingleTouch* st = 
	(SingleTouch*)calloc(1, sizeof(SingleTouch));
	
	st->record.infoSize = sizeof(GSHandInfo) + sizeof(GSPathInfo);
	st->record.timestamp = GSCurrentEventTimestamp();
	st->record.type= kGSEventHand;
	
	st->record.location.x = x;
	st->record.location.y = y;
	
	st->record.windowLocation.x = x;
	st->record.windowLocation.y = y;	
	
	st->data.pathInfosCount = 1;
	
	if (type == 0) {
		st->data.type = kGSHandInfoTypeTouchDown;
		st->data.deltaX = 1;
		st->data.deltaY = 1;
		st->data.wat = 1;
		st->path.pathProximity = 0x03;
		
	}
	else if (type == 1) {
		st->data.type = kGSHandInfoTypeTouchUp;
		st->data.deltaX = 1;
		st->data.deltaY = 0;
		st->data.wat = 0;
		st->path.pathProximity = 0x10;
	}
	else {
		st->data.type = kGSHandInfoTypeTouchMoved;
		st->data.deltaX = 1;
		st->data.deltaY = 1;
		st->path.pathProximity = 0x03;
	}
	
	st->path.pathIndex = 1;
	st->path.pathLocation.x = x;
	st->path.pathLocation.y = y;
	st->path.pathMajorRadius = 10.0f;
	st->path.pathIdentity = 1;
	st->path.pathPressure = 0;
	
	if (port) {
		GSSendEvent((GSEventRecord*)st, port);
	}
	else {
		GSSendSystemEvent((GSEventRecord*)st);
	}
	
	free(st);
}



IOSurfaceRef
allocate_surface(void* display,
				 uint32_t width,
				 uint32_t height,
				 uint32_t bytesPerRow,
				 uint32_t bytesPerElement,
				 const char* memoryRegion,
				 bool isTiled,
				 bool isGlobal)
{
	CFMutableDictionaryRef surfaceDict =
	CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
	
	/* Allocation Data */
	set_int(surfaceDict,kIOSurfaceWidth,width);
	set_int(surfaceDict,kIOSurfaceHeight,height);
	set_int(surfaceDict,kIOSurfaceAllocSize,bytesPerRow * height);
	
	/* Framebuffer Transfer Format */
	set_int(surfaceDict,kIOSurfacePixelFormat,1111970369);
	set_int(surfaceDict,kIOSurfaceBytesPerRow,bytesPerRow);
	set_int(surfaceDict,kIOSurfaceBytesPerElement,bytesPerElement);
	
	/* MBX/SGX uses this */
	CFDictionarySetValue(surfaceDict,
						 CFSTR("IOSurfaceBufferTileMode"),
						 isTiled ? kCFBooleanTrue : kCFBooleanFalse);
	
	/* IOSurface Sharing */
	if (isGlobal) {
		CFDictionarySetValue(surfaceDict, kIOSurfaceIsGlobal, kCFBooleanTrue);
	}
	
	if (memoryRegion != NULL) {
		CFStringRef memcf = 
		CFStringCreateWithCString(kCFAllocatorDefault, memoryRegion, kCFStringEncodingUTF8);
		
		CFDictionarySetValue(surfaceDict, kIOSurfaceMemoryRegion, memcf);
		
		CFRelease(memcf);
	}
	
	IOSurfaceRef surface = 
	IOSurfaceCreate(surfaceDict);
	
	CFRelease(surfaceDict);
	
	return surface;
}

#import "MXController.h"

@implementation MXVNCController

+ (id) shared
{
	if (_shinst==NULL)
	{
		_shinst = [MXVNCController alloc];
		[_shinst init];
	}
	
	return _shinst;
}



- (void) _updateVncScreen {
	uint32_t width = rfbServer->width;
	uint32_t height = rfbServer->height;
	
	uint32_t bytesPerComponent = 4;
	uint32_t bytesPerRow = width * bytesPerComponent;
	uint32_t allocSize = width * height * bytesPerComponent;
	
	IOSurfaceRef sfc = 
	allocate_surface(NULL,
					 width,
					 height,
					 bytesPerRow,
					 bytesPerComponent,
					 "PurpleEDRAM",
					 false,
					 true);

	OSType pixelFormat = 'BGRA';
	
	CALayer *screenLayer = [MXMainLayer mainLayer];
	uint32_t *layerBuffer = (uint32_t *)malloc(allocSize);
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	CGContextRef layerBufferCtx = CGBitmapContextCreate(layerBuffer,
														width,
														height,
														8,
														width * 4,
														colorSpace,
														kCGImageAlphaPremultipliedLast);
	
	CGContextScaleCTM(layerBufferCtx,
					  (width / screenLayer.frame.size.width),
					  (height / screenLayer.frame.size.height));
	
	rfbServer->serverFormat.redShift = 16;
	rfbServer->serverFormat.greenShift = 8;
	rfbServer->serverFormat.blueShift = 0;
	
	IOSurfaceAcceleratorRef accelerator;
	
	IOSurfaceAcceleratorCreate(kCFAllocatorDefault, 0, &accelerator);
	
	/* time for some scaling! */
	CFStringRef keys[1] = {kIOSurfaceAcceleratorForceMaxSpeedKey}; 
	CFTypeID values[1] = {(CFTypeID)kCFBooleanTrue}; 
	
	/* ugh, corefoundation */
	CFDictionaryRef dict = CFDictionaryCreate(kCFAllocatorDefault,
											  (const void**)keys,
											  (const void**)values,
											  1,
											  &kCFTypeDictionaryKeyCallBacks,
											  &kCFTypeDictionaryValueCallBacks);
	
	
	while(_serverStarted)
	{
		if(rfbServer->clientHead)
		{
			IOSurfaceLock(sfc, 1, NULL);
			rfbServer->frameBuffer = (char *)IOSurfaceGetBaseAddress(sfc);
			IOSurfaceUnlock(sfc, 1, NULL);
			
			
			
			IOSurfaceAcceleratorTransferSurface(accelerator,
												IOSurfaceLookup(1),
												sfc,
												dict,
												NULL);
			
			/*
			CARenderServerRenderLayerWithTransform(NULL,
												   [[MXController shared] contextId],
												   screenLayer,
												   NULL,
												   sfc, 
												   NULL,
												   NULL,
												   &CATransform3DIdentity);
			
			
			 */
			
			rfbMarkRectAsModified(rfbServer, 0, 0, rfbServer->width, rfbServer->height);
			rfbServer->frameBuffer = (char*)IOSurfaceGetBaseAddress(sfc);
		}
		
		_cursor = CGPointMake(rfbServer->cursorX, rfbServer->cursorY);
		rfbProcessEvents(rfbServer, rfbServer->deferUpdateTime);
	}
}

static bool _isTouching = false;

static void curEvent (int buttonMask, int x, int y, struct _rfbClientRec* cl) 
{
	//printf("[vnc]: cur %d %d %p\n",x,y,buttonMask);
	if (buttonMask == 0x1) {
		if (!_isTouching) {
			/* touch down */
			single_touch((CGFloat)x, (CGFloat)y, 0);
			_isTouching = true;
		}
		else {
			/* touch down */
			single_touch((CGFloat)x, (CGFloat)y, 2);
		}
	}
	else if (_isTouching) {
		single_touch((CGFloat)x, (CGFloat)y, 1);
		_isTouching = false;
	}
	
	//single_touch(x, (CGFloat)y, aa)
}

static void clientGone(rfbClientPtr cl)
{
}

static enum rfbNewClientAction newClient(rfbClientPtr cl)
{
	cl->clientData = (void *)1;
	cl->clientGoneHook = clientGone;
	cl->enableCursorPosUpdates = true;
	
	printf("[vnc]: new client on %s\n", cl->host);
	
	return RFB_CLIENT_ACCEPT;
}

static rfbBool passCheck(rfbClientPtr client, const char *data, int size) 
{
	return true;
}

static void kbdEvent(rfbBool down, rfbKeySym key, struct _rfbClientRec *cl)
{
	if (!down)
        return;
	
	switch (key) {
        case XK_Return: key = '\r'; break;
        case XK_BackSpace: key = 0x7f; break;
    }
	
    if (key > 0xfff)
        return;

    UniChar unicode = key;
    CFStringRef string = NULL;
	
    GSEventRef event0, event1;
	event0 = NULL; event1 = NULL;

	CGPoint point = CGPointMake(0, 0);
	
	GSEventRef GSEventCreateKeyEvent(GSEventType type,
									 CGPoint windowLocation,
									 CFStringRef characters,
									 CFStringRef unmodifiedCharacters,
									 GSEventFlags modifiers,
									 uint16_t usagePage,
									 unsigned options7, unsigned options8);
	
	string = CFStringCreateWithCharacters(kCFAllocatorDefault, &unicode, 1);
	event0 = GSEventCreateKeyEvent(10, point, string, string, 0, 0, 0, 1);
	event1 = GSEventCreateKeyEvent(11, point, string, string, 0, 0, 0, 1);
	
	if ([[[MXPaneManager shared] activePane] isKindOfClass:[MXHostWindow class]]) {
		MXHostWindow* host = (MXHostWindow*)[[MXPaneManager shared] activePane];
		
		MSLog(@"send key to %@",[host application]);
		
		GSSendEvent(_GSEventGetGSEventRecord(event0), [[host application] eventPort]);
		GSSendEvent(_GSEventGetGSEventRecord(event1), [[host application] eventPort]);
	}
}


- (void) _startVncServer {
	rfbServer = rfbGetScreen(0,
							 NULL,
							 [[MXDevice currentDevice] screenSize].width,
							 [[MXDevice currentDevice] screenSize].height,
							 8,
							 3,
							 4);
	
	assert(rfbServer != NULL);
	
	rfbServer->desktopName = "MobileX VNC Server";
	rfbServer->alwaysShared = TRUE;
	rfbServer->handleEventsEagerly = TRUE;
	rfbServer->deferUpdateTime = 40;
	rfbServer->cursor = NULL;
	rfbServer->kbdAddEvent = &kbdEvent;
	rfbServer->ptrAddEvent = &curEvent;
	rfbServer->newClientHook = &newClient;
	
	_serverStarted = true;
	
	rfbInitServer(rfbServer);
}

- (id) init {
	if (self = [super init]) {
		[self _startVncServer];
		
		[NSThread detachNewThreadSelector:@selector(_updateVncScreen)
								 toTarget:self
							   withObject:nil];
	}
	return self;
}

@end

#else


#import "MXController.h"
#import "MXVNCController.h"
static id _shinst = NULL;

@implementation MXVNCController
+ (id) shared
{
	if (_shinst==NULL)
	{
		_shinst = [MXVNCController alloc];
		[_shinst init];
	}
	
	return _shinst;
}
- (void) _updateVncScreen{};
- (void) _startVncServer{};
@end

#endif
