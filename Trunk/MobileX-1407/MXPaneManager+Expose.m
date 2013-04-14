/* Expose Manager */

#import "MXPaneManager+Expose.h"
#import "MXCloseCross.h"
#import "MXController.h"

@implementation  MXPaneManager (Expose)

#pragma mark Actions
- (void) onCloseCrossTouch:(id)window sender:(id)sender
{
	[sender removeFromSuperlayer];
	[window close];
	
	[window setIsInExpose:FALSE];
}

#pragma mark Start/Stop
- (void) toggleExpose
{
	if (_exposeActive) {
		[self stopExpose];
	}
	else {
		[self startExpose];
	}

}

- (void) _addExposeCrosses
{
	for (MXCloseCross* cross in _exposeCrosses) {
		[CATransaction begin];
		[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
		
		[[[MXController shared] mainLayer] addSublayer:cross];
		[cross setZPosition:1000000];

		NSAssert([cross obj] != nil, @"[cross obj] == nil");
		
		[cross addSenderTarget:self action:@selector(onCloseCrossTouch:sender:) withObject:[cross obj]];
		[CATransaction commit];
	}
}

- (void) _removeCrosses
{
	[CATransaction begin];
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
	
	[_exposeCrosses makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
	[_exposeCrosses removeAllObjects];
	[CATransaction commit];
}

- (void) stopExpose
{
	OSSpinLockLock(&_exposeLock);
	
	_exposeActive = FALSE;
	
	[self _removeCrosses];
	
	[_exposeLayer deactivate];
	
	[CATransaction begin];
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
	[_exposeLayer removeFromSuperlayer];
	[CATransaction commit];
	
	for (MXPane* pane in _panes)
	{
		if ([pane respondsToCommonEnumeration] && ([pane isVisible] || [pane isMinimized]))
		{
			if ([pane isMinimized]) {
				[CATransaction begin];
				[pane setHidden:TRUE];
				[CATransaction commit];
				
				[CATransaction begin];
				[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
				[pane setPosition:[pane getSavedFrame].origin];
				[pane setTransform:CATransform3DMakeScale(1, 1, 1)];
				[CATransaction commit];
			}
			else {
				[CATransaction begin];
				[pane setPosition:[pane getSavedFrame].origin];
				[pane setTransform:CATransform3DMakeScale(1, 1, 1)];
				[CATransaction commit];
			}
		}
		
		[pane setIsInExpose:FALSE];
	}
	
	[_exposeLayer removeFromSuperlayer];
	
	OSSpinLockUnlock(&_exposeLock);
	
}

- (void) startExpose:(BOOL)newSession
{
	OSSpinLockLock(&_exposeLock);
	
	_exposeActive = TRUE;
	
	if (!newSession) {
		[self _removeCrosses];
	}
	
	/* offsetized */
	float omx = 0;
	float omy = 0;
	
	/* counters */
	float mx = omx;
	float my = omy;
	
	CGSize pr = _paneRoot.frame.size;
	int n = [self normalPaneCount];
	
	/* Maths! */
	int columns = ceil(sqrt(n));
	int rows = ceil(n / (double)columns);
	float cellWidth = pr.width / columns;
	float cellHeight = pr.height / rows;
	
	MSLog(@"Expose(%d) {N:%d Rows:%d Cols:%d}",newSession,n,rows,columns);
	
	[CATransaction begin];
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
	[[[MXController shared] mainLayer] addSublayer:_exposeLayer];
	[CATransaction commit];
	
	[_exposeLayer activate];
	
	int cc = 1; /* current col */
	int cr = 1; /* current row */
	for (MXPane* pane in _panes)
	{
		if ([pane respondsToCommonEnumeration] && ([pane isVisible] || [pane isMinimized]))
		{
			[pane setIsInExpose:TRUE];
			
			[pane saveFrame];
			
			/* work out the new frame */
			CGSize pSize;
			
			if (newSession) {
				pSize = pane.frame.size;
			}
			else {
				pSize = [pane getSavedFrame].size;
			}

			
			/* final values */
			float gscale = 1;
			float fmx = mx;
			float fmy = my;
			
			if (pSize.width <= cellWidth && pSize.height <= cellHeight) {
				/* pane fits without scaling, so center */
				float addMx = cellWidth/2 - pSize.width/2;
				float addMy = cellHeight/2 - pSize.height/2;
				
				fmx += addMx;
				fmy += addMy;
			}
			else {
				/* needs scaling, scale proportionally and center */
				
				/* factors */
				float scWidth = cellWidth/pSize.width;
				float scHeight = cellHeight/pSize.height;
				
				/* proportional factor */
				float propFactor = MIN(scWidth,scHeight);
				
				float addMx = cellWidth/2 - (pSize.width*propFactor)/2;
				float addMy = cellHeight/2 - (pSize.height*propFactor)/2;
				
				/* set finals */
				gscale = propFactor;
				fmx += addMx;
				fmy += addMy;
			}
			
			/* apply */
			float scale0 = gscale;
			float scale1 = gscale;
			if ([pane isMinimized] && newSession) {
				[CATransaction begin];
				[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
				[pane setTransform:CATransform3DMakeScale(scale0, scale1, 1)];
				[pane setPosition:CGPointMake(fmx, fmy)];
				[CATransaction commit];
				
				[CATransaction begin];
				[pane setHidden:FALSE];
				[CATransaction commit];
			}
			else {
				[CATransaction begin];
				
				[pane setTransform:CATransform3DMakeScale(scale0, scale1, 1)];
				[pane setPosition:CGPointMake(fmx, fmy)];
				[CATransaction commit];
			}
			
			if (cc != columns) {
				mx += cellWidth;
				cc += 1;
			}
			else {
				mx = omx;
				my += cellHeight;
				cc = 1;
				cr += 1;
			}
			
			MXCloseCross* cross = [[MXCloseCross alloc] initWithFrame:CGRectMake((pane.position.x+(1*scale0)),
																				 (pane.position.y+(1*scale1)),
																				 25+CROSS_SHADOW_INSET*2,
																				 25+CROSS_SHADOW_INSET*2)];
			[cross setObj:pane];
			[_exposeCrosses addObject:cross];
		}
	}
	
	/* XXX: Really? */
	[self performSelector:@selector(_addExposeCrosses)
			   withObject:nil
			   afterDelay:0.3];
	
	OSSpinLockUnlock(&_exposeLock);
}

- (void) startExpose
{
	[self startExpose:TRUE];
}

@end
