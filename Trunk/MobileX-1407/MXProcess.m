/*
 
 # MXProcess
 # SpringBoardSupport
 
 This class represents an application process.
 It provides features to manage proc priorities.
 
 TODO:
	> Fix the bootstrapping issue
	> Suspend
 
 */


#import "MXProcess.h"
#import "MXLaunchdUtilities.h"
#import "BootstrapServices.h"
/* */
#import <sys/event.h>

@implementation MXProcess

@synthesize jobLabel=_jobLabel;
@synthesize pid=_pid;

- (id) initWithRunningPid:(int)pid
				 jobLabel:(NSString*)jobLabel
			eventPortName:(NSString*)eventPortName
{
	[super init];
	
	_pid = pid;
	_jobLabel = jobLabel;
	_running = TRUE;
	
	kern_return_t rtr = 
	task_name_for_pid(mach_task_self(), _pid, &_taskNamePort);
	if (rtr != KERN_SUCCESS)
	{
		MXSLog(@"Unable to obtain a task name port right for pid %i: %s",_pid,mach_error_string(rtr));
	}
	
	MSLog(@"looking up event port for %s",[eventPortName UTF8String]);
	
	rtr =
	bootstrap_look_up(bootstrap_port, [eventPortName UTF8String], &_eventPort);
	if (rtr != KERN_SUCCESS)
	{
		MXSLog(@"Unable to look up event port name for pid %i: %s",_pid,mach_error_string(rtr));
	}
	
	[_jobLabel retain];
	return self;
}

- (id) initWithPid:(int)pid
		 frontmost:(BOOL)frontmost
	backgroundJetsamPriority:(long long)jetsam
		  jobLabel:(NSString*)jobLabel
	 eventPortName:(NSString*)eventPortName
	allowedLockedFilePaths:(id)paths
	terminateOnSuspension:(BOOL)terminateOnSuspension
		  execTime:(NSTimeInterval)execTime
{
	[super init];
	
	_pid = pid;
	_jobLabel = jobLabel;
	_running = TRUE;
	
	/* jetsam */
	[MXLaunchdUtilities setJetsamPriority:jetsam
							  forJobLabel:_jobLabel
							  isFrontmost:TRUE];
	
	/*
	 * This is obviously not working
	 * For some reason 'kevent' will fire on EXEC
	 * But the bootstrap port isn't really "bootstrapped"
	 * Although if I use sleep() it will work
	 */
	[self waitForExecOrExit];
	
	kern_return_t rtr = 
	task_name_for_pid(mach_task_self(), _pid, &_taskNamePort);
	if (rtr != KERN_SUCCESS)
	{
		MXSLog(@"Unable to obtain a task name port right for pid %i: %s",_pid,mach_error_string(rtr));
	}
	
	rtr =
	bootstrap_look_up(bootstrap_port, [eventPortName UTF8String], &_eventPort);
	if (rtr != KERN_SUCCESS)
	{
		MXSLog(@"Unable to look up event port name for pid %i: %s",_pid,mach_error_string(rtr));
	}
	
	[_jobLabel retain];
	return self;
}

- (void) waitForExecOrExit
{
	MXSLog(@"Waiting for a kernel event (NOTE_EXEC or NOTE_EXIT) ...");
	
	int kq = kqueue();
	int evt;
	struct kevent change;
	struct kevent event;
	struct timespec timeout;
	
	timeout.tv_sec = 3;
	timeout.tv_nsec = 0;
	
	/* exec or exit */
	EV_SET(&change, _pid, EVFILT_PROC, EV_ADD | EV_ONESHOT, NOTE_EXEC | NOTE_EXIT , 0, NULL);
	
	evt = kevent(kq, &change, 1, &event, 1, &timeout);
	
	if (evt == EINTR) {
		MSLog(@"kevent: Timed out while waiting for an application.");
		MSLog(@"Killing %d as it is hung.",_pid);
		[self killWithSignal:9];
	}
	
	/*
	 XXX
	 If this does not fire, this thread will hang up permamantely.
	 */
	
	close(kq);
	if (event.fflags & NOTE_EXEC) {
		//MXSLog(@"kevent NOTE_EXEC");
		return;
	}
	else if (event.fflags & NOTE_EXIT) {
		//MXSLog(@"kevent NOTE_EXIT");
		return;
	}
	else if (event.fflags & NOTE_TRACK) {
		//MXSLog(@"kevent NOTE_TRACK");
		return;
	}
	else if (event.fflags & NOTE_CHILD) {
		//MXSLog(@"kevent NOTE_CHILD");
		return;
	}
	else {
		MXSLog(@"Critical Error: Kevent undefined behaviour of unknown origin.");
		exit(0);
		return;
	}

}

- (void) killWithSignal:(int)signal
{
	if (_running)
		kill(_pid, signal);
}

+ (void) _logJetsamPriorities
{

}

- (void) updateJetsamPriority:(long long)priority
{
	if (_running)
	{
		[MXLaunchdUtilities setJetsamPriority:priority
								  forJobLabel:_jobLabel
								  isFrontmost:TRUE];
	}
}

- (void) setPriority:(int)priority
{
	errno = 0;
	int res = setpriority(PRIO_PROCESS, _pid, 0);
	
	if (res == -1) {
		MXSLog(@"Could not set priortiy of pid:%d to %d",_pid,priority);
	}
	else {
		MXSLog(@"Successfully set priortiy of pid:%d to %d",_pid,priority);
	}

}

- (BOOL) isRunning
{
	return _running;
}

- (void) setRunning:(BOOL)r
{
	NSAssert(r == FALSE,@"reincarnation not permitted");
	_running = r;
}

+ (id) launchedProcessWithBundleIdentifier:(NSString*)identifier
									  path:(NSString*)path
								 arguments:(NSArray*)arguments
							   environment:(NSDictionary*)environment
						standardOutputPath:(NSString*)standardOutputPath
						 standardErrorPath:(NSString*)standardErrorPath
							  machServices:(NSArray*)machServices
							threadPriority:(long long)threadPriority
								 frontmost:(BOOL)frontmost
				  backgroundJetsamPriority:(int)backgroundJetsamPriority
						   waitForDebugger:(BOOL)waitForDebugger
							   disableASLR:(BOOL)disableASLR
					allowedLockedFilePaths:(id)paths
					 terminateOnSuspension:(int)suspension
{
	NSString* jobLabel = [NSString stringWithFormat:@"%@%@[%04#x]",@"UIKitApplication:",identifier,arc4random() % 0xFFFF];
	NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
	
	BOOL result = 
	[MXLaunchdUtilities createJobWithLabel:jobLabel
									  path:path
								 arguments:arguments
							   environment:environment
						standardOutputPath:standardOutputPath
						 standardErrorPath:standardErrorPath
							  machServices:machServices
							threadPriority:threadPriority
						   waitForDebugger:waitForDebugger
					 denyCreatingOtherJobs:TRUE
								 runAtLoad:TRUE
							   disableASLR:disableASLR];
	
	if (!result) {
		return nil;
	}
	
	MXProcess* pr = [[MXProcess alloc] initWithPid:[MXLaunchdUtilities pidForLabel:jobLabel]
										 frontmost:frontmost
						  backgroundJetsamPriority:backgroundJetsamPriority
										  jobLabel:jobLabel
									 eventPortName:identifier
							allowedLockedFilePaths:paths
							 terminateOnSuspension:suspension
										  execTime:startTime];
	
	return pr;
}

@end
