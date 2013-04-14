/*
 These are the CG routines used by MXKit.
 These methods are very common routines.
 */

#import "MXCG.h"
#import "MXColors.h"

/*
 * A quick routine to draw text without making unnecessary layers
 */
void CGDrawText(CGContextRef context,
				NSString* text,
				MXFont* fnt,
				CGColorRef color,
				CGRect frame)
{
	CGPrepareForText(context, frame.size.height);
	
	CGFontRef font = fnt.cgFont;
	int units = CGFontGetUnitsPerEm(font);
	CGRect bbox = CGFontGetFontBBox(font);
	
	float height = (((float) bbox.size.height + 1500) / ((float) units)) * SC(fnt.size);
	float hhh = frame.size.height - height;
	CGContextSetFillColorWithColor(context, color);
	CGContextSetFont(context, font);
	CGContextSetFontSize(context, SC(fnt.size));
	CGContextMoveToPoint(context, 10, 10);
	CGContextShowGlyphsAtPoint(context, frame.origin.x+ SC(0.0f), (SC(16.0f) + hhh)-frame.origin.y, CGGlyphsForString(font, text), [text length]);
	
	CGContextRestoreGState(context);
}

NSString* NSStringFromCGPoint(CGPoint point)
{
	return [NSString stringWithFormat:@"{%g, %g}",point.x,point.y];
}

NSString* NSStringFromCGRect(CGRect rect)
{
	return [NSString stringWithFormat:@"{{%g, %g}, {%g, %g}}",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height];
}

NSString* NSStringFromCGSize(CGSize size)
{
	return [NSString stringWithFormat:@"{%g, %g}",size.width,size.height];
}

void MXCGDrawShadow(CGContextRef context)
{
	CGContextSaveGState(context);
	
	CGContextSetFillColorWithColor(context, RGB(1,0,0));
	CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 5, WHT(0));
	CGContextStrokePath(context);
	
	CGContextRestoreGState(context);
}

void CGContextAddRoundedRect(CGContextRef context, CGRect rrect,float cornerRadius)
{
	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect); 
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect); 
	
	CGContextMoveToPoint(context, minx, midy); 
	CGContextAddArcToPoint(context, minx, miny, midx, miny, cornerRadius); 
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, cornerRadius); 
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, cornerRadius); 
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, cornerRadius); 
	CGContextClosePath(context);;
}

CGRect CGRectLroundf(CGRect rect)
{
	return CGRectMake(lroundf(rect.origin.x), lroundf(rect.origin.y), lroundf(rect.size.width), lroundf(rect.size.height));
}

CGRect CGRectShrinkToBorder(CGRect rect)
{
	return CGRectMake(rect.origin.x, rect.origin.y + 1, rect.size.width - 1, rect.size.height - 1);
}

CGRect CGRectBaseOrigin(CGRect rect)
{
	return CGRectMake(0, 0, rect.size.width, rect.size.height);
}

CGRect CGCtxRectOutset(CGContextRef ctx,CGRect rect, float outset)
{
	CGContextSetLineWidth(ctx,outset);
	return CGRectMake(rect.origin.x-outset/2, rect.origin.y-outset/2, rect.size.width +outset*2, rect.size.height +outset*2);
}

CGRect CGInsetRect(CGRect rect,float inset)
{
	return CGRectMake(rect.origin.x+inset, rect.origin.y+inset, rect.size.width -inset*2, rect.size.height -inset*2);
}

void CGPrepareForText(CGContextRef c,CGFloat h)
{
	CGContextSaveGState(c);
	CGContextTranslateCTM(c, 0, h);
	CGContextScaleCTM(c, 1, -1);
}

CGGlyph* CGGlyphsForString(CGFontRef font,NSString* str)
{
	static unichar chars[200] = {0};
    static CGGlyph glyphs[200] = {0};
	
	[str getCharacters:chars];
	
	CGFontGetGlyphsForUnichars(font, chars, glyphs, [str length]);
	
	return glyphs;
}