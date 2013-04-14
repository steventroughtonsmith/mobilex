#import <QuartzCore/CALayer.h>


@interface CALayerHost : CALayer {
}

@property(assign) unsigned contextId;
// inherited: -(void)didChangeValueForKey:(id)key;
-(void*)_copyRenderLayer:(void*)layer flags:(unsigned*)flags;
-(bool)_renderLayerDefinesProperty:(unsigned)property;
-(void)layerDidBecomeVisible:(BOOL)layer;

@end

