//
//  
//  MobileX
//
//  Created by Nick on 31/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXKit.h"
#import "MXWindow.h"
#import "MXHIDController.h"

@interface MXSystemMenu : MXWindow {
	MXLayer* _contents;
	NSMutableDictionary* _itemSets;
	id _currentSet;
	uint32_t _index;
	
	NSString* _currentItemSetName;
	BOOL _wifiScanning;
}

+ (id) shared;

- (BOOL) isOpen;
- (id) createSystemMenu;
- (void) sendKey:(uint32_t)page isDown:(boolean_t)down;

@end
