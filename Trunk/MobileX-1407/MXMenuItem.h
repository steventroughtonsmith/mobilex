//
//  MXMenuItem.h
//  MobileX
//
//  Created by Nick on 08/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXControl.h"
#import "MXText.h"

@interface MXMenuItem : MXControl {
	MXText* _caption;
	BOOL _isDown;
}

@property (nonatomic,readonly) MXText* caption;

+ (id) menuItemWithCaption:(NSString*)caption;
+ (id) menuItemWithCaption:(NSString*)caption
					target:(id)target
					action:(SEL)action;

@end
