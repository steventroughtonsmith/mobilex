//
//  MXMainLayer.h
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "MXImageLayer.h"
#import "MXControl.h"

@interface MXMainLayer : MXControl {
	unsigned int _contextId;
	
	NSString* _errorMessage;
	BOOL _hasError;
}

+ (id) mainLayer;
- (void) takeScreenshot;

- (void) setError:(NSString*)error;

@end
