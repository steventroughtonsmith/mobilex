/* POSIX Task Wrapper: Impl */

#import "POSIXTask.h"
#import <unistd.h>

@implementation POSIXTask

@synthesize arguments=_arguments;
@synthesize environment=_environment;
@synthesize disableForking=_noFork;

- (int) launch
{
	/*
	 * Prepare the task for execution
	 */
	
	char** args = malloc(sizeof(char*) * ([_arguments count]+1));
	char** env = malloc(sizeof(char*) * ([_environment count]+1));
	int i = 0;
	
	/* prepare argument list */
	for (NSString* arg in _arguments)
	{
		args[i] = (char*)[arg UTF8String];
		i++;
	}
	args[i] = NULL;
	
	i = 0;
	if (_environment != nil)
	{
		for (NSString* arg in _environment)
		{
			env[i] = (char*)[arg UTF8String];
			i++;
		}
	}
	env[i]=NULL;
	
	/*
	 * Fork, and execute
	 */
	
	pid_t pid;
	if (!_noFork) {
		pid = vfork();
	}
	else {
		pid = 0;
	}
	
	if (pid != -1)
	{
		if (pid == 0)
		{
			/* child process */
			
			/* start process */
			int result = execve(args[0], (char**)args, (char**)env);
			printf("Failed to spawn child process.\n");
			if (result != 0)
			{
				perror("Failed to spawn process");
			}
			
			exit(0);
		}
		else 
		{
			int st = 0;
			pid_t p = 0;
			printf("Forked process with PID %d\n",pid);
			_pid = pid;
			do
			{
				p = waitpid(pid, &st, WNOHANG);
				if (p <= 0)
					usleep(300);
			} while (p <= 0);
			
			return WEXITSTATUS(st);
		}
	}
	else 
	{
		printf("Failed to fork child process.\n");
		perror("vfork");
		return 0;
	}

}

@end
