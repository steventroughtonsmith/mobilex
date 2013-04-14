//
//  MXMainLayer.m
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXMainLayer.h"
#import <QuartzCore/CAWindowServer.h>
#import <QuartzCore/CAWindowServerDisplay.h> 
#import <QuartzCore/CAContext.h>
#import "MXCG.h"
#import "MXFont.h"
#import "MXScreenCapture.h"

static MXMainLayer* _shinst = NULL;

CGImageRef CreateImageFromPNGResource(CFStringRef resourceFileName) {
	CGImageRef retVal = NULL;  // Try to get a URL to appropriate URL in our resources
	CFURLRef resourceURL = CFBundleCopyResourceURL( CFBundleGetMainBundle(), resourceFileName, CFSTR("png"), NULL);  // if we succesfully obtained the URL, create an image from it.
	if(NULL != resourceURL) {
		CGDataProviderRef dataProvider = CGDataProviderCreateWithURL(resourceURL);  
		retVal = CGImageCreateWithPNGDataProvider( dataProvider, NULL, true, kCGRenderingIntentDefault); 
		CGDataProviderRelease(dataProvider); CFRelease(resourceURL); 
	}  return retVal; 
}

@implementation MXMainLayer

+ (id) mainLayer
{
	return _shinst;
}

- (void) setError:(NSString*)error {
	_hasError = TRUE;
	_errorMessage = error;
	
	[self setMasksToBounds:TRUE];
	[self setNeedsDisplay];
}

- (void) drawInContext:(CGContextRef)ctx
{
	if (_hasError && _errorMessage) {
		
		CGRect drawRect = CGRectInset(self.bounds, 50, 50);
		
		CGContextAddRect(ctx, drawRect);
		CGContextSetFillColorWithColor(ctx, RGB(0.05,0.05,0.05));
		CGContextFillPath(ctx);
		
		
		CGImageRef myDrawnImage = CreateImageFromPNGResource(CFSTR("MXLogo"));
		
		CGContextSaveGState(ctx);
		CGContextScaleCTM(ctx, 1.0, -1.0);
		
		CGContextTranslateCTM(ctx, drawRect.origin.x+(floor((drawRect.size.width-561.)/2)), -(floor((drawRect.size.height+191.)/2)));
		
		CGContextDrawImage(ctx, CGRectMake(0, 0, 561., 191.), myDrawnImage);
		CGContextRestoreGState(ctx);
		
		
		CGDrawText(ctx,
				   @"Error",
				   [MXFont boldFontWithFamily:@"Helvetica" size:25],
				   RGB(1,1,1),
				   CGRectMake(drawRect.origin.x+10, drawRect.origin.y+0, 100, 100));
		
		CGDrawText(ctx,
				   _errorMessage,
				   [MXFont regularFontWithFamily:@"Helvetica" size:14],
				   RGB(0.5,0.5,0.5),
				   CGRectMake(drawRect.origin.x+10, drawRect.origin.y+50, 100, 100));
	}
}

- (void) takeScreenshot
{
	MXImage* screenImage = MXGetScreenImage();
	[screenImage writeToFile:@"/var/root/screenshot.png" atomically:TRUE];
}

- (id) init
{
	[super init];
	_shinst = self;
	
	[self setMasksToBounds:TRUE];
	
	return self;
}

@end
