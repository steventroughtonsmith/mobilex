//
//  MXIcon.h
//  MobileX
//
//  Created by Nick on 23/04/1980.
//  Copyright 1980 MxWmSrvApp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MXIcon.h"
#import "MXApplication.h"

@interface MXApplicationIcon : MXIcon {
    MXApplication *_application;
}

- (id)initWithApplication:(MXApplication *)application;

@end
