//
//  MXIcon.m
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXIcon.h"

static MXFont* _iconFont = NULL;

@implementation MXIcon

+ (CGSize)defaultIconSize {
    return CGSizeMake(130, 150);
}

- (void) onControlTouchBeginAt:(CGPoint)point
{
	[CATransaction begin];
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
	[self setFilters:[NSArray arrayWithObject:_darkFilter]];
	[CATransaction commit];
}

- (void) onControlTouchEndAt:(CGPoint)point
{
	[CATransaction begin];
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
	[self setFilters:nil];
	[CATransaction commit];
}

- (id)init {
	if ((self = [super init])) {
		
		if (_iconFont == NULL) {
			/* Cache the icon font */
			_iconFont = [MXFont boldFontWithFamily:@"Arial" size:12];
			[_iconFont retain];
		}
		
        CGRect frame;
        frame.size = [[self class] defaultIconSize];
        frame.origin = CGPointZero;
        [self setFrame:frame];

        float captionHeight = 20;
        float szH = 74;
		float szW = 76;

        _iconImage = [[MXIconImage alloc] init];
	    [_iconImage setFrame:CGRectMake(lroundf(self.frame.size.width / 2 - szW / 2),
										lroundf((self.frame.size.height / 2 - szH / 2)),
										szW,
										szH)];
        
	    [self addSublayer:_iconImage];
		
        _nameText = [MXText text:@"Name" inRect:CGRectMake(0, self.frame.size.height - captionHeight, self.frame.size.width, 10)];
		[_nameText setFont:_iconFont];
	    [self addSublayer:_nameText];
		[_nameText retain];
		
		_darkFilter = [[CAFilter alloc] initWithName:kCAFilterMultiplyColor];
		[_darkFilter setValue:(id)WHT(0.5) forKey:@"inputColor"];
		
	    [self setNeedsDisplay];
    }

	return self;
}

- (void) drawInContext:(CGContextRef)context
{
	/*
	 Grrr, I hate CG's shadow drawing routines.
	 Have to find hacky ways to draw them.
	 At least it isn't CA which is glitchy as fuck.
	 */
	
	CGRect iRect = CGRectMake(_iconImage.frame.origin.x,
							  _iconImage.frame.origin.y,
							  _iconImage.frame.size.width,
							  _iconImage.frame.size.height);
	
	CGContextSetShadowWithColor(context,
					   CGSizeMake(0, 5),
					   100,
					   WHT(0));
	
	CGContextSetFillColorWithColor(context, WHTA(0,0.9));
	CGContextAddRoundedRect(context, CGInsetRect(iRect, 5), 15);
	CGContextFillPath(context);
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame;
    frame.origin = CGPointMake(lroundf(origin.x),
							   lroundf(origin.y));
    frame.size = [[self class] defaultIconSize];
	[super setFrame:frame];
}

- (void)reload {
	float captionHeight = 30;
    [_nameText removeFromSuperlayer];
    [_nameText release];
    _nameText = [MXText text:_name inRect:CGRectMake(0, self.frame.size.height - captionHeight, self.frame.size.width, captionHeight)];
	[_nameText setFont:_iconFont];
	[_nameText setColor:WHT(1)];
	[_nameText setShadowColor:WHT(0)];
	[_nameText setShadowOffset:CGSizeMake(0, 1)];
	[self addSublayer:_nameText];

    [_iconImage setImage:_icon];
    [_iconImage setNeedsDisplay];
	[_iconImage setShouldAddGlossAndClipping:!_isPrerendered];
}

@end
