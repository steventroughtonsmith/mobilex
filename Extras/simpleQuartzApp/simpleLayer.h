/* simpleLayer */


#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface simpleLayer : CALayer {
	CGColorRef _color;
	int _style;
}

- (id) initWithBoundsAndStyle:(CGRect)bounds
						style:(int)style
						  red:(float)red
						green:(float)green
						 blue:(float)blue
						alpha:(float)alpha;

- (void) setRed:(float)red
		  green:(float)green
		   blue:(float)blue
		  alpha:(float)alpha;

@end
