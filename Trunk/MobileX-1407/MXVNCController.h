//
//  MXVNCController.h
//  MobileX
//
//  Created by Nick on 31/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IOSurface/IOSurfaceAPI.h>

#import <GraphicsServices/GraphicsServices.h>

#import "rfb.h"
#import "rfbproto.h"

#import "MXHIDController.h"

typedef struct SingleTouch {
	GSEventRecord record;
	GSHandInfo data;
	GSPathInfo path;
} SingleTouch;

@interface MXVNCController : NSObject {
	rfbScreenInfoPtr rfbServer;
	
	CGPoint _cursor;
	bool _serverStarted;
}

+ (id) shared;

@end
