//
//  MXIconImage.m
//  MobileX
//
//  Created by Nick on 25/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXIconImage.h"
#import "MXUIDrawing.h"

@implementation MXIconImage

- (void) drawInContext:(CGContextRef)ctx
{
	CGRect iRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
	CGRect glossRect = CGRectMake(iRect.origin.x - 30, iRect.origin.y-35, iRect.size.width + 30*2, iRect.size.height);
	
	CGContextAddRoundedRect(ctx, iRect, 15);
	CGContextSetFillColorWithColor(ctx, WHT(0.4));
	CGContextClip(ctx);
	
	CGContextSaveGState(ctx);
	if (self.image.cgImage == NULL)
	{
		CGContextAddRect(ctx, iRect);
		CGContextFillPath(ctx);
	}
	else {
		[super drawInContext:ctx];
	}
	CGContextRestoreGState(ctx);
	
	if (_prerendered || self.image.cgImage == NULL)
	{
		CGContextSaveGState(ctx);
		
		CGContextSetFillColorWithColor(ctx, WHTA(1,0.2));
		CGContextAddEllipseInRect(ctx, glossRect);
		CGContextClip(ctx);
		
		[MXUIDrawing drawLinearGradientInContext:ctx
										  inRect:glossRect
										  color1:WHTA(1,0.6)
										  color2:WHTA(1,0.07)];
		CGContextRestoreGState(ctx);
		
		[MXUIDrawing drawLinearGradientInContext:ctx
										  inRect:CGRectMake(0,
															iRect.origin.y+(iRect.size.height-(iRect.size.height/2)),
															iRect.size.width,
															iRect.size.height/2)
										  color1:WHTA(1,0)
										  color2:WHTA(1,0.12)];
	}
	
	
}

- (void) setShouldAddGlossAndClipping:(BOOL)pr
{
	_prerendered = pr;
	[self setNeedsDisplay];
}

@end
