//
//  MXLayer.m
//  MobileX
//
//  Created by Nick on 14/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXLayer.h"


@implementation MXLayer

- (id) init
{
	[super init];
	return self;
}

- (BOOL) shouldAnimatePropertyForKey:(NSString*)key
{
	return FALSE;
}

- (id < CAAction >)actionForKey:(NSString *)aKey
{
	//MSLog(@"%@: Animate: %@",self,aKey);
	
	if ([self shouldAnimatePropertyForKey:aKey]) {
		return [super actionForKey:aKey];
		return nil;
	}
	else {
		return nil;
	}
}

- (void) setFrame:(CGRect)frame
{
	/* Dear CoreGraphics,
	   Please shove those half-pixel coordinates up your arse.
											- Thank you.
	 */
	
	[super setFrame:CGRectMake(lroundf(frame.origin.x),
							   lroundf(frame.origin.y),
							   lroundf(frame.size.width),
							   lroundf(frame.size.height))];
}

@end
