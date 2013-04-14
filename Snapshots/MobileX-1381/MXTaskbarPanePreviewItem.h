//
//  MXTaskbarPanePreviewItem.h
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXTaskbarItem.h"
#import "MXPanePreview.h"

@interface MXTaskbarPanePreviewItem : MXTaskbarItem {
	MXPanePreview* _preview;
}

@end
