
#import <Foundation/Foundation.h>

#import "MXIcon.h"
#import "MXIconListLayer.h"
#import "MXIconScrollLayer.h"

@interface MXIconController : NSObject {
    NSArray *_icons;
    NSMutableArray *_iconLists;
    int _currentIconListIndex;
    MXIconScrollLayer *_scrollLayer;
}

@property (nonatomic, assign) int currentIconListIndex;

- (MXIconScrollLayer *)iconLayer;
- (MXIconListLayer *)currentIconList;

- (void) loadFromIconState;
- (void) loadFromRepresentation:(NSDictionary *)representation;
- (void) relayout;

@end


