//
//  MXImage.m
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXImageLayer.h"
#import "MXCG.h"
#import "MXColors.h"

@implementation MXImageLayer

- (MXImage*) image
{
	return _image;
}

- (BOOL) centered
{
	return _tiled;
}

+ (id) imageLayerWithImage:(MXImage*)im
{
	MXImageLayer* i = [[MXImageLayer layer] init];
	[i setImage:im];
	[i retain];
	return i;
}

- (BOOL) zeroPoint
{
	return _zeroPoint;
}

- (void) setZeroPoint:(BOOL)t
{
	_zeroPoint = t;
	[self setNeedsDisplay];
}

- (void) setCentered:(BOOL)t
{
	_centered = t;
	[self setNeedsDisplay];
}

- (BOOL) tiled
{
	return _tiled;
}

- (void) setTiled:(BOOL)t
{
	_tiled = t;
	[self setNeedsDisplay];
}

- (void) setImage:(MXImage*)im
{
	_image = im;
	[_image retain];
	[self setNeedsDisplay];
}	

- (void) drawInContext:(CGContextRef)ctx
{
	if (_image == nil)
		return;
	
	CGImageRef cgImage = [_image cgImage];
	
	CGContextSaveGState(ctx);
	CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
	CGContextScaleCTM(ctx, 1, -1);
	
	if (_centered)
	{
		float w = CGImageGetWidth(cgImage);
		float h = CGImageGetHeight(cgImage);
		
		CGContextDrawImage(ctx,
						   CGRectMake(
									  lroundf(self.frame.size.width/2.0f - w/2.0f),
									  lroundf(self.frame.size.height/2.0f - h/2.0f),
									  w,
									  h),
						   cgImage);
	}
	else if (_zeroPoint)
	{
		float w = CGImageGetWidth(cgImage);
		float h = CGImageGetHeight(cgImage);
		
		CGContextDrawImage(ctx,
						   CGRectMake(
									  0,
									  0,
									  w,
									  h),
						   cgImage);
		
	}
	else
	{
		if (_tiled)
			CGContextDrawTiledImage(ctx,CGRectMake(0, 0, CGImageGetWidth(cgImage), CGImageGetHeight(cgImage)),cgImage);
		else
			CGContextDrawImage(ctx, CGRectBaseOrigin(self.frame), cgImage);
	}
	
	CGContextRestoreGState(ctx);
}

@end
