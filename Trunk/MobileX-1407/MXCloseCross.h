/*
 
 Rendered close cross used for different purposes.
 
 */

#import <Foundation/Foundation.h>
#import <QuartzCore/CAFilter.h>
#import "MXKit.h"

#define CROSS_SHADOW_INSET 5

@interface MXCloseCross : MXControl {
	id _obj;
	
	CAFilter* _darkFilter;
}

@property (assign) id obj;

@end
