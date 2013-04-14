//
//  MXScrollLayer.h
//  MobileX
//
//  Created by Nick on 25/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXControl.h"
#import "MXScroller.h"
#import "MXBoundScrollLayer.h"

/* internal structure used to denote a plotted movement point */
typedef struct __MXInertiaPoint {
	CGPoint point;
	float distanceX;
	float distanceY;
	float diffX;
	float diffY;
	long int timeDiff;
	long int ts;
} MXInertiaPoint;

/* internal structure used to denote a layer page */
typedef struct __MXScrollLayerPage {
	int number;
	float begin;
	float end;
} _MXScrollLayerPage;

@interface MXScrollLayer : MXControl {
	CGPoint _originalTouchDownPos;
	CGSize _contentSize;
	CGPoint _scrollPoint;
	CGPoint _originalScrollPoint;
	MXBoundScrollLayer* _scrollLayer;
    CALayer *_rootLayer;
	
	BOOL _isScrolling;
	BOOL _scrollHorizontally;
	BOOL _scrollVertically;
	
	BOOL _pagingEnabled;
	
	float _xScale;
	float _yScale;
	float _scaledWidth;
	float _scaledHeight;
	
	MXScroller* _horizontalScroller;
	MXScroller* _verticalScroller;
	
	MXScrollLayerIndicatorStyle _indicatorStyle;
	
	int _inertia;
	long int _beginTime;
	
	/* Handling Inertia */
	long int _lastTimeStamp;
	long int _totalTimeForPoints;
	CGPoint _lastInertiaPoint;
	int _inertiaPointsCount;
	MXInertiaPoint* _points;
	
	/* delegate */
	id _delegate;
	int _animationCount;
	
	BOOL _requiresLayout;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, assign) BOOL pagingEnabled;

@property (nonatomic, assign) BOOL scrollHorizontally;
@property (nonatomic, assign) BOOL scrollVertically;

@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, assign) CGPoint contentOffset;

@property (nonatomic,assign) MXScrollLayerIndicatorStyle indicatorStyle;


- (int) numberOfHorizontalPages;

- (void) setShowScrollers:(BOOL)show;
- (void) setContentOffset:(CGPoint)pt
				 animated:(BOOL)animated;

@end


/* delegate interface */
@interface NSObject (MXScrollLayerDelegate)

- (void)scrollLayerDidEndScrollingAnimation:(MXScrollLayer*)scrollLayer;
- (void)scrollLayerWillBeginDragging:(MXScrollLayer*)scrollLayer;
- (void)scrollLayerWillEndDragging:(MXScrollLayer*)scrollLayer;
- (void)scrollLayerDidScroll:(MXScrollLayer*)scrollLayer;

@end


