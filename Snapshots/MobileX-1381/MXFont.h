/* MXFont: Header */

#import <Foundation/Foundation.h>


@interface MXFont : NSObject {
	CGFontRef _cgFont;
	int _size;
}

+ (void) _initFontCache;

+ (MXFont*) regularFontWithFamily:(NSString*)family
							 size:(int)size;
+ (MXFont*) boldFontWithFamily:(NSString*)family
						  size:(int)size;

@property int size;
@property (readonly) CGFontRef cgFont;
@property (readonly) NSString* fontFamily;

- (id) initWithCGFont:(CGFontRef)font;
- (id) initWithFamilyName:(NSString*)familyName
				subFamily:(NSString*)subFamily;

@end
