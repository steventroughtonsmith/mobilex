/*
 *  CTServerConnection.h
 *  CoreTelephony
 */

typedef struct __CTServerConnection* CTServerConnectionRef;

/* SIM Toolkit notifications */
extern CFStringRef kCTSIMToolkitSentSMSMessageNotification;
extern CFStringRef kCTSIMToolkitDisplayTextNotification;
extern CFStringRef kCTSIMToolkitSentSMSMessageNotification;
extern CFStringRef kCTSIMToolkitSentSSNotification;
extern CFStringRef kCTSIMToolkitSentUSSDNotification;
extern CFStringRef kCTSIMToolkitSentDTMFNotification;
extern CFStringRef kCTSIMToolkitGetInputNotification;
extern CFStringRef kCTSIMToolkitPlayToneNotification;
extern CFStringRef kCTSIMToolkitDisplayListNotification;
extern CFStringRef kCTSIMToolkitCallSetUpNotification;
extern CFStringRef kCTSIMToolkitIdleTextNotification;
extern CFStringRef kCTSIMToolkitLocalInformationNotification;
extern CFStringRef kCTSIMToolkitLanguageNotification;
extern CFStringRef kCTSIMToolkitSessionCompleteNotification;
extern CFStringRef kCTSIMToolkitRequestUserAttentionNotification;

/* Establishes connection to the CT server 
   Returns a pointer to the new connection object.
   On error, the error value is != 0.
 */
CTServerConnectionRef
_CTServerConnectionCreate(CFAllocatorRef allocator,
						  void* callback,
						  int* error);

CTServerConnectionRef
_CTServerConnectionCreateWithIdentifier(CFAllocatorRef allocator,
										CFStringRef identifier,
										void* callback,
										void* error);

/* Gets the mach port for the notifications */
mach_port_t
_CTServerConnectionGetPort(CTServerConnectionRef connection);

/* Registers for a CT notification */
void
_CTServerConnectionRegisterForNotification(CTServerConnectionRef connection,
										   CFStringRef notification);