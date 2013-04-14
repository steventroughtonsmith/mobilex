//
//  MXServerStarter.h
//  MobileX
//
//  Created by Nick on 09/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <bsm/audit.h>
#import <mach/mach_port.h>
#import <mach/mach.h>

#import "CPMIGServerSource.h"
#import "BootstrapServices.h"

#import "libbsm.h"

mach_port_t
MXIPCStartMachServer(const char* identifier, void* entryPoint);