//
//  MXWindow+Frame.h
//  MobileX
//
//  Created by Nick on 02/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXWindow.h"

@interface MXWindow (Frame)

- (void) _layoutWindowControlsInFrame:(CGRect)frm;
- (void) _layoutWindowContents;
- (void) _updateWindowMetrics;

@end
