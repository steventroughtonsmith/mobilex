/*
 
 # MXProcess
 # SpringBoardSupport
 
 This class represents an application process.
 It provides features to manage proc priorities.
 
 */

#import <Foundation/Foundation.h>


@interface MXProcess : NSObject {
	/* process vars */
	int _pid;
	BOOL _running;
	
	/* launchd vars */
	NSString* _jobLabel;
	mach_port_t _eventPort;
	mach_port_t _taskNamePort;
	
	/* jetsam */
	int _backgroundJetsamPriority;
	int _currentJetsamPriority;
}

@property(copy) NSString* jobLabel;
@property(readonly) int pid;
@property(assign, getter=isRunning) BOOL running;

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
					 terminateOnSuspension:(int)suspension;

- (id) initWithPid:(int)pid
		 frontmost:(BOOL)frontmost
backgroundJetsamPriority:(long long)jetsam
		  jobLabel:(NSString*)jobLabel
	 eventPortName:(NSString*)eventPortName
allowedLockedFilePaths:(id)paths
terminateOnSuspension:(BOOL)terminateOnSuspension
		  execTime:(NSTimeInterval)execTime;

- (id) initWithRunningPid:(int)pid
				 jobLabel:(NSString*)jobLabel
			eventPortName:(NSString*)eventPortName;

- (void) waitForExecOrExit;
- (void) killWithSignal:(int)signal;

- (void) setPriority:(int)priority;
- (void) updateJetsamPriority:(long long)priority;

+ (void) _logJetsamPriorities;

@end
