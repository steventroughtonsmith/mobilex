/*
 * UIKit classes for MobileX
 *
 * Allows MobileX to run as a UIKit application (just like SpringBoard).
 */

#import "uiKitProxy.h"
#import "MXController.h"
#import <UIKit/UIKit.h>

@interface uiKitProxyDelegate : NSObject {
}
@end

@interface uiKitApp : UIApplication {
}
@end

@implementation uiKitProxyDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { 
	UIWindow* wnd = 
	[[UIWindow alloc] initWithFrame:CGRectMake(0,
											   0,
											   [[UIScreen mainScreen] bounds].size.width,
											   [[UIScreen mainScreen] bounds].size.height)];
	
	[wnd makeKeyAndVisible];
	
	/* this doesn't work :( */
	[wnd _updateStatusBarToInterfaceOrientation:UIInterfaceOrientationLandscapeRight
									   duration:1.0f
										fenceID:0
									  animation:nil];
	/*
	 * Proxy our main layer using the app's UIWindow.
	 */
	[[wnd layer] addSublayer:[[MXController shared] mainLayer]];
	
	NSLog(@"UIKit application started.");
	
	return TRUE;
}

@end

@implementation uiKitApp

- (id) _run {
	MXSLog(@"Using the highly prototypal UIKit renderer.");
	
	/*
	 * I prefer this over the Info.plist stuff.
	 */
	[self _setIsClassic:FALSE];
	
	return [super _run];
}

+ (BOOL) rendersLocally {
	return TRUE;
}

+ (BOOL) registerForSystemEvents {
	return TRUE;
}

+ (BOOL) isClassic {
	return FALSE;
}

@end

void uiKitProxyStart(void) {
	UIApplicationMain(0,
					  NULL,
					  NSStringFromClass([uiKitApp class]),
					  NSStringFromClass([uiKitProxyDelegate class]));
}