#import <Foundation/NSObject.h>

@class NSArray;

@interface CAWindowServer : NSObject

@property(assign) unsigned rendererFlags;
@property(readonly, assign) NSArray* displays;

+(id)context;
+(id)contextWithOptions:(id)options;
+(id)server;
+(id)serverIfRunning;
-(id)_init;
-(void)addDisplay:(id)display;
-(void)removeDisplay:(id)display;
-(void)removeAllDisplays;
-(id)displayWithName:(id)name;
-(void)_detectDisplays;

@end

