//
//  MXTaskbarIconItem.h
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXTaskbarItem.h"

@interface MXTaskbarIconItem : MXTaskbarItem {
	MXImageLayer* _icon;
	
	CGRect _iconFrame;
	CGRect _topFrame;
	BOOL _isDown;
}

- (void) setIcon:(MXImage*)img;

@end
