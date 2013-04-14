//
//  MXBasicAnimation.h
//  MobileX
//
//  Created by Nick on 12/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MXBasicAnimation : CABasicAnimation {
	NSString* _tag;
}

@property (nonatomic, retain) NSString* tag;

@end
