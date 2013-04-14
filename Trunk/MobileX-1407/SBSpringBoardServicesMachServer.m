/*
 
 # SpringBoard Services Server
 # SpringBoardSupport
 
 Responsible for SB's MiG subsystem.
 
 */

#import "SBSpringBoardServicesMachServer.h"
#import "MXController.h"
#import "MXRenderLayer.h"

#import "CARenderContext.h"

#import <QuartzCore/CALayerHost.h>

#import "CPMIGServerSource.h"
#include <pthread.h>

static mach_port_t server_port;

extern boolean_t SpringBoardServices_server(mach_msg_header_t *inhdr,
                             mach_msg_header_t *outhdr);

/* ----------------------------- Setup -------------------------------- */

boolean_t _SBPerformCallout(mach_msg_header_t *inhdr,
					       mach_msg_header_t *outhdr)
{
	return SpringBoardServices_server(inhdr, outhdr);
}

void _SBStartMiGServerInternal()
{
	server_port = MXIPCStartMachServer(MIG_SBS, SpringBoardServices_server);
}

void
SBStartMiGServer()
{
	pthread_t thread;
	pthread_create(&thread,
				   NULL,
				   (void *)&_SBStartMiGServerInternal,
				   NULL);
}




/* ----------------------------- Helpers ----------------------------- */

MXApplication* MXApplicationForAuditToken(audit_token_t token)
{
	pid_t pid = -1;
	audit_token_to_au32(token, NULL, NULL, NULL, NULL, NULL, &pid, NULL, NULL);
	
	return [[MXApplicationController sharedInstance] applicationForPid:pid];
}


/* ---------------------------- Events ------------------------------- */

kern_return_t _SBXXCheckInTaskPort (mach_port_t server,int one,int two, int thr, int fr, audit_token_t token)
{
	return KERN_SUCCESS;
}

kern_return_t _SBXXRegisterRemoteView (mach_port_t server,int one,int two, audit_token_t token)
{
	return KERN_SUCCESS;
}

kern_return_t _SBXXRegisterStatusBarWindowContextId (mach_port_t server, unsigned context, audit_token_t token)
{
	return KERN_SUCCESS;
}


/* Inline memory!? No! */
kern_return_t _SBXXLaunchApplicationWithIdentifier (mach_port_t server, string_t identifier, int suspended, string_t unknown, audit_token_t token)
{
	
	printf("LaunchId(%u): Launching %s\n",server,identifier);
	return KERN_SUCCESS;
}

/* Not necessary as we force the applications to die anyway */
kern_return_t _SBXXAppDidOrderOutContext(mach_port_t server, unsigned context, audit_token_t token)
{
	MXLog(@"Order out %u",context);
	return KERN_SUCCESS;
}

/* Need that for context hosting */
kern_return_t _SBXXAppWillOrderInContext(mach_port_t server, unsigned context, float windowLevel, int windowOutput, audit_token_t token)
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	
	MXRenderManagerPushContext(context,
							   windowLevel,
							   windowOutput,
							   MXApplicationForAuditToken(token));
	[pool release];
	
	return KERN_SUCCESS;
}
