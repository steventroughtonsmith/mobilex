/*
 MXSBInitialization: Impl
 
 This essentially contains the routines SpringBoard would
 run before starting the main class.
 */

#import "MXSBInitialization.h"

void MXSBMoveRestoredFile(NSString* file)
{
	
}

void MXSBMain()
{
	NSArray* possibleRestoredFiles = [NSArray arrayWithObjects:
									  @"~/Library/Calendar/Calendar.sqlitedb.restored",
									  @"~/Library/AddressBook/AddressBook.sqlitedb.restored",
									  @"~/Library/AddressBook/AddressBookImages.sqlitedb.restored",
									  @"~/Library/SpringBoard/IconState.plist.restored",
									  @"~/Library/SMS/sms.db.restored",
									  nil];
	
	for (NSString* file in possibleRestoredFiles)
	{
		file = [file stringByExpandingTildeInPath];
		if ([[NSFileManager defaultManager] fileExistsAtPath:file])
		{
			MXSBMoveRestoredFile(file);
		}
	}
	
	
}