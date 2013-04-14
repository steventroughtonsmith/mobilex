//
//  MXScrollLayer.m
//  MobileX
//
//  Created by Nick on 25/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXScrollLayer.h"
#import "MXCG.h"
#import "MXColors.h"
#import "MXBasicAnimation.h"
#include <sys/time.h>

#define BOUNCEDURATION 0
#define SCROLL_DURATION 0.3

unsigned long MXTimestamp()
{
	struct timeval tv;
	gettimeofday(&tv,NULL);
	return 1000000 * tv.tv_sec + tv.tv_usec; // seconds
}

@implementation MXScrollLayer

@synthesize scrollVertically=_scrollVertically;
@synthesize scrollHorizontally=_scrollHorizontally;
@synthesize indicatorStyle=_indicatorStyle;
@synthesize pagingEnabled=_pagingEnabled;
@synthesize delegate=_delegate;

/* delegate calls */
- (void) _callDelegateSelector:(SEL)selector
{
	//NSLog(@"%@ calling out to %@",self,NSStringFromSelector(selector));
	if (_delegate != nil)
	{
		if ([_delegate respondsToSelector:selector])
		{
			[_delegate performSelector:selector
							withObject:self];
		}
	}
}

/* animation count + */
- (void) _raiseAnimationCount
{
	_animationCount += 1;
}

/* animation count - */
- (void) _reduceAnimationCount
{
	_animationCount -= 1;
	if (_animationCount == 0)
	{
		[self setShowScrollers:FALSE];
		[self _callDelegateSelector:@selector(scrollLayerDidEndScrollingAnimation:)];
	}
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		_requiresLayout = TRUE;
		
        _rootLayer = [[CALayer alloc] init];
	    _scrollLayer = [[MXBoundScrollLayer alloc] init];
		
        _contentSize = CGSizeMake(0, 0);
        _scrollPoint = CGPointMake(0, 0);
        _originalScrollPoint = _scrollPoint;
		
		_horizontalScroller = [[MXScroller alloc] init];
		_verticalScroller = [[MXScroller alloc] init];
		
		[_scrollLayer removeAllAnimations];
		
		[_rootLayer retain];
		[_horizontalScroller retain];
		[_verticalScroller retain];
		[_scrollLayer retain];
		
		[_horizontalScroller setHidden:TRUE];
		[_verticalScroller setHidden:TRUE];
		
		/*
		 Am I doing this right?
		 */
		_points = malloc(sizeof(_points[0])*1024);
		
		[self setMasksToBounds:TRUE];
		
		[self setShowScrollers:FALSE];
    }

	return self;
}

- (void) setScrollVertically:(BOOL)b
{
	[_verticalScroller setHidden:!b];
	_scrollVertically = b;
}

- (void) setScrollHorizontally:(BOOL)b
{
	[_horizontalScroller setHidden:!b];
	_scrollHorizontally = b;
}

- (void) setIndicatorStyle:(MXScrollLayerIndicatorStyle)style
{
	_indicatorStyle = style;
	[_horizontalScroller setScrollerStyle:style];
	[_verticalScroller setScrollerStyle:style];
}

- (void)addContents {
	[_rootLayer setFrame:CGRectBaseOrigin(self.frame)];
	
	/* grrr, setBounds is annoying but required for animation */
    [_scrollLayer setBounds:CGRectBaseOrigin(self.frame)];
	[_scrollLayer setAnchorPoint:CGPointZero];

	[_horizontalScroller setAnchorPoint:CGPointZero];
	[_verticalScroller setAnchorPoint:CGPointZero];
	
	[super addSublayer:_scrollLayer];
	
	[super addSublayer:_horizontalScroller];
	[super addSublayer:_verticalScroller];
	
    [_scrollLayer addSublayer:_rootLayer];
}

- (CGSize)contentSize {
    return _contentSize;
}

- (CGPoint)contentOffset {
    return _scrollPoint;
}

- (void)setContentSize:(CGSize)size {
	if (size.height == 0 || size.width == 0)
		return;
	
	if (size.height < self.frame.size.height)
		size.height = self.frame.size.height;
	
	if (size.width < self.frame.size.width)
		size.width = self.frame.size.width;
	
	_contentSize = size;

    CGRect frame;
    frame.size = size;
    frame.origin = CGPointZero;
    [_rootLayer setFrame:frame];
	
	/* [_overlay setXRect:CGRectMake(bounds.size.width - 7, _scrollPoint.y / _yScale, 5, _scaledHeight)
			  andYRect:CGRectMake(, , , 5)]; */
	
	_xScale = (_contentSize.width / self.frame.size.width);
	_yScale = (_contentSize.height / self.frame.size.height);
	
	_scaledWidth = self.frame.size.width / _xScale;
	_scaledHeight = self.frame.size.height / _yScale;
	
	[_verticalScroller setMaxFrame:CGRectMake(0, 0, _scaledWidth, _scaledHeight)];
	[_horizontalScroller setMaxFrame:CGRectMake(0, 0, _scaledWidth, _scaledHeight)];
	
	[_verticalScroller setFrame:CGRectMake(self.frame.size.width - 8, 0, 7, _scaledHeight)];
	[_verticalScroller setBounds:CGRectMake(0, 0, 6, _scaledHeight)];
	[_verticalScroller setNeedsDisplay];
	
	[_horizontalScroller setFrame:CGRectMake(0, self.frame.size.height - 8, _scaledWidth, 7)];
	[_horizontalScroller setBounds:CGRectMake(0, 0, _scaledWidth, 6)];
	[_horizontalScroller setNeedsDisplay];
	
	[_scrollLayer setNeedsDisplay];
}

- (BOOL) wantsToRespondToEventOfType:(MTTouchType)type
{
	return TRUE;
}

- (BOOL) overtakeAsFirstResponderFrom:(CALayer *)oldResponder atLocation:(CGPoint)location forType:(MTTouchType)type
{
	if (type == kMXTMoved) {
		/* hello! */
		[oldResponder cancelTouchDown];
		return TRUE;
	}
	else {
		return FALSE;
	}	
}


- (void)setContentOffset:(CGPoint)pt
{
	[CATransaction begin];
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];

	_verticalScroller.position = CGPointMake(_verticalScroller.position.x, (pt.y / _yScale));
	_horizontalScroller.position = CGPointMake((pt.x / _xScale), _horizontalScroller.position.y);
	[_scrollLayer scrollToPoint:pt];

	[CATransaction commit];
}

- (void) setShowScrollers:(BOOL)show
{
	if (show)
	{
		[_horizontalScroller setOpacity:1];
		[_verticalScroller setOpacity:1];
	}
	else
	{
		[_horizontalScroller setOpacity:0];
		[_verticalScroller setOpacity:0];
	}
}

- (void)addSublayer:(CALayer *)layer {
	[_rootLayer addSublayer:layer];
}

- (void) _inertiaAnimationForKey:(NSString*)key
									fromValue:(float)fromValue
									  toValue:(float)toValue
									 duration:(float)duration
								needsDelegate:(BOOL)needsDelegate
{
	MXBasicAnimation *theAnimation;
	
	theAnimation=[MXBasicAnimation animationWithKeyPath:key];
	theAnimation.duration=duration;
	theAnimation.autoreverses = FALSE;
	theAnimation.removedOnCompletion = TRUE;
	theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	theAnimation.fromValue=[NSNumber numberWithFloat:fromValue];
	theAnimation.toValue=[NSNumber numberWithFloat:toValue];
	theAnimation.tag = @"scrollLayerAnimation";
	
	MXBasicAnimation* scrollerAnimation = [theAnimation copy];
	
	if (needsDelegate) {
		[self _raiseAnimationCount];
		theAnimation.delegate = self;
	}
	
	[_scrollLayer addAnimation:theAnimation forKey:[key stringByAppendingString:@"-Animation"]];
	scrollerAnimation.tag = @"scrollerAnimation";
	
	if ([key isEqualToString:@"position.x"])
	{
		scrollerAnimation.fromValue = [NSNumber numberWithFloat:(fromValue / _xScale)*-1];
		scrollerAnimation.toValue = [NSNumber numberWithFloat:(toValue / _xScale)*-1];
		[_horizontalScroller addAnimation:scrollerAnimation forKey:[key stringByAppendingString:@"-Animation"]];
	}
	else if ([key isEqualToString:@"position.y"])
	{
		scrollerAnimation.fromValue = [NSNumber numberWithFloat:(fromValue / _yScale)*-1];
		scrollerAnimation.toValue = [NSNumber numberWithFloat:(toValue / _yScale)*-1];
		[_verticalScroller addAnimation:scrollerAnimation forKey:[key stringByAppendingString:@"-Animation"]];
	}
	 
}

- (void) _inertiaAnimationForKey:(NSString*)key
									fromValue:(float)fromValue
									  toValue:(float)toValue
{
	[self _inertiaAnimationForKey:key fromValue:fromValue toValue:toValue duration:SCROLL_DURATION needsDelegate:TRUE];
}

- (void)setContentOffset:(CGPoint)pt
				animated:(BOOL)animated
{
	CGPoint newScrollPoint = pt;
	
	[CATransaction begin];
	[CATransaction setValue: (id) (animated ? kCFBooleanFalse : kCFBooleanTrue) forKey: kCATransactionDisableActions];

	_scrollPoint = newScrollPoint;
	_originalScrollPoint = _scrollPoint;
	
	_scrollLayer.position = CGPointMake((_scrollPoint.x)*-1,(_scrollPoint.y)*-1);
	_verticalScroller.position = CGPointMake(_verticalScroller.position.x, (_scrollPoint.y / _yScale));
	_horizontalScroller.position = CGPointMake((_scrollPoint.x / _xScale), _horizontalScroller.position.y);
	
	[CATransaction commit];
}

- (void)animationDidStop:(CAAnimation *)an finished:(BOOL)flag
{
	float retx = 0;
	float rety = 0;
	
	BOOL sretx = 0;
	BOOL srety = 0;
	
	[self _reduceAnimationCount];
	
	MXBasicAnimation* theAnimation = (MXBasicAnimation*)an;
	
	if ([theAnimation.tag isEqualToString:@"scrollLayerAnimation"] || TRUE) {
		if ([[(CABasicAnimation*)theAnimation keyPath] isEqualToString:@"position.y"]) {
			/* bounce if needed */
			if (_scrollPoint.y < 0) {
				/* y axis needs to bounce */
#ifdef DEBUG_INERTIA
				printf("  * Bounce: Y \n");
#endif

				_scrollPoint.y = rety;
				srety = TRUE;
				
			}
			if (_scrollPoint.y/_yScale +_scaledHeight > self.frame.size.height) {
				/* y axis needs to bounce */
#ifdef DEBUG_INERTIA
				printf("  * Bounce: Y-Height \n");
#endif
				rety = (self.frame.size.height-_scaledHeight)*_yScale;

				_scrollPoint.y = rety;
				srety = TRUE;
			}
		} 
		else {

			if (_scrollPoint.x < 0) {
				/* x axis needs to bounce */
#ifdef DEBUG_INERTIA
				printf("  * Bounce: X \n");
#endif
				retx = 0;
				sretx = TRUE;
				_scrollPoint.x = retx;
				
			}
			if (_scrollPoint.x/_xScale +_scaledWidth > self.frame.size.width) {
				/* x axis needs to bounce */
#ifdef DEBUG_INERTIA
				printf("  * Bounce: X-Width \n");
#endif
				retx = (self.frame.size.width-_scaledWidth)*_xScale;
				sretx = TRUE;
				_scrollPoint.x = retx;

			}
		}
		
		if (sretx || srety)  {
			[CATransaction begin];
			
			//[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
			/* animate */
			if (srety)
				[self _inertiaAnimationForKey:@"position.y"
									fromValue:_scrollPoint.y*-1
									  toValue:rety*-1
									 duration:BOUNCEDURATION
								needsDelegate:TRUE];
			
			if (sretx)
				[self _inertiaAnimationForKey:@"position.x"
									fromValue:_scrollPoint.x*-1
									  toValue:retx*-1
									 duration:BOUNCEDURATION
								needsDelegate:TRUE];
			
			_scrollLayer.position = CGPointMake((_scrollPoint.x)*-1,(_scrollPoint.y)*-1);
			_originalScrollPoint = _scrollPoint;
			_verticalScroller.position = CGPointMake(_verticalScroller.position.x, (_scrollPoint.y / _yScale));
			_horizontalScroller.position = CGPointMake((_scrollPoint.x / _xScale), _horizontalScroller.position.y);
			
			[CATransaction commit];
		}
	}
	else if ([theAnimation.tag isEqualToString:@"scrollerAnimation"]) {
		
	}
	
	[self _callDelegateSelector:@selector(scrollLayerDidScroll:)];
}

- (int) numberOfHorizontalPages
{
	return _contentSize.width / self.frame.size.width;
}

- (void) _animateInertia
{
	/*
	 I was never good at maths ...
	 */
	
	float dx = _points[_inertiaPointsCount-1].diffX;
	float dy = _points[_inertiaPointsCount-1].diffY;
	
	float de = (10-_inertiaPointsCount)*30;
	
	if (10 > _inertiaPointsCount && FALSE)
	{
		/* additional acceleration for short but fast scrolls */
		if (_scrollHorizontally) {
			if (dx < 0)
				dx -= de;
			else
				dx += de;
		}
		
		if (_scrollVertically) {
			if (dy < 0)
				dy -= de;
			else
				dy += de;
		}
	}
	
	/* the value we divide by specifies the inertia factor */
	float inertiaDiffereceY = dy*(dy/10);
	float inertiaDiffereceX = dx*(dx/10);
	
	/* restore the signs */
	if (dx < 0)
		inertiaDiffereceX *= -1;
	if (dy < 0)
		inertiaDiffereceY *= -1;
	
	CGPoint newScrollPoint = CGPointMake(_scrollPoint.x+inertiaDiffereceX, _scrollPoint.y+inertiaDiffereceY);
	CGPoint oldScrollPoint = _scrollPoint;
	
	/*
	 This is the bit responsible for paging.
	 Didn't really bother with Y paging.
	 */
	if (_pagingEnabled)
	{
		if (_scrollVertically && _scrollHorizontally)
		{
			NSLog(@" *** %@ paging cannot be enabled for a two way scroller.",self);
		}
		else if (_scrollHorizontally)
		{
			/* make sure it is a whole number */
			if ([self numberOfHorizontalPages] == _contentSize.width / self.frame.size.width)
			{
				/* work out how far we got */
				
				float realX = newScrollPoint.x+(self.frame.size.width/2);
				
#ifdef DEBUG_INERTIA
				printf("\n");
				NSLog(@"horiz pages: %d",[self numberOfHorizontalPages]);
				NSLog(@"hscroll to:  %f",newScrollPoint.x);
				NSLog(@"hrscroll to: %f",realX);
#endif
				
				/* probe for page */
				_MXScrollLayerPage targetPage;
				_MXScrollLayerPage nextPage;
				_MXScrollLayerPage previousPage;
				BOOL hitTarget = FALSE;
				BOOL hasNext = FALSE;
				BOOL hasPrevious = FALSE;
				
				for (int i = 0;
					 i < [self numberOfHorizontalPages];
					 i++)
				{
					_MXScrollLayerPage page;
					page.number = i;
					page.begin = i*self.frame.size.width;
					page.end = self.frame.size.width+page.begin;
					//NSLog(@"  > pg: %d begin: %f end: %f",page.number,page.begin,page.end);
					
					if (realX > page.begin &&
						realX < page.end)
					{
						//NSLog(@"    > pg: %d passed hit test",page.number);
						targetPage = page;
						hitTarget = TRUE;
						hasPrevious = TRUE;
					}
					else if (hitTarget && !hasNext)
					{
						//NSLog(@"    > pg: %d is the next page",page.number);
						hasNext = TRUE;
						nextPage = page;
					}
					else if (!hasPrevious)
					{
						previousPage = page;
					}
				}
				
				_MXScrollLayerPage newPage;
				
				/* only jump if there is something to jump to */
				if (hasNext || hasPrevious)
				{
					BOOL next;
					BOOL needsScroll;
					
					if (dx > 0)
					{
						next = TRUE;
						newPage = nextPage;
					}
					else if (dx < 0)
					{
						next = FALSE;
						newPage = previousPage;
					}
					
					if (next && hasNext) {
						needsScroll = TRUE;
					} 
					else if (!next && hasPrevious){
						needsScroll = TRUE;
					}
					else {
						needsScroll = FALSE;
						
					}

					if (needsScroll)
					{
						/* bounce to the next/previous page */
						newScrollPoint.x = newPage.begin;
					}
					else 
					{
						/* bounce back to the current page */
						newScrollPoint.x = targetPage.begin;
					}

				}
			}
			else 
			{
				NSLog(@" *** %@ number of pages isn't a whole number (%f).",self,_contentSize.width / self.frame.size.width);
			}
		}
		else if (_scrollVertically) 
		{
			NSLog(@" *** %@ paging cannot be enabled for a verical scroller.",self);
		}
		else 
		{
			NSLog(@" *** %@ paging cannot be enabled for a non-scrollable layer.",self);
		}

	}
	
	_scrollPoint = newScrollPoint;
	
	_scrollLayer.position = CGPointMake((_scrollPoint.x)*-1,(_scrollPoint.y)*-1);
	_verticalScroller.position = CGPointMake(_verticalScroller.position.x, (_scrollPoint.y / _yScale));
	_horizontalScroller.position = CGPointMake((_scrollPoint.x / _xScale), _horizontalScroller.position.y);
	
	[self _inertiaAnimationForKey:@"position.y"
						fromValue:oldScrollPoint.y*-1
						  toValue:(newScrollPoint.y)*-1];
	
	[self _inertiaAnimationForKey:@"position.x"
						fromValue:oldScrollPoint.x*-1
						  toValue:(newScrollPoint.x)*-1];


	
#ifdef DEBUG_INERTIA
	printf("\nMXScrollLayer: Commencing inertia animation sequence\n");
	printf("  * ScrollPoint x:%f y:%f \n",_scrollPoint.x,_scrollPoint.y);
	printf("  * Difference  x:%f y:%f \n",inertiaDiffereceX,inertiaDiffereceY);
#endif

}

- (void) handleDigitizerEventAt:(CGPoint)point ofType:(MTTouchType)type forLayer:(CALayer*)layer atGlobalPoint:(CGPoint)globalPoint
{	
	float scrollX = 0;
	float scrollY = 0;

	if (_scrollVertically)
		scrollY = (_originalTouchDownPos.y - point.y);
	if (_scrollHorizontally)
		scrollX = (_originalTouchDownPos.x - point.x);
	
	if (type == kMXTBegin)
	{		
		[self _callDelegateSelector:@selector(scrollLayerWillBeginDragging:)];
		
		//NSLog(@"ScrollLayer: Begin scroll from %@",NSStringFromCGPoint(point));
		_originalTouchDownPos = point;
		
		_inertiaPointsCount = 0;
		_totalTimeForPoints = 0;
		_lastTimeStamp = MXTimestamp();
		
		_isScrolling = TRUE;
	}
	
	if (type == kMXTMoved && _isScrolling)
	{		
		[self setShowScrollers:TRUE];
		
		_scrollPoint = CGPointMake(_originalScrollPoint.x + scrollX, _originalScrollPoint.y + scrollY);
		
		if (FALSE) {
			/* bounds guard : x---> */
			if (_scrollPoint.x/_xScale +_scaledWidth > self.frame.size.width)
			{
				_scrollPoint.x = (self.frame.size.width-_scaledWidth)*_xScale;
			}
			
			/* bounds guard : <---x */
			if (_scrollPoint.x < 0)
			{
				_scrollPoint.x = 0;
			}
			
			/* bounds guard : x(down) */
			if (_scrollPoint.y/_yScale +_scaledHeight > self.frame.size.height)
			{
				_scrollPoint.y = (self.frame.size.height-_scaledHeight)*_yScale;
			}
			
			/* bounds guard : y(up) */
			if (_scrollPoint.y < 0)
			{
				_scrollPoint.y = 0;
			}
		}

		long int ts = MXTimestamp();
		
		_totalTimeForPoints += ts-_lastTimeStamp;
		_lastInertiaPoint = _scrollPoint;
		
		if (_inertiaPointsCount != 0)
		{
			int lastPts = _inertiaPointsCount-1;
			
			if (_scrollHorizontally) {
				_points[_inertiaPointsCount].distanceX = scrollX;
				_points[_inertiaPointsCount].diffX = scrollX - _points[lastPts].distanceX;
			}
			
			if (_scrollVertically) {
				_points[_inertiaPointsCount].distanceY = scrollY;
				_points[_inertiaPointsCount].diffY = scrollY - _points[lastPts].distanceY;
			}
			
			_points[_inertiaPointsCount].ts = ts;
			_points[_inertiaPointsCount].timeDiff = ts-_points[lastPts].ts;
		}
		else 
		{
			_points[_inertiaPointsCount].distanceX = scrollX;
			_points[_inertiaPointsCount].distanceY = scrollY;
			_points[_inertiaPointsCount].ts = ts;
		}
		
		_lastTimeStamp = ts;
		_inertiaPointsCount += 1;
		
		
		
		[CATransaction begin]; 
		[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
		
		/* update scrollers */
        
		[self setContentOffset:_scrollPoint];
		[self _callDelegateSelector:@selector(scrollLayerDidScroll:)];
		
		[CATransaction commit];
	}
	
	if ((type == kMXTEnd || type == kMXTMovedOut) && _isScrolling)
	{
		[self _callDelegateSelector:@selector(scrollLayerWillEndDragging:)];
		
		if (_inertiaPointsCount != 0)
		{
			[self _animateInertia];
		
#ifdef DEBUG_INERTIA
		
			 printf("\n\nPoints: \n");
			 for (int i = 0; i < _inertiaPointsCount; i++)
			 {
				 printf(" * Point: %d\n",i);
				 printf("    * Dist: {%f,%f}\n",_points[i].distanceX,_points[i].distanceY);
				 printf("    * Diff: {%f,%f}\n",_points[i].diffX,_points[i].diffY);
				 printf("    * TimeDiff: {%ld}\n",_points[i].timeDiff);
				
			 }
#endif
		}
		
		_isScrolling = FALSE;
		_originalScrollPoint = _scrollPoint;
	}
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
	
	if (_requiresLayout)
		[self addContents];
	
	_requiresLayout = FALSE;
}

- (void)dealloc {
	[super dealloc];
	free(_points);
	[_horizontalScroller release];
	[_verticalScroller release];
    [_scrollLayer release];
    [_rootLayer release];
    [super release];
}

@end
