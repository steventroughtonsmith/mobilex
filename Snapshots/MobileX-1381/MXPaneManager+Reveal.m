/* Reveal Manager */

#import "MXPaneManager+Reveal.h"


@implementation MXPaneManager (Reveal)

- (void) toggleReveal
{
	if (_revealActive)
	{
		[self stopReveal];
	}
	else 
	{
		[self startReveal];
	}
}

- (void) startReveal
{
	_revealActive = TRUE;
	for (MXPane* pane in _panes)
	{
		if ([pane respondsToCommonEnumeration] && ([pane isVisible]))
		{
			[pane saveFrame];
			[pane setPosition:CGPointMake([pane frame].origin.x ,[pane frame].size.height *-1)];
		}
	}
}

- (void) stopReveal
{
	_revealActive = FALSE;
	for (MXPane* pane in _panes)
	{
		if ([pane respondsToCommonEnumeration] && ([pane isVisible]))
		{
			[pane setPosition:[pane getSavedFrame].origin];
		}
	}
}

@end
