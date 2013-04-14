//
//  MXClippedImageLayer.h
//  MobileX
//
//  Created by Nick on 15/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXKit.h"

@interface MXClippedImageLayer : MXImageLayer {
	BOOL _hasClipRect;
	CGRect _clipRect;
}

- (CGRect) clipRect;
- (void) setClipRect:(CGRect)rect;
- (void) unsetClipRect;

@end
