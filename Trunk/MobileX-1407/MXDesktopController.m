//
//  MXDesktopController.m
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import "MXDesktopController.h"
#import "MXCG.h"

@implementation MXDesktopController

- (id)init {
	if ((self = [super init])) {
	    _desktop = [[MXDesktopLayer alloc] initWithFrame:CGRectZero];

        _wallpaper = [[MXWallpaperLayer alloc] initWithFrame:[_desktop bounds]];
		
	    [_wallpaper setTiled:TRUE];
        [_desktop addSublayer:_wallpaper];
	}

	return self;
}

- (void)layoutSublayers {
    [_wallpaper setFrame:[_desktop bounds]];
}

- (MXDesktopLayer *)desktopLayer {
    return _desktop;
}

- (void)setWallpaper:(MXImage *)wallpaper {
    [_wallpaper setImage:wallpaper];
    [_wallpaper setNeedsDisplay];
}

- (void)dealloc {
    [_desktop release];
    [_wallpaper release];
    [super dealloc];
}

@end
