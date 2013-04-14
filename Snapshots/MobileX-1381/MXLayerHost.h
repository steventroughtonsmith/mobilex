//
//  MXLayerHost.h
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/CALayerHost.h>

@interface MXLayerHost  : CALayerHost {
	NSString* _identifier;
	float _windowLevel;
	BOOL _isConnected;
}

@property(assign, nonatomic) float windowLevel;

- (void) connectToRemoteContextId:(unsigned)context forIdentifier:(NSString*)identifier;

@end
