//
//  MXMenu.h
//  MobileX
//
//  Created by Nick on 08/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXPane.h"
#import "MXMenuItem.h"

@interface MXMenu : MXPane {
	NSMutableArray* _items;
}

- (void) addItem:(id)item;

@end
