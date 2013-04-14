//
//  MXScreenCapture.h
//  MobileX
//
//  Created by Nick on 14/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MXImage.h"

CFDictionaryRef MXSurfaceDictionaryForRect(CGRect frame);

/* screenshots */
MXImage* MXGetScreenImage();
MXImage* MXImageForContext(unsigned context, CGRect frame);
MXImage* MXImageForContextList(unsigned* contexts, int count,CGRect frame);