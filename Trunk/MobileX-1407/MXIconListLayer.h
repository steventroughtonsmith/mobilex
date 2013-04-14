
#import <Foundation/Foundation.h>

#import "MXIcon.h"

@interface MXIconListLayer : MXLayer {
    NSArray *_icons;
}

@property (nonatomic, retain) NSArray *icons;

+ (int)maxIconRows;
+ (int)maxIconColumns;
- (void)relayout;

@end



