//
//  MXController+Internal.h
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXController.h"

#import <QuartzCore/CAWindowServer.h>
#import <QuartzCore/CAWindowServerDisplay.h>
#import "MXColors.h"
#import "MXText.h"
#import "MXImageLayer.h"
#import "MXCG.h"
#import "MXHIDController.h"
#import <GraphicsServices/GraphicsServices.h>

@interface MXController (MXCInternal)

- (void) _initializationFinished;

- (void) bootstrapRenderServer:(BOOL)useUIKit;
- (void) bindMainLayer:(CALayer*)layer;

@end
