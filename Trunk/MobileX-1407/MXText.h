//
//  MXText.h
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXFont.h"
#import "MXLayer.h"

typedef enum {
	kMXTextVerticalAlignTop,
	kMXTextVerticalAlignCenter
} MXTextVerticalAlign;

typedef enum {
	kMXTextHorizontalAlignCenter,
	kMXTextHorizontalAlignLeft
} MXTextHorizontalAlign;

@interface MXText : MXLayer {
	NSString* _text;
	CGColorRef _color;
	MXFont* _font;
	
	MXTextVerticalAlign _valign;
	MXTextHorizontalAlign _halign;
	
	BOOL _drawBoundingBox;
	
	CGColorRef _shadowColor;
	CGSize _shadowOffset;
}

@property CGColorRef shadowColor;
@property CGSize shadowOffset;

@property (retain) MXFont* font;
@property (retain) NSString* text;
@property int size;
@property CGColorRef color;

@property MXTextVerticalAlign verticalAlign;
@property MXTextHorizontalAlign horizontalAlign;

+ (id) text:(NSString*)t inRect:(CGRect)rect;

@end

