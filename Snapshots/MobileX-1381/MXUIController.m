/* UI */

#import "MXUIController.h"

#import "MXApplicationController.h"
#import "MXApplicationIcon.h"
#import "MXWindow.h"
#import "MXTableView.h"

#import "MXDashboardLayer.h"
#import "MXPreferencesWindowController.h"
#import "MXController.h"
#import "MXFolder.h"

#define DOCKOFFSET 70
#define DOCKHEIGHT 70

@implementation MXUIController

- (void) _initTestLayers
{
	MXFolder* fl = [[MXFolder alloc] initWithFrame:CGRectMake(200, 200, 74, 74)];
	[[[MXController shared] mainLayer] addSublayer:fl];
}

- (MXDesktopController*) desktop
{
	return _desktopController;
}

- (MXDashboardController*) dashboard 
{
	return _dashboardController;
}

- (MXTaskbar*) taskbar
{
	return _taskbar;
}

- (void) _initTaskbarWithLayer:(CALayer*)root
{
	_taskbar = [[MXTaskbar alloc] initWithFrame:CGRectMake(DOCKOFFSET,
														   root.frame.size.height-DOCKHEIGHT,
														   root.frame.size.width-DOCKOFFSET*2,
														   DOCKHEIGHT)];
	MXTaskbarIconItem* icon;
	
	icon = [[MXTaskbarIconItem layer] init];
	[icon setIcon:[MXImage imageNamed:@"btnExit.png"]];
	[icon addTarget:[MXController shared] action:@selector(startSpringBoard)];
	[_taskbar addItem:icon];
	
	icon = [[MXTaskbarIconItem layer] init];
	[icon setIcon:[MXImage imageNamed:@"btnScreenshot.png"]];
	[icon addTarget:root action:@selector(takeScreenshot)];
	[_taskbar addItem:icon];
	
	icon = [[MXTaskbarIconItem layer] init];
	[icon setIcon:[MXImage imageNamed:@"btnSettings.png"]];
	[icon addTarget:[MXPreferencesWindowController shared] action:@selector(show)];
	[_taskbar addItem:icon];
	
	[_taskbar setNeedsDisplay];
	[_taskbar layoutItems];
	
	[_taskbar retain];
}

- (id)initWithLayer:(CALayer *)root {
    if ((self = [super init])) {
		_rootLayer = (MXLayer*)root;
    }

    return self;
}

- (void)dealloc {
    [_desktopController release];
    [_iconController release];

    [super dealloc];
}

@end
