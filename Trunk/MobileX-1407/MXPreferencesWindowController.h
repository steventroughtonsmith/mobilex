//
//  MXPreferencesWindowController.h
//  MobileX
//
//  Created by Nick on 14/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXKit.h"
#import "MXWindow.h"

@interface MXPreferencesWindowController : NSObject {
	MXTableView* _tableView;
	MXWindow* _window;
	NSArray* _specifiers;
}

+ (id) shared;

- (void) show;

@end
