//
//  MXIcon.h
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MXKit.h"
#import "MXIconImage.h"
#import <QuartzCore/CAFilter.h>

@interface MXIcon : MXControl {
    NSString *_name;
    MXImage *_icon;
    BOOL _isPrerendered;

	MXIconImage *_iconImage;
	MXText *_nameText;
	
	CAFilter *_darkFilter;
}

+ (CGSize)defaultIconSize;
- (void)setOrigin:(CGPoint)origin;

- (void)reload;

@end
