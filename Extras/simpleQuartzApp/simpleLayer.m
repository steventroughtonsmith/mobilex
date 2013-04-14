/* simpleLayer */

#import "simpleLayer.h"

@implementation simpleLayer

- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}


- (void) drawInContext:(CGContextRef)ctx {
	if (_style == 0) {
		CGContextSetFillColorWithColor(ctx, _color);
		CGContextFillRect(ctx, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
	}
	else if (_style == 1) {
		
	}
	else {
		CGContextSetFillColorWithColor(ctx, _color);
		CGContextFillRect(ctx, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
		
		CGContextSetLineWidth(ctx, 2.0);
		CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1.0);
		
		CGContextMoveToPoint(ctx, 1, 1);
		CGContextAddLineToPoint(ctx, self.frame.size.width-1, 1);
		CGContextAddLineToPoint(ctx, self.frame.size.width-1, self.frame.size.height-1);
		CGContextAddLineToPoint(ctx, 1, 1);
		CGContextAddLineToPoint(ctx, 1, self.frame.size.height-1);
		CGContextAddLineToPoint(ctx, self.frame.size.width-1, self.frame.size.height-1);
		
		CGContextAddLineToPoint(ctx, 1, self.frame.size.height-1);
		CGContextAddLineToPoint(ctx, self.frame.size.width-1, 1);
		
		CGContextStrokePath(ctx);
	}
}

- (id) initWithBoundsAndStyle:(CGRect)bounds
						style:(int)style
						  red:(float)red
						green:(float)green
						 blue:(float)blue
						alpha:(float)alpha
{
	self = [super init];
    if (self) {
        [self setFrame:bounds];
		
		_style = style;
		
		[self setRed:red
			   green:green
				blue:blue
			   alpha:alpha];
    }
    
    return self;
}

- (void) setRed:(float)red
		  green:(float)green
		   blue:(float)blue
		  alpha:(float)alpha
{
	CGColorSpaceRef cs = 
	CGColorSpaceCreateDeviceRGB();
	
	CGFloat components[4] = {red, green, blue, alpha};
	CGColorRef color = CGColorCreate(cs, components);
	
	if (_color != NULL) {
		CGColorRelease(_color);
	}
	
	if (components[3] == 1.0) {
		[self setOpaque:TRUE];
	}
	
	CGColorSpaceRelease(cs);
	_color = color;
	
	[self display];
}

@end
