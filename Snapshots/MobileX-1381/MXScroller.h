//
//  MXScroller.h
//  WaterFountain
//
//  Created by Nick on 07/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	kMXScrollLayerIndicatorStyleDefault = 0,
	kMXScrollLayerIndicatorStyleBlack,
	kMXScrollLayerIndicatorStyleWhite,
	kMXScrollLayerIndicatorStyleNone
} MXScrollLayerIndicatorStyle;

@interface MXScroller : CALayer {
	MXScrollLayerIndicatorStyle _style;
	CGRect _oldFrame;
	CGRect _maxFrame;
}

@property (assign,nonatomic) MXScrollLayerIndicatorStyle scrollerStyle;
@property (assign,nonatomic) CGRect maxFrame;

@end
