/* LaunchdUtilities : Header */

#import <Foundation/Foundation.h>
#include <launch.h>

#define LAUNCH_JOBKEY_JETSAMPRIORITY "JetsamPriority"
#define LAUNCH_JOBKEY_THREADPRIORITY "EmbeddedMainThreadPriority"

@interface MXLaunchdUtilities : NSObject {

}

+ (NSArray*) allJobLabels;

+ (BOOL) deleteJobWithLabel:(NSString*)label;

+ (int) pidForLabel:(NSString *)label;

+ (void) setJetsamPriority:(long long)priority
			   forJobLabel:(NSString*)label
			   isFrontmost:(BOOL)frontmost;

+ (int) lastExitStatusForLabel:(NSString *)label;

+ (BOOL) createJobWithLabel:(NSString*)label 
					   path:(NSString*)path
				  arguments:(NSArray*)arguments 
				environment:(NSDictionary*)environment
		 standardOutputPath:(NSString*)standardOutputPath
		  standardErrorPath:(NSString*)standardErrorPath
			   machServices:(NSArray*)machServices
			 threadPriority:(long long)threadPriority
			waitForDebugger:(BOOL)waitForDebugger
	  denyCreatingOtherJobs:(BOOL)denyCreatingOtherJobs
				  runAtLoad:(BOOL)runAtLoad
				disableASLR:(BOOL)disableASLR;

@end
