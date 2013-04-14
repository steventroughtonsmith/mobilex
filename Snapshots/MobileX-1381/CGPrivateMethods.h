/* CoreGraphics - CGPrivateMethods.h 
 CoreGraphics private methods.
 */


/* CGBitmap */
int CGBitmapGetAlignedBytesPerRow(int bpr);


/* CGFont */

/* Font dictionary entries */
extern CFStringRef kCGFontNameKeyPostScriptName;
extern CFStringRef kCGFontNameKeyPreferredSubfamily;
extern CFStringRef kCGFontNameKeyFontSubfamily;
extern CFStringRef kCGFontNameKeyFullName;
extern CFStringRef kCGFontNameKeyPreferredFamily;
extern CFStringRef kCGFontNameKeyFontFamily;

/* Copies a string value from the font information dictionary */
CFStringRef CGFontCopyName(CGFontRef font,
						   CFStringRef key);