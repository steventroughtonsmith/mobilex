/* LaunchdUtilities : Implementation */

#import "MXLaunchdUtilities.h"

@implementation MXLaunchdUtilities

static NSMutableArray* _jobArray;

static int CopyLaunchdIntegerForLabel(NSString* label, const char* key)
{
	launch_data_t jobLabel = launch_data_new_string([label UTF8String]);
	launch_data_t messageDict = launch_data_alloc(LAUNCH_DATA_DICTIONARY);
	launch_data_dict_insert(messageDict, jobLabel, LAUNCH_KEY_GETJOB);
	
	launch_data_t jobDict = launch_msg(messageDict);
	
	if (jobDict == (launch_data_t)0) {
		MSLog(@"Unable to get job dictionary for label '%@'. Internal error.",label);
		return 0;
	}
	
	int type = launch_data_get_type(jobDict);
	if (type != LAUNCH_DATA_DICTIONARY)
	{
		if (type == LAUNCH_DATA_ERRNO)
		{
			int en = launch_data_get_errno(jobDict);
			if (en != 0)
				MSLog(@"Unable to get job dictionary for label '%@'. Error: %s",label,strerror(en));
		}
		else 
		{
			MSLog(@"Launchd returned incorrect data type %d for job '%@' dictionary.",type,label);
		}
		
		return 0;
	}
	
	launch_data_t jobData;
	
	int retVal = (int)launch_data_dict_lookup(jobDict, key);
	
	/* This causes a bus error if not treated */
	if (retVal != 0) {
		jobData = (launch_data_t)retVal;
	}
	else {
		return 0;
	}
	
	if (launch_data_get_type(jobData) != LAUNCH_DATA_INTEGER)
	{
		MSLog(@"Launchd returned incorrect data type for job '%@' and key '%s'.",label,key);
		return 0;
	}
	
	int returnValue = launch_data_get_integer(jobData);
	
	return returnValue;
}

static void iterateLaunchdDictionary(launch_data_t obj, const char *key, void *context)
{
	[_jobArray addObject:[NSString stringWithUTF8String:key]];
}

+ (NSArray*) allJobLabels
{
	launch_data_t request = launch_data_new_string(LAUNCH_KEY_GETJOBS);
	launch_data_t lDict = launch_msg(request);
	launch_data_free(request);
	
	if (lDict == (launch_data_t)0) {
		MSLog(@"Unable to get job dictionaries. Internal error.");
		return nil;
	}
	
	if (launch_data_get_type(lDict) != LAUNCH_DATA_DICTIONARY)
	{
		MSLog(@"Error getting job dictionaries. Error: %s",strerror(launch_data_get_errno(lDict)));
		return nil;
	}
	
	int iterator;
	/* hooray, its a dictinary*/
	
	_jobArray = [[NSMutableArray alloc] init];
	launch_data_dict_iterate(lDict, iterateLaunchdDictionary , &iterator);
	
#ifdef DEBUG_038
	MXSLog(@"Finished enumerating %d jobs",[_jobArray count]);
#endif
	
	launch_data_free(lDict);
	
	return _jobArray;
}

/* to be honest, I've got no fucking idea what this does */
+ (void) setJetsamPriority:(long long)priority
			   forJobLabel:(NSString*)label
			   isFrontmost:(BOOL)frontmost
{
	launch_data_t dict = launch_data_alloc(LAUNCH_DATA_DICTIONARY);
	launch_data_t data;
	
	data = launch_data_new_string([label UTF8String]);
	launch_data_dict_insert(dict, data, "JetsamLabel");
	
	data = launch_data_new_integer(priority);
	launch_data_dict_insert(dict, data, "JetsamPriority");
	
	data = launch_data_new_bool(frontmost);
	launch_data_dict_insert(dict, data, "JetsamFrontmost");
	
	launch_data_t arr = launch_data_alloc(LAUNCH_DATA_ARRAY);
	launch_data_array_set_index(arr, dict, 0);
	
	launch_data_t messageDict = launch_data_alloc(LAUNCH_DATA_DICTIONARY);
	launch_data_dict_insert(messageDict, arr, "SetPriorityList");
	
	launch_data_t rtr = launch_msg(messageDict);
	launch_data_free(messageDict);
	
	if (rtr == (launch_data_t)0) {
		MSLog(@"Unable to set Jetsam priority on job with label %@. Internal error.");
		return;
	}
	
	if (launch_data_get_type(rtr) == LAUNCH_DATA_ERRNO)
	{
		int en = launch_data_get_errno(rtr);
		
		if (en != 0)
			MSLog(@"Unable to set Jetsam priority on job with label %@. Error: %s",label,strerror(en));
	}
}

+ (int) lastExitStatusForLabel:(NSString *)label
{
	int status = CopyLaunchdIntegerForLabel(label, LAUNCH_JOBKEY_LASTEXITSTATUS);
	return status;
}

+ (int) pidForLabel:(NSString *)label
{
	int pid = CopyLaunchdIntegerForLabel(label, LAUNCH_JOBKEY_PID);
	return pid;
}

+ (BOOL) deleteJobWithLabel:(NSString *)label
{
	/* This has the potential to fuck up launchd */
	
	launch_data_t dict;
	
	if (label != nil) {
		dict = launch_data_new_string([label UTF8String]);
	}
	else {
		MSLog(@"Missing job label");
		return FALSE;
	}	
	
	/* Message to launchd */
	launch_data_t messageDict = launch_data_alloc(LAUNCH_DATA_DICTIONARY);
	launch_data_dict_insert(messageDict, dict, LAUNCH_KEY_REMOVEJOB);
	
	launch_data_t rtr = launch_msg(messageDict);
	
	if (rtr == (launch_data_t)0) {
		MSLog(@"Unable to remove job with label %@. Internal error.",label);
		return FALSE;
	}
	
	if (launch_data_get_type(rtr) == LAUNCH_DATA_ERRNO)
	{
		int en = launch_data_get_errno(rtr);
		if (en != 0)
			MSLog(@"Unable to remove job with label %@. Error: %s",label,strerror(en));
	}
	
	return TRUE;
}

/* 
 createJobWithLabel:
 path:
 arguments:
 environment:
 standardOutputPath:
 standardErrorPath:
 machServices:
 threadPriority:
 waitForDebugger:
 denyCreatingOtherJobs:
 runAtLoad:
 disableASLR:
 */

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
				disableASLR:(BOOL)disableASLR
{
	launch_data_t dict, data;
	dict = launch_data_alloc(LAUNCH_DATA_DICTIONARY);
	
	if (label != nil) {
		data = launch_data_new_string([label UTF8String]);
		launch_data_dict_insert(dict, data, LAUNCH_JOBKEY_LABEL);
	}
	else {
		return FALSE;
	}

	/* ######### Program Arguments ######### */
	data = launch_data_alloc(LAUNCH_DATA_ARRAY);
	/* ---- Launch Path ---- */
	if (path != nil)
	{
		launch_data_array_set_index(data, launch_data_new_string([path UTF8String]), 0);
	}
	else {

		MSLog(@"Unable to create job: Missing main path");
		return FALSE;
	}
	/* ---- Arguments ---- */
	if (arguments != nil)
	{
		for (int i = 0;i < [arguments count];i++)
		{
			/* Just in case check if arg is a string*/
			if ([[arguments objectAtIndex:i - 0] class] == [NSString class])
			{
				launch_data_array_set_index(data, launch_data_new_string([[arguments objectAtIndex:i] UTF8String]), i + 1);
			}
		}
	}
	else {
		/* Missing arguments */
	}
	launch_data_dict_insert(dict, data, LAUNCH_JOBKEY_PROGRAMARGUMENTS);
	
	/* ######### Environment ######### */
	if (environment != nil) {
		data = launch_data_alloc(LAUNCH_DATA_DICTIONARY);
		for (NSString* var in environment)
		{
			launch_data_t kvalue = launch_data_new_string([[environment objectForKey:var] UTF8String]);
			launch_data_dict_insert(data, kvalue, [var UTF8String]);
		}
		launch_data_dict_insert(dict, data, LAUNCH_JOBKEY_ENVIRONMENTVARIABLES);
	}
	
	
	/* ######### Mach Services ######### */
	if (machServices != nil && [machServices count] != 0) {
		data = launch_data_alloc(LAUNCH_DATA_DICTIONARY);
		for (NSString* service in machServices)
		{
			launch_data_t kdvalue = launch_data_alloc(LAUNCH_DATA_DICTIONARY);
			launch_data_t kvalue = launch_data_new_bool(FALSE);
			launch_data_dict_insert(kdvalue, kvalue, "ResetAtClose");
			launch_data_dict_insert(data, kvalue, [service UTF8String]);
		}
		launch_data_dict_insert(dict, data, LAUNCH_JOBKEY_MACHSERVICES);
	}
	
	
	/* ######### Other bits of crap ######### */
	if (standardOutputPath != nil)
	{
		/* std out - non critical */
		data = launch_data_new_string([standardOutputPath UTF8String]);
		launch_data_dict_insert(dict, data, LAUNCH_JOBKEY_STANDARDOUTPATH);
	}
	
	if (standardErrorPath != nil)
	{
		/* std err - non critical */
		data = launch_data_new_string([standardErrorPath UTF8String]);
		launch_data_dict_insert(dict, data, LAUNCH_JOBKEY_STANDARDERRORPATH);
	}
	
	data = launch_data_new_integer(threadPriority);
	launch_data_dict_insert(dict, data, LAUNCH_JOBKEY_THREADPRIORITY);
	
	//data = launch_data_new_integer(jetsamPriority);
	//launch_data_dict_insert(dict, data, LAUNCH_JOBKEY_JETSAMPRIORITY);
	
	if (denyCreatingOtherJobs)
	{
		launch_data_t poldict = launch_data_alloc(LAUNCH_DATA_DICTIONARY);
		data = launch_data_new_bool(denyCreatingOtherJobs);
		launch_data_dict_insert(poldict, data, "DenyCreatingOtherJobs");
		launch_data_dict_insert(dict, poldict, "Policies");
	}
	
	if (waitForDebugger)
	{
		data = launch_data_new_bool(waitForDebugger);
		launch_data_dict_insert(dict, data, LAUNCH_JOBKEY_WAITFORDEBUGGER);
	}
	
	data = launch_data_new_integer(1);
	launch_data_dict_insert(dict, data, "ExitTimeOut");
	
	data = launch_data_new_integer(5);
	launch_data_dict_insert(dict, data, LAUNCH_JOBKEY_THROTTLEINTERVAL);
	
	data = launch_data_new_bool(runAtLoad);
	launch_data_dict_insert(dict, data, LAUNCH_JOBKEY_RUNATLOAD);
	
	data = launch_data_new_string([NSUserName() UTF8String]);
	launch_data_dict_insert(dict, data, "UserName");
	
	data = launch_data_new_bool(disableASLR);
	launch_data_dict_insert(dict, data, "DisableASLR");
	
	
	
	/* Message to launchd */
	launch_data_t messageDict = launch_data_alloc(LAUNCH_DATA_DICTIONARY);
	launch_data_dict_insert(messageDict, dict, LAUNCH_KEY_SUBMITJOB);
	
	launch_data_t rtr = launch_msg(messageDict);
	
	launch_data_free(messageDict);
	
	if (rtr == (launch_data_t)0) {
		MSLog(@"Unable to create job with label %@. Internal error.",label);
		return FALSE;
	}
	
	if (launch_data_get_type(rtr) == LAUNCH_DATA_ERRNO)
	{
		int en = launch_data_get_errno(rtr);
		if (en != 0)
			MSLog(@"Unable to create job with label %@. Error: %s",label,strerror(en));
	}
	
	return TRUE;
}

@end
