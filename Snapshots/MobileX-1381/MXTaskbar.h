//
//  MXTaskbar.h
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXKit.h"
#import "MXTaskbarItem.h"

@interface MXTaskbar : MXPane {
	NSMutableArray* _items;
}

- (void) addItem:(MXTaskbarItem*)item;
- (void) layoutItems;

@end
