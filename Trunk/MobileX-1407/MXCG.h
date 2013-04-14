/*
 These are the CG routines used by MXKit.
 These methods are very common routines.
 */

#import <Foundation/Foundation.h>
#import "MXFont.h"

/* text tools */
void CGPrepareForText(CGContextRef c,CGFloat h);
CGGlyph* CGGlyphsForString(CGFontRef fpnt,NSString* str);

/* rendering tools */
void MXCGDrawShadow(CGContextRef context);
void CGDrawText(CGContextRef context,
				NSString* text,
				MXFont* fnt,
				CGColorRef color,
				CGRect frame);

/* path tools */
void CGContextAddRoundedRect(CGContextRef context, CGRect rrect,float cornerRadius);

/* rect tools */
CGRect CGInsetRect(CGRect rect,float inset);
CGRect CGRectBaseOrigin(CGRect rect);
CGRect CGRectShrinkToBorder(CGRect rect);
CGRect CGRectLroundf(CGRect rect);

CGRect CGCtxRectOutset(CGContextRef ctx,CGRect rect, float outset);

/* NSString->X */
NSString* NSStringFromCGRect(CGRect rect);
NSString* NSStringFromCGSize(CGSize size);
NSString* NSStringFromCGPoint(CGPoint point);