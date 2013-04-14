#import <Foundation/NSObject.h>
#import <CoreGraphics/CoreGraphics.h>

@class NSString;

@interface CAWindowServerDisplay : NSObject
{
    void *_impl;
}

/* - (id)_initWithCADisplayServer:(void*)arg1; */

- (void)invalidate;
- (void)dealloc;

@property(readonly) CGRect bounds;
@property(readonly) NSString *name;
@property(readonly) NSString *deviceName;
@property(readonly) unsigned int displayId;
@property(readonly) unsigned int rendererFlags;

- (id)contextIdsWithClientPort:(unsigned int)arg1;
- (unsigned int)contextIdAtPosition:(CGPoint)arg1;
- (unsigned int)clientPortAtPosition:(CGPoint)arg1;
- (unsigned int)clientPortOfContextId:(unsigned int)arg1;
- (unsigned int)contextIdHostingContextId:(unsigned int)arg1;
- (CGRect)frameOfContextId:(unsigned int)arg1;
- (CGPoint)convertPoint:(CGPoint)arg1 toContextId:(unsigned int)arg2;
- (CGPoint)convertPoint:(CGPoint)arg1 fromContextId:(unsigned int)arg2;
@property(readonly) NSSet *clones;
- (void)addClone:(id)arg1 options:(id)arg2;
- (void)addClone:(id)arg1;
- (void)removeClone:(id)arg1;
- (void)removeAllClones;
@property(readonly) CAWindowServerDisplay *cloneMaster;
@property(getter=isBlanked) BOOL blanked;
@property(copy) NSString *orientation;
@property float overscanAmount;
@property BOOL invertsColors;
@property float contrast;
@property float minimumRefreshRate;
@property float maximumRefreshRate;
@property float idealRefreshRate;
@property BOOL usesPreferredModeRefreshRate;
@property(copy, nonatomic) NSString *colorMode;
@property BOOL allowsVirtualModes;
@property(getter=isMirroringEnabled) BOOL mirroringEnabled;
@property int tag;
@property(copy) NSString *TVMode;
@property(copy) NSString *TVSignalType;
- (id)description;

@end


