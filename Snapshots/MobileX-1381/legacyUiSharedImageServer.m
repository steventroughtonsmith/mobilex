/* uikit is ghey */

#import "legacyUiSharedImageServer.h"

static CGImageRef _imageCache = NULL;

CGImageRef createSingleImage()
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	NSString* path = [[[[NSBundle mainBundle] bundlePath]
					   stringByAppendingPathComponent:@"MobileXSupport.bundle"]
					  stringByAppendingPathComponent:@"sample.png"];
	
	CGDataProviderRef provider = CGDataProviderCreateWithFilename([path UTF8String]);
	CGImageRef img;
	
	if (provider != nil) {
		img = CGImageCreateWithPNGDataProvider(provider, NULL, TRUE, kCGRenderingIntentPerceptual);
		
		CGDataProviderRelease(provider);
		CFRetain(img);
	}
	else {
		MSLog(@" *** Failed to load shared image stub 'sample.png'. Expect \"undefined behaviour\".");
	}
	
	[pool release];
	
	return img;
}

CGImageRef sharedImageCallback(int sub,int imageId)
{
	if (_imageCache == NULL)
	{
		_imageCache = createSingleImage();
	}
	
	CFRetain(_imageCache);
	
	return _imageCache;
}

void legacyUiSharedImageServerStart(void) {

	/* add UIKit shared images */
	CARenderAddSharedImageRange(0, 0, 2147485516, 0,sharedImageCallback);
	
	MXLog(@"UIKit image cache initialized.");
}