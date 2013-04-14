/* UI */

#import <Foundation/Foundation.h>

#import "MXDesktopController.h"
#import "MXIconController.h"

#import "MXTaskbar.h"
#import "MXTaskbarIconItem.h"
#import "MXTaskbarPanePreviewItem.h"

@interface MXUIController : NSObject {
    MXDesktopController *_desktopController;
    MXIconController *_iconController;
	MXTaskbar* _taskbar;
	
	MXLayer* _rootLayer;
}

@property (readonly,retain) MXTaskbar* taskbar;
@property (readonly,retain) MXDesktopController* desktop;

@end
