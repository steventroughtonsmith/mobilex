//
//  CALayer+MX.h
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CALayer (MX)

- (BOOL) wantsToRespondToEventOfType:(MTTouchType)type;
- (void) layerInHitTestTreeWithTopLayer:(CALayer*)layer;
- (BOOL) overtakeAsFirstResponderFrom:(CALayer*)oldResponder
						   atLocation:(CGPoint)location
							  forType:(MTTouchType)type;

- (id) initWithFrame:(CGRect)f;
- (void) cancelTouchDown;
- (void) addContents;

- (void) displayWithoutAnimation;

@end

@interface CALayer (MXVolatileEvents)

- (void) handleDigitizerEventAt:(CGPoint)point ofType:(MTTouchType)type forLayer:(CALayer*)layer;
- (void) handleDigitizerEventAt:(CGPoint)point ofType:(MTTouchType)type forLayer:(CALayer*)layer atGlobalPoint:(CGPoint)point;
- (void) fireActionOfType:(int)type;

@end