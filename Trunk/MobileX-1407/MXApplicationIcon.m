//
//  MXIcon.m
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXApplicationIcon.h"

@implementation MXApplicationIcon

- (id)initWithApplication:(MXApplication *)application {
	if ((self = [super init])) {
	    _icon = [application iconImage];
        _name = [application displayName];
        _isPrerendered = [application hasPrerenderedIcon];
        [self reload];
    }

	return self;
}

@end

