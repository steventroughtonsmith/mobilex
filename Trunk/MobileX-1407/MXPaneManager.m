/*
 
 # MXPaneManager
 # WindowSupport
 
 This class is essentialy the window manager.
 It manages the panes which are basically like Mac OS X windows.
 
 */

#import "MXPaneManager.h"
#import "MXCG.h"
#import "MXController.h"
#import "MXDevice.h"
#import "MXPaneManager+Expose.h"

static id _shinst = NULL;

@implementation MXPaneManager

+ (id) shared
{
	if (_shinst==NULL)
	{
		_shinst = [MXPaneManager alloc];
		[_shinst init];
	}
	
	return _shinst;
}

- (id) init
{
	[super init];
	_panes = [NSMutableArray new];
	_recentPanes = [NSMutableArray new];
	_exposeCrosses = [NSMutableArray new];
	_paneRoot = [[MXController shared] mainLayer];
	
	/*
	 * Window levels 1-100 are for special panes
	 * Window levels 100-105 are reserved by MXPaneManager
	 * Window levels 105- are for all other panes
	 */
	_topPanePosition = 105; 
	_lastAutoPosition = CGPointMake(50, 50);
	
	_exposeLayer = [[MXExposeLayer alloc] initWithFrame:[[MXDevice currentDevice] screenSizeAsRect]];
	[_exposeLayer setZPosition:101];
	[_exposeLayer retain];

	return self;
}



#pragma mark Pane Array Functions
- (int) normalPaneCount
{
	int count = 0;
	for (MXPane* pane in _panes) 
	{
		if ([pane respondsToCommonEnumeration] && ([pane isVisible] || [pane isMinimized]))
		{
			count += 1;
		}
	}
	return count;
}

- (void) _removePaneFromArray:(MXPane*)pane
{
	[_recentPanes removeObject:pane];
	
	for (int i = 0; i < [_panes count]; i++)
	{
		if ([[_panes objectAtIndex:i] isEqual:pane]) {
			[_panes removeObjectAtIndex:i];
			return;
		}
	}
}

- (NSArray*) allPanes
{
	return _panes;
}

- (id) paneById:(int)pId
{
	for (MXPane* p in _panes)
	{
		if ([p paneId] == pId)
		{
			return p;
		}
	}
	
	return NULL;
}

- (NSArray*) recentPanes {
	return _recentPanes;
}

#pragma mark Pane Metrics
- (void) autoPositionPane:(MXPane*)pane
{
	CGPoint pos = _lastAutoPosition;
	
	[pane setFrame:CGRectMake(_lastAutoPosition.x,
							  _lastAutoPosition.y,
							  pane.frame.size.width,
							  pane.frame.size.height)];
	
	pos.y += 50;
	
	if (pos.y > _size.height) 
	{
		pos.y = 50;
		
		if (pos.x+50 < _size.width)
		{
			pos.x += 50;
		}
	}
	
	_lastAutoPosition = pos;
}

- (BOOL) exposeActive
{
	return _exposeActive;
}

#pragma mark Pane Activation
- (void) _sendUpdateNotification
{
	NSNotification* nt = [NSNotification notificationWithName:@"MTWindowStateChanged" object:nil];
	[[NSNotificationCenter defaultCenter] postNotification:nt];
}

- (void) activatePane:(id)pane
{
	for (MXPane* p in _panes)
	{
		if ([p isEqual:pane]) {
			
			if (![p isFixed]) {
				if ([p shouldForceTopmost]) {
					[p setZPosition:_topPanePosition+10000];
				}
				else {
					[p setZPosition:_topPanePosition];
				}
				
				if ([p isMinimized]) {
					[p restore];
				}
				
				/* push the pane to the stack */
				[_recentPanes removeObject:p];
				[_recentPanes addObject:p];
				
				/* XXX: If this gets too big the app will crash */
				_topPanePosition += 1;
			}
			
			_activePane = p;
			
			[p _activateIfNeeded];
			[self _sendUpdateNotification];
		}
		else {
			[p _deactivateIfNeeded];
		}
	}
	
	if (_exposeActive) {
		[self stopExpose];
		_revealActive = FALSE;
	}
}

- (MXPane*) activePane
{
	return _activePane;
}

#pragma mark Size
- (CGSize) screenSize
{
	return [[MXDevice currentDevice] screenSize];
}

#pragma mark Showing and Hiding
- (void) hidePane:(id)pane
{
	if ([pane superlayer] != nil)
	{
		[_recentPanes removeObject:pane];
		[pane removeFromSuperlayer];
	}
}

- (void) showPane:(id)pane
{
	if ([pane superlayer] == nil)
	{
		[_paneRoot addSublayer:pane];
		[self activatePane:pane];
	}
}

#pragma mark Pane Events
- (void) pane:(MXPane*)pane changedFrame:(CGRect)frame
{
	[self _sendUpdateNotification];
}

- (void) unregisterPane:(MXPane*)pane
{
	//MXSLog(@"Unregistered pane with id:%d",[pane paneId]);
	
	if ([_activePane paneId] == [pane paneId]) {
		_activePane = NULL;
	}
	
	[self _removePaneFromArray:pane];
	[self _sendUpdateNotification];
	
	if (_exposeActive) {
		[self startExpose:FALSE];
	}
}

- (int) registerPane:(MXPane*)pane
{
	_topPaneId += 1;
	int paneId = _topPaneId;
	
	MXSLog(@"Registered %@ with id:%d at %@",pane,paneId,NSStringFromCGRect([pane frame]));
	[_panes addObject:pane];
	
	if ([pane shouldDisplayOnRegister])
	{
		[_paneRoot addSublayer:pane];
		[self activatePane:pane];
	}
	
	[pane setNeedsDisplay];
	return paneId;
}


@end
