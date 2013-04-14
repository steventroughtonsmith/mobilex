
#import "MXIconScrollLayer.h"

@implementation MXIconScrollLayer

- (int)iconListCount {
    return _count;
}

- (void)setIconListCount:(int)count {
    _count = count;

    [self setContentSize:CGSizeMake(count * [self bounds].size.width, [self bounds].size.height)];
}

@end


