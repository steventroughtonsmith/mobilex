/* Render manager */

#import <Foundation/Foundation.h>
#import "MXApplication.h"
#import "MXPaneManager.h"
#import "MXHostWindow.h"

MXHostWindow*
MXRenderManagerGetHostWindowForApplication(MXApplication* application);

void
MXRenderManagerPushContext(unsigned context,
						   float windowLevel,
						   int windowOutput,
						   MXApplication* application);
