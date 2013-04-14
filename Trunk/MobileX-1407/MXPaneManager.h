/*
 
 # MXPaneManager
 # WindowSupport
 
 This class is essentialy the window manager.
 It manages the panes which are basically like Mac OS X windows.

 */

#import <Foundation/Foundation.h>
#import "MXPane.h"
#import "MXExposeLayer.h"

@interface MXPaneManager : NSObject {
	int _topPaneId;
	unsigned int _topPanePosition;
	
	NSMutableArray* _exposeCrosses;
	
	NSMutableArray* _panes;
	MXLayer* _paneRoot;
	CGSize _size;
	
	MXPane* _activePane;
	CGPoint _lastAutoPosition;
	
	MXExposeLayer* _exposeLayer;
	BOOL _exposeActive;
	BOOL _revealActive;
	
	OSSpinLock _exposeLock;
	
	NSMutableArray* _recentPanes;
}

@property (readonly) MXPane* activePane;
@property (readonly) CGSize screenSize;

+ (id) shared;

/* Events */
- (int) registerPane:(MXPane*)pane;
- (void) unregisterPane:(MXPane*)pane;
- (void) pane:(MXPane*)pane changedFrame:(CGRect)frame;

/* Metrics */
- (void) autoPositionPane:(MXPane*)pane;

/* Pane Array */
- (int) normalPaneCount;
- (NSArray*) allPanes;
- (NSArray*) recentPanes;

- (id) paneById:(int)pId;

/* Activation */
- (void) activatePane:(id)pane;
- (MXPane*) activePane;

/* Show/Hide */
- (void) hidePane:(id)pane;
- (void) showPane:(id)pane;

- (BOOL) exposeActive;

/* Size */
- (CGSize) screenSize;

/* testing */

@end
