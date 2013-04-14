//
//  MXController+EventHandling.h
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXController.h"
#import <GraphicsServices/GraphicsServices.h>

@interface MXController (MXCEventHandling)

- (void) handleEvent:(void*)event;

@end
