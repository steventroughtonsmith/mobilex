//
//  MXMultitouchHandler.h
//  MobileX
//
//  Created by Nick on 03/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GraphicsServices/GraphicsServices.h>
#import "MTTouchType.h"

@interface MXMultitouchHandler : NSObject {
	CALayer* _dragLayer;
	CALayer* _lastResponder;
	
	BOOL _hasHadTouchDown;
}

+ (id) shared;
- (void) beginGlobalDraggingForLayer:(id)layer;

- (BOOL) handleMultitouchEventInPort:(mach_port_t)port atPoint:(CGPoint)location type:(GSHandInfoType)type;
- (void) handleMultitouchEvent:(CGPoint)location type:(MTTouchType)type;

@end
