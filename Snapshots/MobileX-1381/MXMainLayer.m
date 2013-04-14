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



@implementation MXMainLayer

+ (id) mainLayer
{
	return _shinst;
}

- (void) setError:(NSString*)error {
	_hasError = TRUE;
	_errorMessage = error;
	
	[self setNeedsDisplay];
}

- (void) drawInContext:(CGContextRef)ctx
{
	if (_hasError && _errorMessage) {
		CGContextAddRect(ctx, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
		CGContextSetFillColorWithColor(ctx, RGB(0.05,0.05,0.05));
		CGContextFillPath(ctx);
		
		CGDrawText(ctx,
				   @"Error",
				   [MXFont regularFontWithFamily:@"Helvetica" size:25],
				   RGB(1,1,1),
				   CGRectMake(10, 0, 100, 100));
		
		CGDrawText(ctx,
				   _errorMessage,
				   [MXFont regularFontWithFamily:@"Helvetica" size:14],
				   RGB(0.5,0.5,0.5),
				   CGRectMake(10, 50, 100, 100));
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
	
	return self;
}

@end
