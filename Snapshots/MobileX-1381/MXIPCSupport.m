//
//  MXServerStarter.m
//  MobileX
//
//  Created by Nick on 09/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MXIPCSupport.h"

mach_port_t
MXIPCStartMachServer(const char* identifier, void* entryPoint)
{
	kern_return_t kr;
	mach_port_t port;
	
	if ((kr = bootstrap_check_in(bootstrap_port, identifier,
								 &port)) != BOOTSTRAP_SUCCESS) {
		mach_port_deallocate(mach_task_self(), port);
		printf("\nCannot register %s with the bootstrap server.\nThis generally means that:\n",identifier);
		printf("   1: The process is already running\n");
		printf("   2: Not enough rights (try running as root)\n");
		printf("   3: Something else is using this port (SpringBoard?)\n");
		mach_error("bootstrap_check_in:", kr);
		exit(1);
	}
	
	mach_port_limits_t qlimits;
    qlimits.mpl_qlimit = 16;
	mach_port_set_attributes(mach_task_self(),
							 port,
							 MACH_PORT_LIMITS_INFO,
							 (mach_port_info_t)&qlimits,
							 MACH_PORT_LIMITS_INFO_COUNT);
	
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	printf("Starting '%s' server on (mach_port:%u) ...\n",identifier,port);
	
	/* fuck everything about this */
	CFRunLoopSourceRef source = CPCreateMIGServerSource(entryPoint,
														port,
														0);
	
	CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
	
	CFRunLoopRun();
	
	[pool release];
	
	return port;
}