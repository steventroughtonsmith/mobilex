/*
 
 # MXRemoteProcedureCalls
 # RPC
 
 MobileX RPC support.
 
 */

#import "MXRemoteProcedureCalls.h"
#import "MXApplicationController.h"
#import "MXController.h"
#import "MobileXRPC.h"
#include <pthread.h>

#import "MXIPCSupport.h"

static mach_port_t __rpcServerPort = 0;

extern boolean_t MobileXRPC_server(mach_msg_header_t *inhdr,
								   mach_msg_header_t *outhdr);

pid_t MXPidForAuditToken(audit_token_t token)
{
	pid_t pid = -1;
	audit_token_to_au32(token, NULL, NULL, NULL, NULL, NULL, &pid, NULL, NULL);
	return pid;
}

kern_return_t _MXRPCCall_CallMethod(mach_port_t server,
									integer_t selector,
									audit_token_t token)
{
	MSLog(@"RPC Call for selector: %d",selector);
	
	if (selector == 'EXPS') {
		[[MXPaneManager shared] toggleExpose];
	}

	
	return KERN_SUCCESS;
}

kern_return_t _MXRPCCall_CopyApplicationList(mach_port_t server,
											 serialized_t *list,
											 mach_msg_type_number_t *size,
											 audit_token_t token)
{
	NSDictionary* apps = [[MXApplicationController sharedInstance] allApplications];
	NSMutableDictionary* serializedApps = [[NSMutableDictionary alloc] init];
	for (NSString* key in apps)
	{
		MXApplication* app = [apps objectForKey:key];
		[serializedApps setObject:[app serialize] forKey:key];
	}
	
	NSData* sendData = 
	[NSPropertyListSerialization dataFromPropertyList:serializedApps
											   format:NSPropertyListBinaryFormat_v1_0
									 errorDescription:nil];
	
	
	*list = malloc([sendData length]);
	[sendData getBytes:*list];
	*size = [sendData length];
	
	return KERN_SUCCESS;
}


kern_return_t _MXRPCCall_LaunchApplication(mach_port_t server,
										   string_t identifier,
										   audit_token_t token)
{
	NSString* string = [[NSString alloc] initWithUTF8String:identifier];
	[[MXController shared] launchApplicationForIdentfier:string];

	return KERN_SUCCESS;
}

kern_return_t _MXRPCCall_CheckIn(mach_port_t server,
								 boolean_t isFullscreen,
								 integer_t windowLevel,
								 boolean_t shouldOffsetizeContext,
								 boolean_t keepAlive,
								 float contextSizeWidth,
								 float contextSizeHeight,
								 float contextOriginX,
								 float contextOriginY,
								 audit_token_t token)
{
	return KERN_SUCCESS;
}

kern_return_t _MXRPCCall_CopyScreenDimensions(mach_port_t server,
											  integer_t *width,
											  integer_t *height,
											  audit_token_t token)
{
	CGSize size = [[MXDevice currentDevice] screenSize];
	*width = size.width;
	*height = size.height;
	
	return KERN_SUCCESS;
}

void _MXRPCStartInternal(void* ptr)
{
	__rpcServerPort = MXIPCStartMachServer(MIG_MXRPC, MobileXRPC_server);
}

void
MXRPCStart()
{
	pthread_t thread;
	pthread_create(&thread,
				   NULL,
				   (void *)&_MXRPCStartInternal,
				   NULL);
}