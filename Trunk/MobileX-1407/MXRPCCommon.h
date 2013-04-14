/*
 * MobileX RPC
 * Common
 */
 

#ifndef _MISC_TYPES_MX_H_
#define _MISC_TYPES_MX_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mach/mach.h>
#include "BootstrapServices.h"

/* server port */
#define MIG_MXRPC "com.mx.mx.rpcserver"

typedef enum __MXRPCSelector {
	kMXRPCHideAllActiveWindows = 1,
	kMXRPCShowAllActiveWindows = 2,
	kMXRPCStartExpose = 3,
	kMXRPCStopExpose = 4,
	kMXRPCEnableExpose = 5,
	kMXRPCDisableExpose = 6
} MXRPCSelector;

typedef const char* string_t;
typedef char* serialized_t;

#endif // _MISC_TYPES_H_

