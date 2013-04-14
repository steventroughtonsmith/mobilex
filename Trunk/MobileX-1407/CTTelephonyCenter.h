/*
 *  CTTelephonyCenter.h
 *  CoreTelephony
 */

typedef void * CTTelephonyCenterRef;

extern CFStringRef kCTCallStatusChangeNotification;
extern CFStringRef kCTCallControlFailureNotification;
extern CFStringRef kCTCallForwardedNotification;
extern CFStringRef kCTCallForwardingActiveNotification;
extern CFStringRef kCTCallCauseCodeNotification;
extern CFStringRef kCTPowerRadioModuleResetNotification;
extern CFStringRef kCTTelephonyCenterDaemonRestartNotification;
extern CFStringRef kCTIndicatorsSignalStrengthNotification;
extern CFStringRef kCTSIMSupportSIMStatusChangeNotification;
extern CFStringRef kCTPowerRadioModuleDeadNotification;
extern CFStringRef kCTRegistrationStatusChangedNotification;
extern CFStringRef kCTRegistrationServiceProviderNameChangedNotification;
extern CFStringRef kCTRegistrationOperatorNameChangedNotification;
extern CFStringRef kCTSIMSupportSIMStatusChangeNotification;
extern CFStringRef kCTServiceProvisioningStartedNotification;

CTTelephonyCenterRef CTTelephonyCenterGetDefault();

void CTTelephonyCenterAddObserver(CTTelephonyCenterRef center,
								  void* ref,
								  void(*callback)(),
								  CFStringRef notification,
								  int noidea,
								  int noidea2);

