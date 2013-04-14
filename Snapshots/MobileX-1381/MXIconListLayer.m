
#import "MXIconListLayer.h"

@implementation MXIconListLayer
@synthesize icons=_icons;

+ (int)maxIconRows {
    return 4;
}

+ (int)maxIconColumns {
    return 5;
}

- (CGFloat)horizontalInset {
    return 80.0f;
}

- (CGFloat)verticalInset {
    return 100.0f;
}

- (CGFloat)horizontalPadding {
    CGFloat width = [self bounds].size.width;
    width -= [self horizontalInset] + [self horizontalInset];
    CGFloat iconWidth = [MXIcon defaultIconSize].width;
    int iconCount = [[self class] maxIconColumns];
    width -= iconCount * iconWidth;
    return width / (iconCount - 1);
}

- (CGFloat)verticalPadding {
    CGFloat height = [self bounds].size.height;
    height -= [self verticalInset] + [self verticalInset];
    CGFloat iconHeight = [MXIcon defaultIconSize].height;
    int iconCount = [[self class] maxIconRows];
    height -= iconCount * iconHeight;
    return height / (iconCount - 1);
}

- (CGPoint)originForIconAtX:(int)x Y:(int)y {
    CGPoint origin;
    origin.x = [self horizontalInset] + ([self horizontalPadding] + [MXIcon defaultIconSize].width) * x;
    origin.y = [self verticalInset] + ([self verticalPadding] + [MXIcon defaultIconSize].height) * y;
    return origin;
}

- (void)setIcons:(NSArray *)icons {
    [_icons autorelease];
    _icons = [icons retain];
    [self relayout];
}

- (void)relayout {
    for (int x = 0; x < [[self class] maxIconColumns]; x++) {
        for (int y = 0; y < [[self class] maxIconRows]; y++) {
            CGPoint origin = [self originForIconAtX:x Y:y];
            int index = y * [[self class] maxIconColumns] + x;
            if (index >= [_icons count]) continue;
            MXIcon *icon = [_icons objectAtIndex:index];
            [icon setOrigin:origin];
            [self addSublayer:icon];
        }
    }
}

@end


