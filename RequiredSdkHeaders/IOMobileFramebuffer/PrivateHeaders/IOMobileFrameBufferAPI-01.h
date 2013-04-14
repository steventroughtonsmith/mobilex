/*
 *  FrameBufferAPI.h
 *  IOMobileFrameBuffer
 *
 *  Copyright 2006-2010 Apple Computer, Inc. All rights reserved.
 *
 */

#import <IOKit/IOTypes.h>
#import <IOKit/IOKitLib.h>
#import <IOSurface/IOSurfaceAPI.h>
#import <CoreGraphics/CoreGraphics.h>

#define kIOMobileFramebufferError 0xE0000000

#ifdef __cplusplus
extern "C" {
#endif

typedef kern_return_t IOMobileFramebufferReturn;
typedef io_service_t IOMobileFramebufferService;
typedef io_connect_t IOMobileFramebufferRef;

/*
	Sets the display device for a framebuffer client
	This differs for each device and OS
*/
IOMobileFramebufferReturn 
IOMobileFramebufferSetDisplayDevice(IOMobileFramebufferRef connection, int majorId, int minorId);
									
/* Opens connection to the framebuffer service */
IOMobileFramebufferReturn 
IOMobileFramebufferOpen(IOMobileFramebufferService service, task_port_t owningTask, unsigned int type, IOMobileFramebufferRef * connection);

/* Default surface for layer, shouldn't really be used */
IOMobileFramebufferReturn
IOMobileFramebufferGetLayerDefaultSurface(IOMobileFramebufferRef connection, int surface, IOSurfaceRef *ptr);

/* Starts the swap operation. Second parameter is the swap counter */
IOMobileFramebufferReturn
IOMobileFramebufferSwapBegin(IOMobileFramebufferRef connection,int *token);

/* Commits the swap */
IOMobileFramebufferReturn
IOMobileFramebufferSwapEnd(IOMobileFramebufferRef connection);

/* Swaps the layers */
IOMobileFramebufferReturn
IOMobileFramebufferSwapSetLayer(IOMobileFramebufferRef fb,
								int layer,
								IOSurfaceRef buffer,
								CGRect bounds,
								CGRect frame,
								int flags);

/* Sets the background color during a swap */
IOMobileFramebufferReturn
IOMobileFramebufferSwapSetBackgroundColor(IOMobileFramebufferRef connection, int r, int g, int b);

/**/
IOMobileFramebufferReturn
IOMobileFramebufferSwapWait(IOMobileFramebufferRef connection);

/* Also known as the inverse mode */
IOMobileFramebufferReturn
IOMobileFramebufferSetWhiteOnBlackMode(IOMobileFramebufferRef connection, int enabled);

/* Gets the source for the vsync update notifications */
CFRunLoopSourceRef
IOMobileFramebufferGetVSyncRunLoopSource(IOMobileFramebufferRef connection);

/* Enables vsync notifications */
IOMobileFramebufferReturn
IOMobileFramebufferEnableVSyncNotifications(IOMobileFramebufferRef connection, void* callback, void* refcon);
					

#ifdef __cplusplus
}
#endif

















