/* CoreAnimation - CARenderServer.h 
 Shared render server rendering methods
 */

#import <IOSurface/IOSurfaceAPI.h>

void CARenderServerRenderDisplay(mach_port_t port,
								CFStringRef displayName,
								IOSurfaceRef renderSurface,
								void* unk1,
								void* unk2);
/*
void CARenderServerRenderLayer(mach_port_t port,
							   void* layer,
							   IOSurfaceRef renderSurface); */

int CARenderServerGetFrameCounter(mach_port_t port);

void CARenderShowStatistics(void);