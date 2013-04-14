/*
 * MXRenderLayer.h
 * UIKit Window Manager
 *
 * This manages UIKit windows for each application.
 * Each application manages its own window stacks.
 * Each window is a remote context which is drawn by the app and rendered by this.
 * The context order is managed in a mysterious fashion.
 */

#import "MXRenderLayer.h"
#import "MXLayerHost.h"
#import "MXScreenCapture.h"

static CFMutableDictionaryRef _renderLayers = NULL;

MXRenderLayer* renderStack_renderLayerForContext(uint32_t contextId) {
	return (MXRenderLayer*)CFDictionaryGetValue(_renderLayers, (void*)contextId);
}

CGPoint renderStack_convertPointToContext(CGPoint pt, uint32_t contextId) {
	MXRenderLayer* rend = renderStack_renderLayerForContext(contextId);
	if (rend == nil) {
		return pt;
	}
	else {
		
	}
}

@implementation MXRenderLayer

@synthesize contextOffset=_contextOffset;

+ (void) initialize {
	if (_renderLayers == NULL) {
		_renderLayers = CFDictionaryCreateMutable(kCFAllocatorDefault,
												  20,
												  NULL,
												  NULL);
	}
}

- (id) initWithFrame:(CGRect)frame
{	
	[super initWithFrame:frame];
	
	_hostStack = [NSMutableArray new];
	_snapshotImage = [[MXImageLayer alloc] initWithFrame:frame];
	_isFullScreen = FALSE;
	
	return self;
}

- (MXImage*) createSnapshot
{
	/*
	 * Enumerates all contexts, and creates a rendered version
	 * Essentially, takes a screenshot of this render layer's app
	 */
	
	OSSpinLockLock(&_enumerationLock);
	
	int count = [_hostStack count];
	unsigned* contexts = malloc(sizeof(unsigned) * count);
	int iter = 0;
	
	for (MXLayerHost* host in _hostStack) {
		contexts[iter] = [host contextId];
		iter += 1;
	}
	
	MXImage* img = 
	MXImageForContextList(contexts, count, CGRectMake(0, 0, 1024, 768));
	
	free(contexts);
	
	OSSpinLockUnlock(&_enumerationLock);
	
	return img;
}

- (id) initWithFullscreen:(BOOL)fullscreen
{
	[super init];
	
	_snapshotImage = [[MXImageLayer alloc] init];
	
	_isFullScreen = FALSE;
	_hostStack = [NSMutableArray new];
	_isFullScreen = fullscreen;
		
	if (!_isFullScreen) {
		[self setFrame:CGRectMake(0, 0, 320, 480)];
	}
	else {
		//[self setAffineTransform:CGAffineTransformMakeRotation(DegreesToRadians(90))];
		//[self setFrame:CGRectMake(0, 0, 1024, 1024)]; /* landscape */
		[self setFrame:[[MXDevice currentDevice] screenSizeAsRect]];
	}
	
	return self;
}

- (void) drawInContext:(CGContextRef)context
{
	if (_isSuspended)
	{
		CGContextSetFillColorWithColor(context, WHT(0.9));
		CGContextFillRect(context, CGRectBaseOrigin(self.frame));
	}
}

- (void) setIsFullscreen:(BOOL)fs
{
	_isFullScreen = fs;
}

- (void) _removeSnapshot
{
	[_snapshotImage removeFromSuperlayer];
}

- (void) _restoreContextHosts
{
	[CATransaction begin];
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];

	for (MXLayerHost* host in _hostStack)
	{
		[host setHidden:FALSE];
	}
	[self _removeSnapshot];
	
	[CATransaction commit];
}

- (void) resumed
{
	_isSuspended = FALSE;
	
	[CATransaction begin];
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];

	[self display];
	
	/* Fixes the flash on resumption */
	[self performSelector:@selector(_restoreContextHosts)
			   withObject:nil
			   afterDelay:0.5];
	
	[CATransaction commit];
}

- (void) willSuspend
{
	_locked = TRUE;
	
	[CATransaction begin];
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
	
	/*
	 * Create a snapshot and place it in the render layer
	 * This is a part of the "fake backrounding" technique used by apple.
	 */
	CGSize sz = [[MXDevice currentDevice] screenSize];
	[_snapshotImage setFrame:CGRectMake(_contextOffset.origin.x, _contextOffset.origin.y, sz.width, sz.height)];
	[_snapshotImage setImage:[self createSnapshot]];
	[self addSublayer:_snapshotImage];
	
	[CATransaction commit];
}

- (void) suspended
{
	_isSuspended = TRUE;
	
	[CATransaction begin];
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
	for (MXLayerHost* host in _hostStack)
	{
		[host setHidden:TRUE];
	}
	[self display];
	[CATransaction commit];
}

static OSSpinLock _contextLock;

- (void) pushContext:(unsigned)context windowLevel:(float)windowLevel windowOutput:(int)windowOutput
{
	OSSpinLockLock(&_contextLock);
	
	/*
	 * If the context is not in the render tree, add.
	 * Otherwise, change the window level.
	 *
	 * XXX:
	 * This is still very fucked up.
	 * I do not now how the 'windowLevel' variable works.
	 * For some reason those levels are slightly "erratic".
	 * Until I figure it out, rendering might be a bit glitchy.
	 * Maybe this is a stack. Or a pile? No idea ...
	 */
	
	BOOL inTree = FALSE;
	MXLayerHost* treeLayer;
	int index = 0;
	for (MXLayerHost* host in _hostStack)
	{
		/*
		 * Check if the current context in the tree.
		 * Context in the tree don't have to be re-added.
		 * The have to be re-ordered.
		 * I still have no idea what "ordering" is.
		 * The window level thing is awkward.
		 */
		if ([host contextId] == context)
		{
			inTree = TRUE;
			treeLayer = host;
			break;
		}
		index ++;
	}
	
	/*  Fuck ...  */
	MXLayerHost* hostLayer;
	if (!inTree)
	{
		MSLog(@"Push: %-11u | level: %-7d | out: %-3d",context,(int)windowLevel,windowOutput);
		hostLayer = [[MXLayerHost layer] init];
		
		[hostLayer setFrame:CGRectMake(_contextOffset.origin.x, 
									   _contextOffset.origin.y, 
									   self.frame.size.width, 
									   self.frame.size.height)];
		
	
		
		[hostLayer connectToRemoteContextId:context forIdentifier:@"application"];
		[hostLayer setWindowLevel:windowLevel];
		[hostLayer retain];
		
		CFDictionarySetValue(_renderLayers, (void*)context, (void*)self);
		
		[_hostStack addObject:hostLayer];
		[self addSublayer:hostLayer];
		[self setMasksToBounds:TRUE];
	}
	else {
		if (treeLayer != NULL) {
			MSLog(@"Move: %-11u | level: %-7d | out: %-3d",context,(int)windowLevel,windowOutput);
			[treeLayer setWindowLevel:windowLevel];
		}
	}

	[CATransaction flush];
	[CATransaction synchronize];
	
	OSSpinLockUnlock(&_contextLock);
}

@end
