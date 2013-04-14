//
//  MXFolderIcon.h
//  MobileX
//
//  Created by Nick on 18/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXFolder.h"
#import "MXIcon.h"

@interface MXFolderIcon : MXControl {
	MXFolder* _folder;
	NSArray* _icons;
}

@end
