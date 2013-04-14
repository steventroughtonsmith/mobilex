//
//  MXWindow.h
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXKit.h"
#import "MXPane.h"
#import "MXWindowButton.h"

#define INSETSIZE 0.0f
#define TOPHEIGHT 38.0f
#define BTNWIDTH 50.0f
#define BTNHTOFFSET 1.0f
#define SHADOW_INSET 15.0f

typedef enum {
	kMXWindowClose = 4,
	kMXWindowActivate = 5
} MXWindowActions;

typedef enum {
	kMXWindowStyleNormal = 1,
	kMXWindowStyleBorderless = 2
} MXWindowBorderStyles;

typedef struct __MXWindowBorder {
	CGFloat top;
	CGFloat bottom;
	CGFloat right;
	CGFloat left;
} MXWindowBorder;

@interface MXWindow : MXPane {
	MXText* _text;
	CGPoint _touchDownPoint;
	CGPoint _touchDownOrigin;
	
	/* Window Metrics */
	MXWindowBorderStyles _borderStyle;
	MXWindowBorder _windowBorder;
	CGRect _contentRect;
	CGRect _titleBarRect;
	
	id _hostedLayer;
	
	BOOL _pendingLayerLayout;
	BOOL _isMovable;
	BOOL _hasAddedControls;
	
	MXWindowButton* _closeButton;
	
}

@property (assign) MXWindowBorderStyles borderStyle;
@property (assign) NSString* text;

- (id) initWithLayer:(id)layer atPosition:(CGPoint)pos;
- (id) initWithHostedLayer:(id)layer;

+ (id) windowForLayer:(id)layer;

- (void) hostLayer:(id)layer;
- (void) setText:(NSString*)text;

@end
