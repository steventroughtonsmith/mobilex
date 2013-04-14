//
//  MXDevice.h
//  MobileX
//
//  Created by Nick on 01/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MXDevice : NSObject {
	CGSize _screenSize;
	NSDictionary* _platformExpertDict;
}

@property (readonly) CGSize screenSize;

+ (id) currentDevice;

/* internal methods */
- (void) _announcedScreenSize:(CGSize)size;

/* screen */
- (CGRect) screenSizeAsRect;

/* battery */
- (float) batteryLevel;
- (BOOL) isCharging;

/* platform */
- (NSString*) model;
- (BOOL) isWildcat;

@end
