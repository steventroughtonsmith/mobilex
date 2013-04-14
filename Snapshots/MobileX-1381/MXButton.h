//
//  MXButton.h
//  MobileX
//
//  Created by Nick on 24/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXControl.h"
#import "MXText.h"

@interface MXButton : MXControl {
	MXText* _caption;
	
	BOOL _isDown;
}

@property (retain) NSString* text;

@end
