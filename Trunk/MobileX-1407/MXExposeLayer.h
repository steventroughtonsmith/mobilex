//
//  MXExposeLayer.h
//  MobileX
//
//  Created by Nick on 16/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXKit.h"

@interface MXExposeLayer : MXLayer {
	BOOL _active;
}

- (void) activate;
- (void) deactivate;

@end
