//
//  MXControl.h
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXLayer.h"

@interface MXControl : MXLayer {
	NSMutableArray* _dispatchTable;
	
	BOOL _isControlDown;
	BOOL _ignoreNextTouchEnd;
}

- (void) fireActionOfType:(int)type;

- (void) addTarget:(id)target action:(SEL)action;
- (void) addTarget:(id)target action:(SEL)action eventType:(int)type;
- (void) addTarget:(id)target action:(SEL)action withObject:(id)object;
- (void) addTarget:(id)target action:(SEL)action withObject:(id)object eventType:(int)type;

- (void) addSenderTarget:(id)target action:(SEL)action;
- (void) addSenderTarget:(id)target action:(SEL)action eventType:(int)type;
- (void) addSenderTarget:(id)target action:(SEL)action withObject:(id)object;
- (void) addSenderTarget:(id)target action:(SEL)action withObject:(id)object eventType:(int)type;

- (void) handleDigitizerEventAt:(CGPoint)point ofType:(MTTouchType)type forLayer:(CALayer*)layer;
- (void) handleDigitizerEventAt:(CGPoint)point ofType:(MTTouchType)type forLayer:(CALayer*)layer atGlobalPoint:(CGPoint)globalPoint;

@end
