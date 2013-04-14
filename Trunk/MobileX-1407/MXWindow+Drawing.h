//
//  MXWindow+Drawing.h
//  MobileX
//
//  Created by Nick on 02/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXWindow.h"

@interface MXWindow (Drawing)

- (void) _drawBorderedWindowInContext:(CGContextRef)ctx;
- (void) _drawBorderlessWindowInContext:(CGContextRef)ctx;

@end
