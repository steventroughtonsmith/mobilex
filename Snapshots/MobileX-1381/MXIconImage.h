//
//  MXIconImage.h
//  MobileX
//
//  Created by Nick on 25/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXKit.h"

@interface MXIconImage : MXImageLayer {
	BOOL _prerendered;
}

- (void) setShouldAddGlossAndClipping:(BOOL)pr;

@end
