//
//  MXPlatformController.h
//  MobileX
//
//  Created by Nick on 25/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GraphicsServices/GraphicsServices.h>

@interface MXPlatformController : NSObject {
	NSDictionary* _systemVersionDictionary;
	NSMutableDictionary* _currentCapabilities;
}


+ (id)shared;

- (BOOL) hasCapability:(CFStringRef)capability;

@end
