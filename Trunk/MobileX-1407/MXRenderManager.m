/* Render manager */

#import "MXRenderManager.h"

MXHostWindow*
MXRenderManagerGetHostWindowForApplication(MXApplication* application)
{
	for (MXPane* pane in [[MXPaneManager shared] allPanes])
	{
		if ([pane isKindOfClass:[MXHostWindow class]])
		{
			MXHostWindow* host = (MXHostWindow*)pane;
			if ([[[host application] bundleIdentifier] isEqualToString:
				 [application bundleIdentifier]])
			{
				return host;
			}
		}
	}
	return NULL;
}

void
MXRenderManagerPushContext(unsigned context,
						   float windowLevel,
						   int windowOutput,
						   MXApplication* application)
{
	if (context == 0) {
		MSLog(@"Can't push context: context == 0");
		return;
	}
	
	if (application == nil) {
		MSLog(@"Can't push context: invalid application");
		return;
	}
	
	MXHostWindow* host = NULL;
	host = MXRenderManagerGetHostWindowForApplication(application);
	
    
    
	if (host != NULL) {
		[[host renderLayer] pushContext:context
							windowLevel:windowLevel
						   windowOutput:windowOutput];
       
        if (host.isOffscreen)
            [host animateOnscreen];
	}
			
}
