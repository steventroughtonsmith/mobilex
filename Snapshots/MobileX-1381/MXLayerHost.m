//
//  MXLayerHost.m
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXLayerHost.h"
#import "MXKit.h"

@implementation MXLayerHost

@synthesize windowLevel=_windowLevel;

- (void) connectToRemoteContextId:(unsigned)context forIdentifier:(NSString*)identifier
{
	_identifier = identifier;
	[self setContextId:context];
	_isConnected = TRUE;
}

- (void) setWindowLevel:(float)level
{
	_windowLevel = level;

	[self setZPosition:level];
}

- (id <CAAction>)actionForKey:(NSString *)aKey
{
	return nil;
}

- (BOOL) ignoresHitTesting
{
	return FALSE;
}

- (NSString *) description
{
	return [NSString stringWithFormat:@"<MXLayerHost (Context: %d) (Level: %f)>",[self contextId],_windowLevel];
}

@end
