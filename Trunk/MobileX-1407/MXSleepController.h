//
//  MXSleepController.h
//  MobileX
//
//  Created by Nick on 14/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MXSleepController : NSObject {
	float _savedBrightness;
	
	BOOL _isSleeping;
}

+ (id) shared;

- (void) toggleSleepState;
- (void) sleep;
- (void) wake;

@end
