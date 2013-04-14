
#import <Foundation/Foundation.h>

#import "MXScrollLayer.h"
#import "MXIconListLayer.h"

@interface MXIconScrollLayer : MXScrollLayer {
    int _count;
}

@property (nonatomic, assign) int iconListCount;

@end

