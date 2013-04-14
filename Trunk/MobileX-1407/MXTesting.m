#import "MXTesting.h"

#import "CoreTelephonyPriv.h"
#import "MXLoggingMacros.h"

#import <IOKit/IOKitLib.h>

void FTLTest()
{
	CFMutableDictionaryRef matching , properties = NULL;
	io_registry_entry_t entry = 0;
	matching = IOServiceMatching("AppleNANDFTL");
	
	entry = IOServiceGetMatchingService(kIOMasterPortDefault, matching);
	IORegistryEntryCreateCFProperties(entry, &properties, NULL, 0);
	
	MSLog(@"FTL Settings: %@",properties);
	
	io_connect_t ftl;
	IOServiceOpen(entry,
				  mach_task_self(),
				  0,
				  &ftl);
	
	MSLog(@"FTL Addr: %p",ftl);
	
	void* ptr;
	size_t sz;
	
	IOConnectCallStructMethod(ftl,
							  0x30000200,
							  NULL,
							  0,
							  ptr,
							  &sz);
	
	MSLog(@"Called: %d",sz);
}

void CTSrvNotification()
{
	MSLog(@"Caught a CT SERVER notification");
}

void CTCtrNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	MSLog(@"Caught a CT notification");
}

void CTScanCalls()
{
	MSLog(@"\nCTCall");
	MSIndent();
	MSLog(@"Calls: %@",CTCopyCurrentCalls(NULL));
	MSUnindent();
	
	sleep(3);
	CTScanCalls();
}

void RunCTUnitTest()
{
	/* coretelephony test, nothing fancy */
	MSLog(@"CTRegistration");
	
	MSIndent();
	MSLog(@"Operator: %@",CTRegistrationCopyOperatorName(NULL));
	MSLog(@"Status: %@",CTRegistrationGetStatus(NULL));
	MSLog(@"Strength: %d",CTGetSignalStrength());
	MSUnindent();
	
	MSLog(@"\nCTTelephonyCenter");
	MSIndent();
	
	CTTelephonyCenterRef telCtr = CTTelephonyCenterGetDefault();
	MSLog(@"TelephonyCenter: %@ (%p)",telCtr,telCtr);

	CTTelephonyCenterAddObserver(telCtr,
								 telCtr,
								 CTCtrNotification,
								 kCTTelephonyCenterDaemonRestartNotification,
								 0,
								 4);
	
	CTTelephonyCenterAddObserver(telCtr,
								 telCtr,
								 CTCtrNotification,
								 kCTCallStatusChangeNotification,
								 0,
								 4);
	
	CTTelephonyCenterAddObserver(telCtr,
								 telCtr,
								 CTCtrNotification,
								 kCTCallCauseCodeNotification,
								 0,
								 4);
	
	MSUnindent();
	
	MSLog(@"\nCTServerConnection");
	MSIndent();
	
	CTServerConnectionRef srv = 
	_CTServerConnectionCreateWithIdentifier(kCFAllocatorDefault,
											CFSTR("com.apple.YourMother"),
											CTSrvNotification,
											NULL);
	MSLog(@"ServerConnection %@",srv);
	
	MSUnindent();
	
	CTScanCalls();
	
	CFRunLoopRun();
	exit(0);
}


























