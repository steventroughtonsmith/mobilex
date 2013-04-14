//
//  MobileX.m
//  MobileX
//

#import <Foundation/Foundation.h>
#import	"MXController.h"
#import "MXLaunchdUtilities.h"
#import "POSIXTask.h"
#import "MXProcess.h"
#import "MXMainLayer.h"
#import <QuartzCore/CAWindowServer.h>
#import <QuartzCore/CAWindowServerDisplay.h>
#import "CoreTelephonyPriv.h"
#import "CARenderServer.h"
#import "MXTesting.h"

#import <unistd.h>

void KillLaunchdJob()
{
	NSString* label = @"com.mx.mx";
	[MXLaunchdUtilities deleteJobWithLabel:label];
	exit(0);
}

void StartWithLaunchd()
{
	printf("Starting up with via Launchd (launchctl) ... \n");
	
	const char* cmd = "launchctl load /var/root/com.mx.mx.plist";
	printf("exec: %s\n",cmd);
	system(cmd);
	
	exit(0);
}

void DisableASLRAndStartWithDebugger()
{
	printf("Starting up with ASLR disabled ... \n");
	
	NSString* exec = [[NSBundle mainBundle] executablePath];
	NSString* label = @"com.mx.mx";
	
	[MXLaunchdUtilities deleteJobWithLabel:label];
	
	[MXLaunchdUtilities createJobWithLabel:label
									  path:exec
								 arguments:nil
							   environment:nil
						standardOutputPath:nil
						 standardErrorPath:nil
							  machServices:nil
							threadPriority:1
						   waitForDebugger:TRUE
					 denyCreatingOtherJobs:TRUE
								 runAtLoad:TRUE
							   disableASLR:TRUE];
	
	int pid = [MXLaunchdUtilities pidForLabel:label];
	printf("Started with PID: %d\n",pid);
	
	printf("Starting GDB ... \n");
	POSIXTask* gdbTask = [[POSIXTask alloc] init];
	[gdbTask setArguments:[NSArray arrayWithObjects:@"/usr/bin/gdb",@"-p",[NSString stringWithFormat:@"%d",pid],nil]];
	[gdbTask setDisableForking:TRUE];
	[gdbTask launch];
}

void PrintVersionInfo()
{
	printf("############################################\n");
	printf("MobileX: %s\n",__FUNCTION__);
	printf("%s:%d\n",__FILE__,__LINE__);
	printf("Built: [sta] %s %s\n",__DATE__,__TIME__);
	printf("############################################\n");
}

void StartSpringBoard()
{
	printf("Reverting back to SpringBoard ...\n");
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/LaunchDaemons/com.apple.SpringBoard.plist"])
	{
		printf("You seem to be missing SpringBoard daemon definition!\n");
		exit(0);
	}
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:@"/var/db/launchd.db/com.apple.launchd/overrides.plist"])
	{
		printf("There is an override file. Deleting it ...\n");
		[[NSFileManager defaultManager] removeItemAtPath:@"/var/db/launchd.db/com.apple.launchd/overrides.plist" error:nil];
	}
	
	printf("Terminating MobileX ...\n");
	
	system("launchctl remove com.mx.mx");

	/* Give Quartz time to release the context */
	
	sleep(5);
	fflush(stdout);
	
	printf("Firing up SpringBoard via launchctl ...\n");
	system("launchctl load /System/Library/LaunchDaemons/com.apple.SpringBoard.plist");
	
	fflush(stdout);
	
	system("killall MobileX");
	exit(0);
}

void StartScreenSaver()
{
	printf("Starting up as black screensaver ... \n");
	
	MXMainLayer* _mainLayer = [[MXMainLayer layer] init];
	
	/* resize the layer */
	CAWindowServerDisplay* clcd = [[[CAWindowServer server] displays] objectAtIndex:0];
	[_mainLayer setFrame:CGRectMake(0, 0, [clcd bounds].size.width, [clcd bounds].size.height)];
	[_mainLayer setBackgroundColor:RGB(0.0,0.0,0.0)];
	[_mainLayer removeAllAnimations];
	
	CFRunLoopRun();
}

void RunEventPump()
{
	/* as simple as that */
	printf(" +----------------------- Running as the Event Pump ---------------------+\n");
	printf(" |   In this mode you can run UIKit applications without activating them |\n");
	printf(" |   You can now run them as console applications                        |\n");
	printf(" |   HID Events will be dispatched to them                               |\n");
	printf(" +-----------------------------------------------------------------------+ \n\n");

	mach_port_t port;
	bootstrap_check_in(bootstrap_port, "com.apple.eventpump", &port);
	
	MXHIDStartEventPump();
	CFRunLoopRun();
	
	exit(0);
}

void KillSpringBoardIfNeeded()
{
	if ([[MXLaunchdUtilities allJobLabels] containsObject:@"com.apple.SpringBoard"])
	{
		MXLog(@"Killing SpringBoard ...");
		
		[MXLaunchdUtilities deleteJobWithLabel:@"com.apple.SpringBoard"];
		
		/* We need to give it a couple of seconds to free WindowServer */
		/* If that is not done, WindowServer will complain, and remote contexts will fail to register */
		sleep(2);
	}
}

void exc_handleException(NSException *exception) {
    NSLog(@"Uncaught Exception: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
	
	_exit(0);
}

int main(int argc, char *argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	NSSetUncaughtExceptionHandler(&exc_handleException);
	
	for (int i = 1; i < argc; i++) 
	{
		if (i != argc)
		{
			if (strcmp(argv[i], "-s") == 0) 
			{
				/* start springboard */
				StartSpringBoard();
			}
			else if (strcmp(argv[i], "-d") == 0) 
			{
				/* disable aslr for process  */
				DisableASLRAndStartWithDebugger();
			}
			else if (strcmp(argv[i], "-l") == 0)
			{
				StartWithLaunchd();
			}
			else if (strcmp(argv[i], "-e") == 0)
			{
				RunEventPump();
			}
			else if (strcmp(argv[i], "-q") == 0)
			{
				KillLaunchdJob();
			}
			else if (strcmp(argv[i], "-b") == 0) 
			{
				KillSpringBoardIfNeeded();
				StartScreenSaver();
			}
			else if (strcmp(argv[i], "-CoreTelephonyTest") == 0) 
			{
				RunCTUnitTest();
			}

		}
	}

	PrintVersionInfo();
	KillSpringBoardIfNeeded();
	[MXLaunchdUtilities deleteJobWithLabel:@"com.mx.mx"];
	
	/*** Start the application ***/
	[MXController shared];
	
	[pool release];
    return 0;
}
