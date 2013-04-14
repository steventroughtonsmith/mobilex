//
//  MXImage.m
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXImage.h"
#import <ImageIO/ImageIO.h>

@implementation MXImage

@synthesize cgImage=_cgImage;

+ (id) imageNamed:(NSString*)name
{
	MXImage* img = [[MXImage alloc] init];
	[img loadImageWithName:name];
	
	return img;
}

- (void) loadImageAtPath:(NSString *)path
{
	if (![path hasSuffix:@".png"])
		path = [path stringByAppendingString:@".png"];
	
	[self loadImageAtAbsoulutePath:path];
}

- (id) initWithCGImage:(CGImageRef)image
{
	[super init];
	
	_cgImage = image;
	
	return self;
}

- (void) loadImageWithName:(NSString*)name
{
	if ([name hasPrefix:@"/"])
	{
		[self loadImageAtPath:name];
	}
	else 
	{
		NSString* path = nil;
		
		path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:name];
		
		if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
			path = [[[[NSBundle mainBundle] bundlePath]
					 stringByAppendingPathComponent:@"MobileXSupport.bundle"]
						stringByAppendingPathComponent:name];
		}
		
		[self loadImageAtPath:path];
	}
	
}

- (void) writeToFile:(NSString*)file
		  atomically:(BOOL)atomically
{
	if (_cgImage != NULL) {
		CFStringRef type = CFSTR("public.png");  //public.png
		size_t count = 1; 
		NSMutableData* d = [NSMutableData new];
		CGImageDestinationRef dest = CGImageDestinationCreateWithData((CFMutableDataRef)d, type, count, NULL);
		
		CGImageDestinationAddImage(dest, _cgImage, NULL);
		CGImageDestinationFinalize(dest);
		CFRelease(dest);
		
		[d writeToFile:file atomically:atomically];
		MXSLog(@"Wrote %d bytes to %@.",[d length],file);
	}
}

- (void) loadImageAtAbsoulutePath:(NSString *)path
{
	if (path == NULL)
		return;
	
	CGDataProviderRef provider = CGDataProviderCreateWithFilename([path UTF8String]);
	
	if (provider != nil)
	{
		CGImageRef img = CGImageCreateWithPNGDataProvider(provider, NULL, TRUE, kCGRenderingIntentPerceptual);
		_cgImage = img;
		
		CGDataProviderRelease(provider);
	}
	else {
		MXSLog(@" *** Unable to create a provider for path '%@'",path);
	}
}

@end
