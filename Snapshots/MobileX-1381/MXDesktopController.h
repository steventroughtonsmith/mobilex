//
//  MXDesktopController.h
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MXDesktopLayer.h"
#import "MXWallpaperLayer.h"

#import "MXIcon.h"

@interface MXDesktopController : NSObject {
	MXDesktopLayer *_desktop;
    MXWallpaperLayer *_wallpaper;
}

- (void)setWallpaper:(MXImage *)wallpaper;
- (MXDesktopLayer *)desktopLayer;

- (void)layoutSublayers;

@end
