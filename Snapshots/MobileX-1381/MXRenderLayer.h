/*
 * MXRenderLayer.h
 * UIKit Window Manager
 *
 * This manages UIKit windows for each application.
 * Each application manages its own window stacks.
 * Each window is a remote context which is drawn by the app and rendered by this.
 * The context order is managed in a mysterious fashion.
 */

#import <Foundation/Foundation.h>
#import "MXKit.h"

@interface MXRenderLayer : MXControl {
	NSMutableArray* _hostStack;
	MXImageLayer* _snapshotImage;
	BOOL _isFullScreen;
	BOOL _isSuspended;
	BOOL _locked;
	
	CGRect _contextOffset;
	OSSpinLock _enumerationLock;
}

@property CGRect contextOffset;

- (id) initWithFullscreen:(BOOL)fullscreen;

- (void) setIsFullscreen:(BOOL)fs;
- (void) pushContext:(unsigned)context windowLevel:(float)windowLevel windowOutput:(int)windowOutput;

- (void) willSuspend;
- (void) suspended;
- (void) resumed;

@end
