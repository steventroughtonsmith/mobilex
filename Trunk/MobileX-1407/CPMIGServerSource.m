/*
 *  CPMIGServerSource.m
 *  AppSupport
 */

#import "CPMIGServerSource.h"
#import <mach/mach.h>

typedef struct __CPContextInfo {
	void* subsystem;
	mach_port_t port;
} CPContextInfo;

static Boolean _migHelperEqual(const void* i1,const void* i2)
{
	if (((CPContextInfo*)i1)->port ==
		((CPContextInfo*)i2)->port)
	{
		return TRUE;
	}
	else {
		return FALSE;
	}

}

static CFStringRef _migHelperCopyDescription(void* info)
{
	return 
	CFStringCreateWithFormat(kCFAllocatorDefault,
							 NULL,
							 CFSTR("<CFRunLoopSource MIG Server> {port = %u, subsystem = %p, context = %p}"),
							 ((CPContextInfo*)info)->port,
							 ((CPContextInfo*)info)->subsystem,
							 NULL);
}

static mach_port_t _migHelperGetPort(void *info)
{
	return ((CPContextInfo*)info)->port;
}

static void* _migHelperRecievePortCallout(void *msg, CFIndex size, CFAllocatorRef allocator, void *info)
{	
	mig_reply_error_t *bufRequest, *bufReply;
	mach_msg_options_t options;
	bufRequest = (mig_reply_error_t*)msg;

	//CPProbeMachHeader(bufRequest, bufRequest->Head.msgh_size);
	
	if (((CPContextInfo*)info)->subsystem != NULL) {
		
		/* pfff ... */
		bufReply = malloc(sizeof(bufReply)+204800);
		
		void* serverCall = ((CPContextInfo*)info)->subsystem;
		
		/* magic everywhere up in this bitch */
		((boolean_t (*)(void* , void*)) serverCall) (bufRequest,bufReply);
		
		if (!(bufReply->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX)) {
			if (bufReply->RetCode == MIG_NO_REPLY)
				bufReply->Head.msgh_remote_port = MACH_PORT_NULL;
			else if ((bufReply->RetCode != KERN_SUCCESS) &&
					 (bufRequest->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX)) {
				/* destroy the request - but not the reply port */
				bufRequest->Head.msgh_remote_port = MACH_PORT_NULL;
				mach_msg_destroy(&bufRequest->Head);
			}
		}
		
		mach_msg(
				 &bufReply->Head,
				 (MACH_MSGH_BITS_REMOTE(bufReply->Head.msgh_bits) ==
				  MACH_MSG_TYPE_MOVE_SEND_ONCE) ?
				 MACH_SEND_MSG|MACH_RCV_MSG|options :
				 MACH_SEND_MSG|MACH_RCV_MSG|MACH_SEND_TIMEOUT|options,
				 bufReply->Head.msgh_size, size, 0,
				 MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
		
		mach_msg_destroy(&bufReply->Head);
		free(&bufReply->Head);
	}
	
	
	return NULL;
}

CFRunLoopSourceRef
CPCreateMIGServerSource(void* subsystem,
						mach_port_t port,
						int order)
{
	CPContextInfo* info = malloc(sizeof(CPContextInfo));
	info->port = port;
	info->subsystem = subsystem;
	
	CFRunLoopSourceContext1* context = malloc(sizeof(CFRunLoopSourceContext1));
	context->version = 1;
	context->info = info;
	context->retain = NULL;
	context->release = NULL;
	context->copyDescription = (CFStringRef (*)(const void *))_migHelperCopyDescription;
	context->equal = _migHelperEqual;
	context->hash = NULL;
	context->getPort = _migHelperGetPort;
	context->perform = _migHelperRecievePortCallout;
	
	CFRunLoopSourceRef source =
	CFRunLoopSourceCreate(kCFAllocatorDefault, order, ((CFRunLoopSourceContext*)context));
	
	free(context);

	return source;
}