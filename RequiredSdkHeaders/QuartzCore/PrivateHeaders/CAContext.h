#import <Foundation/NSObject.h>

@class CALayer;

@interface CAContext : NSObject 

	@property(readonly, assign) unsigned contextId;
	@property(retain) CALayer* layer;
	//@property(assign) CGColorSpaceRef colorSpace;
	@property(readonly, assign) BOOL valid;
	@property(assign) float level;
	+(id)allContexts;
	+(id)currentContext;
	+(id)localContext;
	+(id)localContextWithOptions:(id)options;
	+(id)remoteContext;
	+(id)remoteContextWithOptions:(id)options;
	+(void)setClientPort:(unsigned)port;
	+(id)objectForSlot:(unsigned)slot;
	-(void)invalidate;
	-(void)orderAbove:(unsigned)above;
	-(void)orderBelow:(unsigned)below;
	-(void)setFence:(unsigned)fence count:(unsigned)count;
	-(unsigned)createSlot;
	-(void)deleteSlot:(unsigned)slot;
	-(void)setObject:(id)object forSlot:(unsigned)slot;

@end

