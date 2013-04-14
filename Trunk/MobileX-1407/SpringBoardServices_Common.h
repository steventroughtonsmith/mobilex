#ifndef _MISC_TYPES_H_
#define _MISC_TYPES_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mach/mach.h>
#include "BootstrapServices.h"

// The server port will be registered under this name.
#define MIG_SBS "com.apple.springboard.services"

typedef struct{
	float w;
	float h;
} t_cgsize;

typedef struct {
    mach_msg_header_t head;
	
    // The following fields do not represent the actual layout of the request
    // and reply messages that MIG will use. However, a request or reply
    // message will not be larger in size than the sum of the sizes of these
    // fields. We need the size to put an upper bound on the size of an
    // incoming message in a mach_msg() call.
    NDR_record_t NDR;
    union {
        unsigned context;
		float windowLevel;
		int windowOutput;
		audit_token_t token;
		t_cgsize sz;
		char reserved[10];
    } data;
    kern_return_t      RetCode;
    mach_msg_trailer_t trailer;
} msg_sbs_t;

//kern_return_t AppWillOrderInContext(mach_port_t server, unsigned context, float windowLevel, int windowOutput, audit_token_t token);
//kern_return_t AppDidOrderOutContext(mach_port_t server, unsigned context, audit_token_t token);

//kern_return_t LaunchApplicationWithIdentifier (mach_port_t server, t_str appID, int suspended, int unknown, audit_token_t token);

typedef const char* string_t;

#endif // _MISC_TYPES_H_

