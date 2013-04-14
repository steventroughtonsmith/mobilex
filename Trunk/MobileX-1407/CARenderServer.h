/* CoreAnimation - CARenderServer.h 
 Shared render server rendering methods
 */

#import <IOSurface/IOSurfaceAPI.h>

void CARenderServerRenderDisplay(mach_port_t port,
								CFStringRef displayName,
								IOSurfaceRef renderSurface,
								void* unk1,
								void* unk2);

uint32_t CARenderServerRenderLayerWithTransform(void *null, unsigned contextId, CALayer *layer, void *null2, IOSurfaceRef surface, void *null3, void *null4, CATransform3D *transform);
/*
void CARenderServerRenderLayer(mach_port_t port,
							   void* layer,
							   IOSurfaceRef renderSurface); */

int CARenderServerGetFrameCounter(mach_port_t port);

void CARenderShowStatistics(void);