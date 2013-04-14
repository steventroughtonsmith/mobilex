//
//  MXHostWindow.h
//  MobileX
//
//  Created by Nick on 02/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXKit.h"
#import "MXWindow.h"
#import "MXApplication.h"
#import "MXRenderLayer.h"

@interface MXHostWindow : MXWindow {
	MXApplication* _application;
	BOOL _isFullscreen;
	BOOL _isSuspended;
	BOOL _fixed;
}

@property BOOL isFullscreen;
@property BOOL fixed;

@property (retain) MXApplication* application;
@property (readonly, retain) MXRenderLayer* renderLayer;

@end
