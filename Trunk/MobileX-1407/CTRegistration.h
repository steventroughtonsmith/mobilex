/*
 *  CTRegistration.h
 *  CoreTelephony
 */

CFStringRef CTRegistrationCopyOperatorName(void* ref);
CFStringRef CTRegistrationGetStatus(void* allocator);
int CTGetSignalStrength();