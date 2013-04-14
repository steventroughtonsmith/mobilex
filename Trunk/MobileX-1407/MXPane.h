//
//  MXPane.h
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXControl.h"

@interface MXPane : MXControl {
	int _paneId;
	BOOL _active;
	BOOL _isMinimized;
	BOOL _isInExpose;
	
	CGRect _savedFrame;
	BOOL _savedFrameLocked;
	
	BOOL _shouldBecomeVisible;
	BOOL _visibilityStateLocked;
}

@property BOOL isInExpose;
@property (readonly) int paneId;

- (void) unregister;

- (void) activate;

- (void) paneDeactivated;
- (void) paneActivated;

- (void) _activateIfNeeded;
- (void) _deactivateIfNeeded;

- (void) autoPosition;

/* used by pane manager to determine stuff */
- (BOOL) shouldForceTopmost;
- (BOOL) shouldDisplayOnRegister;
- (BOOL) respondsToCommonEnumeration;

/* show/ hide */
- (void) show;
- (void) hide;

- (void) minimize;
- (void) restore;

/* used for effects */
- (CGRect) getSavedFrame;
- (void) saveFrame;
- (void) saveVisibilityStateAndHide;
- (void) restoreVisibilityState;

- (BOOL) isVisible;
- (BOOL) isMinimized;
- (BOOL) isFixed;

@end
