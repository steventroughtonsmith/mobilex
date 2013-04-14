//
//  SKWifiManager.h
//  MobileDiagnostics
//
//  Created by Nick on 10/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MobileWiFi.h"

@interface WifiManager : NSObject {
	WiFiDeviceClientRef _device;
	WiFiManagerClientRef _wifiManager;
	
	NSMutableArray* _networks;
}

@property (readonly) NSArray* networks;
@property BOOL wifiEnabled;

+ (id) sharedInstance;

- (void) scan;
- (void) joinNetwork:(NSDictionary*)network password:(NSString*)password;

@end
