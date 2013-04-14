/* text layer */

#import "MXText.h"
#import "MXColors.h"
#import "MXCG.h"

//#import <CoreGraphics/CoreGraphicsPriv.h>

@implementation MXText

@synthesize text=_text;
@synthesize horizontalAlign=_halign;
@synthesize verticalAlign=_valign;
@synthesize font=_font;
@synthesize shadowOffset=_shadowOffset;
@synthesize shadowColor=_shadowColor;

- (void) setVerticalAlign:(MXTextVerticalAlign)a
{
	_valign = a;
	[self setNeedsDisplay];
}

- (void) setHorizontalAlign:(MXTextHorizontalAlign)a
{
	_halign = a;
	[self setNeedsDisplay];
}

+ (id) text:(NSString*)t inRect:(CGRect)rect
{
	MXText* tt = [[MXText alloc] init];
	[tt setFrame:rect];
	[tt setText:t];
	return tt;
}

- (id) init
{
	[super init];
	_text = @"";
	_color = RGB(0,0,0);
	
	_valign = kMXTextVerticalAlignCenter;
	_halign = kMXTextHorizontalAlignCenter;
	
	_font = [MXFont regularFontWithFamily:@"Helvetica" size:12];

	return self;
}

- (int) size
{
	return _font.size;
}

- (void) setSize:(int)size
{
	_font.size = size;
	[self setNeedsDisplay];
}

- (void)setFont:(MXFont *)fn
{
	_font = fn;
	[self setNeedsDisplay];
}

- (void) setText:(NSString *)t
{
	_text = t;
	[t retain];
	[self setNeedsDisplay];
}

- (CGColorRef) color
{
	return _color;
}

- (void) setColor:(CGColorRef)c
{
	_color = c;
	[self setNeedsDisplay];
}

- (void) setShadowOffset:(CGSize)offset
{
	_shadowOffset = offset;
	[self setNeedsDisplay];
}

- (void) setShadowColor:(CGColorRef)c
{
	_shadowColor = c;
	[self setNeedsDisplay];
}

- (void) drawInContext:(CGContextRef)context
{
	CGPrepareForText(context, self.frame.size.height);
	CGContextSetFillColorWithColor(context, _color);
	CGContextSetFont(context, _font.cgFont);
	CGContextSetFontSize(context, SC(_font.size));
	
	CGContextSetShadowWithColor(context,
								_shadowOffset,
								0,
								_shadowColor);
	
	/* Figure out the height */
	int units = CGFontGetUnitsPerEm(_font.cgFont);
	CGRect bbox = CGFontGetFontBBox(_font.cgFont);
	
	/*
	 XXX
	 This is not done properly. This only does it using the union of ALL glyphs.
	 For proper height determination we need to only do the union of available glyphs.
	 Or the union of common glyphs. (Some glyphs are massive so they fuck things up)
	 
	 The value of 1500 is subtracted from the height so centering works for Helvetica.
	 (Helvetica's biggest glyphs make the bounding box massive)
	 */
	float height = (((float) bbox.size.height-1500) / ((float) units)) * SC(_font.size);
	
	/* Do the magic */
	NSArray* strings = [_text componentsSeparatedByString:@"\n"];
	
	/* Reverse the Y coordinate so we can do it right */
	float yTextOffset = 0;
	float totalHeight = (height*(float)[strings count]);
	if (_valign == kMXTextVerticalAlignTop)
	{
		yTextOffset = self.frame.size.height  - (height*[strings count] - SC(0));
	}
	else if (_valign == kMXTextVerticalAlignCenter)
	{
		yTextOffset = self.frame.size.height / 2 - totalHeight / 2.0f;
	}

	
	/* postscript likes cock */
	/* because of that we need to reverse the enumerator */
	int i = [strings count]-1;
	
	while (i != -1)
	{
		NSString* str = [[strings objectAtIndex:i] stringByReplacingOccurrencesOfString:@"\r" withString:@""];
		CGGlyph* glyphs = CGGlyphsForString(_font.cgFont, str);
		CGRect boxes[200];
		
		/* get the width */
		float wCount = 0;
		if (CGFontGetGlyphBBoxes(_font.cgFont, glyphs, [str length], boxes))
		{
			for (int bb = 0; bb < [str length]; bb++) 
			{
				wCount += boxes[bb].size.width + 200;
			}
		}
		float width = (((float) wCount) / ((float) units)) * SC(_font.size);
		
		float x;
		float y;
		
		if (_halign == kMXTextHorizontalAlignCenter)
		{
			x = self.frame.size.width/2 - width/2;
		}
		else 
		{
			x = 0;
		}
		
		y = yTextOffset;

		if (_drawBoundingBox)
		{
			CGContextAddRect(context, CGRectMake(x, y, width, height));
			CGContextSetStrokeColorWithColor(context, RGB(1,0,0));
			CGContextStrokePath(context);
		}
		
		CGContextShowGlyphsAtPoint(context, lroundf(x), lroundf(y), glyphs, [str length]);
		
		/* render the glyphs */
		yTextOffset += height;
		i--;
	}
	
	CGContextRestoreGState(context);
}

@end
