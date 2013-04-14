//
//  MXCheckbox.h
//  MobileX
//
//  Created by Nick on 05/05/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXControl.h"
#import "MXText.h"

@interface MXCheckbox : MXControl {
	BOOL _isChecked;
}

@property BOOL isChecked;

@end
