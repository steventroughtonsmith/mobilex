//
//  MXImage.h
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MXImage : NSObject {
	CGImageRef _cgImage;
}

@property CGImageRef cgImage;

+ (id) imageNamed:(NSString*)name;

- (id) initWithCGImage:(CGImageRef)image;

- (void) loadImageAtPath:(NSString *)path;
- (void) loadImageWithName:(NSString*)name;
- (void) loadImageAtAbsoulutePath:(NSString *)path;

- (void) writeToFile:(NSString*)file
		  atomically:(BOOL)atomically;

@end
