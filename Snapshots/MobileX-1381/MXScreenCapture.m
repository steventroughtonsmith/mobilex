//
//  MXScreenCapture.m
//  MobileX
//
//  Created by Nick on 14/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXScreenCapture.h"
#import "MXDevice.h"
#import "CARenderServer.h"
#import "CGPrivateMethods.h"
#import <IOSurface/IOSurfaceAPI.h>

void MXDSetInt(int val,CFStringRef key,CFMutableDictionaryRef dict)
{
	CFDictionarySetValue(dict,key, CFNumberCreate(NULL, kCFNumberSInt32Type, &val));
}

CFDictionaryRef MXSurfaceDictionaryForRect(CGRect frame)
{
	CFMutableDictionaryRef dict = CFDictionaryCreateMutable(NULL, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
	CFDictionarySetValue(dict, CFSTR("IOSurfaceIsGlobal"), kCFBooleanFalse);
	
	int bpr = CGBitmapGetAlignedBytesPerRow(lroundf(frame.size.width)*4);
	
	MXDSetInt(frame.size.width, kIOSurfaceWidth, dict);
	MXDSetInt(frame.size.height, kIOSurfaceHeight, dict);
	MXDSetInt(frame.size.height*bpr, kIOSurfaceAllocSize, dict);
	MXDSetInt(1111970369, kIOSurfacePixelFormat, dict);
	MXDSetInt(4, kIOSurfaceBytesPerElement, dict);
	MXDSetInt(bpr, kIOSurfaceBytesPerRow, dict);
	
	return (CFDictionaryRef)dict;
}

CGImageRef MXCGImageFromIOSurface(IOSurfaceRef renderSurface)
{
	CGDataProviderRef pr = CGDataProviderCreateWithData(NULL, IOSurfaceGetBaseAddress(renderSurface), IOSurfaceGetAllocSize(renderSurface), NULL);
	CFRetain(pr);
	
	CGImageRef image =
	CGImageCreate(IOSurfaceGetWidth(renderSurface),
				  IOSurfaceGetHeight(renderSurface),
				  8,
				  32,
				  IOSurfaceGetBytesPerRow(renderSurface),
				  CGColorSpaceCreateDeviceRGB(),
				  kCGImageAlphaFirst | kCGBitmapByteOrder32Little,
				  pr,
				  NULL,
				  FALSE,
				  kCGRenderingIntentDefault);
	
	return image;
}

MXImage* MXImageForContextList(unsigned* contexts, int count,CGRect frame)
{
	IOSurfaceRef renderSurface = IOSurfaceCreate(MXSurfaceDictionaryForRect(frame));
	
	if (renderSurface == NULL)
	{
		MXLog(@"MTScreenshot: Failed to create surface!");
		return NULL;
	}
	
	IOSurfaceLock(renderSurface, 0, NULL);
	CARenderServerRenderClientList(NULL, count, contexts, renderSurface, NULL, NULL); /* XXX: CGSize */
	IOSurfaceUnlock(renderSurface, 0, NULL);
	
	CGImageRef image = MXCGImageFromIOSurface(renderSurface);
	
	return [[MXImage alloc] initWithCGImage:image];
}

MXImage* MXImageForContext(unsigned context, CGRect frame)
{
	IOSurfaceRef renderSurface = IOSurfaceCreate(MXSurfaceDictionaryForRect(frame));
	
	if (renderSurface == NULL)
	{
		MXLog(@"MTScreenshot: Failed to create surface!");
		return NULL;
	}
	
	IOSurfaceLock(renderSurface, 0, NULL);
	CARenderServerRenderClient(NULL, context, renderSurface, NULL, NULL);
	IOSurfaceUnlock(renderSurface, 0, NULL);
	
	CGImageRef image = MXCGImageFromIOSurface(renderSurface);
	
	return [[MXImage alloc] initWithCGImage:image];
}


MXImage* MXGetImageForLayer(CALayer* layer,unsigned ctx)
{
	IOSurfaceRef renderSurface = IOSurfaceCreate(MXSurfaceDictionaryForRect(layer.frame));
	
	if (renderSurface == NULL)
	{
		MXLog(@"MTScreenshot: Failed to create surface!");
		return NULL;
	}
	
	IOSurfaceLock(renderSurface, 0, NULL);
	CARenderServerRenderLayer(0, ctx,layer,0,renderSurface,layer,layer);
	IOSurfaceUnlock(renderSurface, 0, NULL);
	
	CGImageRef image = MXCGImageFromIOSurface(renderSurface);
	
	return [[MXImage alloc] initWithCGImage:image];
}

MXImage* MXGetScreenImage()
{
	IOSurfaceRef renderSurface = IOSurfaceCreate(MXSurfaceDictionaryForRect([[MXDevice currentDevice] screenSizeAsRect]));
	
	if (renderSurface == NULL)
	{
		MXLog(@"MTScreenshot: Failed to create surface!");
		return NULL;
	}
	
	IOSurfaceLock(renderSurface, 0, NULL);
	CARenderServerRenderDisplay(0,CFSTR("LCD"),renderSurface,NULL,NULL);
	IOSurfaceUnlock(renderSurface, 0, NULL);
	
	CGImageRef image = MXCGImageFromIOSurface(renderSurface);
	
	return [[MXImage alloc] initWithCGImage:image];
}

