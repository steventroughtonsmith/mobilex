/* MXFont: Impl */

#import "MXFont.h"
#import "CGPrivateMethods.h"

static NSDictionary* _fontCache = NULL;

@implementation MXFont

@synthesize cgFont=_cgFont;
@synthesize size=_size;

/* Loads all available fonts */
+ (void) _initFontCache
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	NSString* scanPath = @"/System/Library/Fonts/Cache/";
	NSArray* fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:scanPath
																			error:nil];
	NSMutableDictionary* cache = [NSMutableDictionary new];

	for (NSString* file in fileList)
	{
		if ([file hasSuffix:@".ttc"] ||
			[file hasSuffix:@".ttf"])
		{
			NSString* fullPath = [scanPath stringByAppendingPathComponent:file];
			CFArrayRef fonts = CGFontCreateFontsWithPath((CFStringRef)fullPath);
			
			/* A lot of font files contain multiple fonts */
			for (int i = 0; i < CFArrayGetCount(fonts); i++) {
				CGFontRef font = (CGFontRef)CFArrayGetValueAtIndex(fonts, i);
				
				NSString* family = (NSString*)CGFontCopyName(font,kCGFontNameKeyFontFamily);
				NSString* subFamily = (NSString*)CGFontCopyName(font,kCGFontNameKeyFontSubfamily);
				
				if ([cache objectForKey:family] == nil)
				{
					[cache setObject:[NSMutableDictionary dictionaryWithObject:(id)font
																		forKey:subFamily]
							  forKey:family];
				}
				else 
				{
					[[cache objectForKey:family] setObject:(id)font forKey:subFamily];
				}
			}

		}
	}
	
	_fontCache = [NSDictionary dictionaryWithDictionary:cache];
	printf("FontCache: Loaded %d font families.\n",[cache count]);
	[_fontCache retain];
	
	[pool release];
}

+ (MXFont*) boldFontWithFamily:(NSString*)family
							 size:(int)size
{
	MXFont* f = [[MXFont alloc] initWithFamilyName:family
										 subFamily:@"Bold"];
	[f setSize:size];
	return f;
}

+ (MXFont*) regularFontWithFamily:(NSString*)family
							 size:(int)size
{
	MXFont* f = [[MXFont alloc] initWithFamilyName:family
										 subFamily:@"Regular"];
	[f setSize:size];
	return f;
}

- (id) initWithCGFont:(CGFontRef)font
{
	[super init];
	
	if (font == nil) { 
		NSLog(@" *** Can't create font (CGFont == nil)");
		return nil;
	}
	
	_cgFont = font;
	
	return self;
}

- (id) initWithFamilyName:(NSString*)familyName
				  subFamily:(NSString*)subFamily
{
	NSDictionary* fontsForFamily = [_fontCache objectForKey:familyName];
	
	if (fontsForFamily != nil && [fontsForFamily count] != 0)
	{
		CGFontRef fontForSubFamily = (CGFontRef)[fontsForFamily objectForKey:subFamily];
		if (fontForSubFamily == nil) {
			NSString* firstFound = [[fontsForFamily allKeys] objectAtIndex:0];
			NSLog(@" *** SubFamily '%@' not found, defaulting to '%@'",subFamily,firstFound);
			fontForSubFamily = (CGFontRef)[fontsForFamily objectForKey:firstFound];
		}
		
		return [self initWithCGFont:fontForSubFamily];
	}
	else 
	{
		NSLog(@" *** Font '%@' doesn't exist in cache!",familyName);
		return nil;
	}

	
	return self;
}

- (NSString*) fontFamily
{
	return (NSString*)CGFontCopyName(_cgFont,kCGFontNameKeyFontFamily);	
}

@end
