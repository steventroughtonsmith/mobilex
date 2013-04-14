//
//  MXUIStatusBarServer.m
//  MobileX
//
//  Created by Nick on 22/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXUIStatusBarServer.h"
#import "MXUIStatusBarServerCommon.h"
#import "BootstrapServices.h"
#import "CPMIGServerSource.h"
#include <pthread.h>

static mach_port_t __uiSbsServerPort = 0;

extern boolean_t MXUIStatusBar_server(mach_msg_header_t *inhdr,
								      mach_msg_header_t *outhdr);

void _MXUIStatusBarServerCopyString(const char* string, void* addr) {
	memcpy(addr,string,strlen(string));
}

kern_return_t
_MXUIXXStatusBarServer_GetStatusBarData(mach_port_t server,
										serialized_t *list,
										mach_msg_type_number_t *size,
										audit_token_t token)
{
	MXLog(@"Copied %d bytes.", sizeof(UIStatusBarData));
	
	UIStatusBarData* data = malloc(sizeof(UIStatusBarData));
	
	/* I've got no idea how, but setting everything to 2 works */
	memset(data,2,sizeof(UIStatusBarData));
	
	_MXUIStatusBarServerCopyString("MX", data->timeString);
	_MXUIStatusBarServerCopyString("MobileX", data->serviceString);

	data->batteryCapacity = 50;
	data->displayRawGSMSignal = 1;
	data->displayRawWifiSignal = 1;
	data->gsmSignalStrengthRaw = 0;
	data->gsmSignalStrengthRaw = 0;
	
	*list = data;
	*size = sizeof(UIStatusBarData);
	
	return KERN_SUCCESS;
}

void _MXUISBSStartInternal(void* ptr)
{
	__uiSbsServerPort = MXIPCStartMachServer(MIG_UISBS, MXUIStatusBar_server);
}

void
MXUISBSStart()
{
	pthread_t thread;
	pthread_create(&thread,
				   NULL,
				   (void *)&_MXUISBSStartInternal,
				   NULL);
}