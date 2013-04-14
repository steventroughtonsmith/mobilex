/* 
 State services.
 Interaction with applications.
 */

#import "MXApplicationStateServices.h"
#import "MXApplicationController.h"
#import "MXRenderManager.h"
#import "MXApplication.h"
#import "MXPaneManager.h"
#import "MXHostWindow.h"
#import "MXController.h"

static OSSpinLock _launchLock;

void MXLaunchApplicationWithIdentifier(NSString* identifier)
{
	if (identifier == nil) 
	{
		MSLog(@"Can't start application: identifier == nil");
	}
	else
	{
		MXApplication* app = [[MXApplicationController sharedInstance] applicationForIdentifier:identifier];
	
		if (app != NULL) 
		{
			OSSpinLockLock(&_launchLock);
			
			if ([app isRunning]) 
			{
				MXHostWindow* host = MXRenderManagerGetHostWindowForApplication(app);
				if (host != NULL) 
				{
					[host activate];
				}
				else 
				{
					MSLog(@" *** Can't resume %@ as it doesn't have a host window!",app);
				}
			}
			else 
			{
				BOOL isClassic = FALSE;
				BOOL isFullscreen = FALSE;
				BOOL isCheckInApp = FALSE;
				int windowLevel = -1;
				CGRect checkInOffset = CGRectMake(0, 0, 0, 0);
				
				if ([app checkInRecord] != nil) {
					isClassic = [[app checkInRecord] boolForKey:@"IsClassic"];
					isFullscreen = [[app checkInRecord] boolForKey:@"IsFullscreen"];
					isCheckInApp = TRUE;
					
					if ([[app checkInRecord] objectForKey:@"WindowLevel"] != nil)
					{
						windowLevel = [[[app checkInRecord] objectForKey:@"WindowLevel"] intValue];
					}
					
					checkInOffset = CGRectMake([[[app checkInRecord] objectForKey:@"ContextX"] floatValue],
											   [[[app checkInRecord] objectForKey:@"ContextY"] floatValue],
											   [[[app checkInRecord] objectForKey:@"ContextW"] floatValue],
											   [[[app checkInRecord] objectForKey:@"ContextH"] floatValue]);
				}
				else {
					if ([MXSettingsController boolForKey:XXX_FULLSCREENAPPS]) {
						isFullscreen = TRUE;
						isClassic = FALSE;
					}
					else {
						isFullscreen = FALSE;
						isClassic = TRUE;
					}
				}

				
				MXRenderLayer* renderer = [[MXRenderLayer alloc] initWithFullscreen:isFullscreen];
				MXHostWindow* appWnd = [[MXHostWindow alloc] initWithHostedLayer:renderer];
				
				[appWnd release];
                
				
#if 1
				if (isCheckInApp) {
					[appWnd setIsFullscreen:isFullscreen];
					[appWnd setFixed:TRUE];
					
					[app setIsClassic:isClassic];
						
					if (isClassic && (checkInOffset.origin.x == 0 || checkInOffset.origin.y == 0)) {
						if ([[[MXDevice currentDevice] model] hasPrefix:@"AppleTV"]) {
							[renderer setContextOffset:CGRectMake(-452, -124, 0, 0)];	
						}
						else {
							[renderer setContextOffset:CGRectMake(-352, -144, 0, 0)];	
						}
					}
					else {
						[renderer setContextOffset:CGRectMake(checkInOffset.origin.x, checkInOffset.origin.y, 0, 0)];
					}
					
					if (windowLevel != -1)
					{
						[appWnd setZPosition:windowLevel];
					}
				}
				else {
					
					[appWnd setIsFullscreen:isFullscreen];
					[appWnd setFixed:FALSE];
					
					[app setIsClassic:isClassic];
					
					if (!isFullscreen) {
						[appWnd autoPosition];
					}
					
					if (isClassic) {
						if ([[[MXDevice currentDevice] model] hasPrefix:@"AppleTV"]) {
							[renderer setContextOffset:CGRectMake(-472, -126, 0, 0)];	
						}
						else {
							[renderer setContextOffset:CGRectMake(-352, -144, 0, 0)];	
						}
					}
					else {
						[renderer setContextOffset:CGRectMake(0, 0, 0, 0)];
					}
                    
				}
                
#endif
				
				[appWnd setApplication:app];
				[appWnd setText:[app displayName]];
				[appWnd setNeedsDisplay];
                
                             
                if (!isCheckInApp)
                {
                    CGPoint appPos = appWnd.position;
                    appWnd.position = CGPointMake(appPos.x, appPos.y+720.0);
                    
                    appWnd.isOffscreen = YES;
                }
                
				[app launch];
                
                }
			
			OSSpinLockUnlock(&_launchLock);
		}
		else 
		{
			MSLog(@"Cannot find application with identifier %@.",identifier);
			return;
		}
	}
	
	
}