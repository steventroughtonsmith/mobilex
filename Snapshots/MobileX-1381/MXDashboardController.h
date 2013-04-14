//
//  MXDashboardController.h
//  MobileX
//
//  Created by Nick on 14/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXDashboardLayer.h"

@interface MXDashboardController : NSObject {
	MXDashboardLayer* _layer;
	
	BOOL _isShowing;
}

- (void) toggleState;

@end
