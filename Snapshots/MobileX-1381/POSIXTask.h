/* POSIX Task Wrapper: Header */

#import <Foundation/Foundation.h>


@interface POSIXTask : NSObject {
	NSArray* _arguments;
	NSDictionary* _environment;
	pid_t _pid;
	
	BOOL _noFork;
}

@property (retain) NSArray* arguments;
@property (retain) NSDictionary* environment;
@property BOOL disableForking;

- (int) launch;

@end
