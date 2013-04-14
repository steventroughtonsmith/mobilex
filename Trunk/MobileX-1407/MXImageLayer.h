//
//  MXImageLayer.h
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXImage.h"
#import "MXLayer.h"

@interface MXImageLayer : MXLayer {
	MXImage* _image;
	BOOL _hasImage;
	BOOL _tiled;
	BOOL _centered;
	BOOL _zeroPoint;
}

@property BOOL tiled;
@property BOOL centered;
@property BOOL zeroPoint;

@property (retain) MXImage* image;

+ (id) imageLayerWithImage:(MXImage*)im;

- (MXImage*) image;
- (void) setImage:(MXImage*)im;

@end
