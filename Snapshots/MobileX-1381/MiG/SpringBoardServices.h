#ifndef	_SpringBoardServices_user_
#define	_SpringBoardServices_user_

/* Module SpringBoardServices */

#include <string.h>
#include <mach/ndr.h>
#include <mach/boolean.h>
#include <mach/kern_return.h>
#include <mach/notify.h>
#include <mach/mach_types.h>
#include <mach/message.h>
#include <mach/mig_errors.h>
#include <mach/port.h>

#ifdef AUTOTEST
#ifndef FUNCTION_PTR_T
#define FUNCTION_PTR_T
typedef void (*function_ptr_t)(mach_port_t, char *, mach_msg_type_number_t);
typedef struct {
        char            *name;
        function_ptr_t  function;
} function_table_entry;
typedef function_table_entry   *function_table_t;
#endif /* FUNCTION_PTR_T */
#endif /* AUTOTEST */

#ifndef	SpringBoardServices_MSG_COUNT
#define	SpringBoardServices_MSG_COUNT	121
#endif	/* SpringBoardServices_MSG_COUNT */

#include <mach/std_types.h>
#include <mach/mig.h>
#include <mach/mig.h>
#include <mach/mach_types.h>
#include "SpringBoardServices_Common.h"

#ifdef __BeforeMigUserHeader
__BeforeMigUserHeader
#endif /* __BeforeMigUserHeader */

#include <sys/cdefs.h>
__BEGIN_DECLS


/* Routine AppWillOrderInContext */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t AppWillOrderInContext
(
	mach_port_t server,
	unsigned context,
	float windowLevel,
	int windowOutput
);

/* Routine AppDidOrderOutContext */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t AppDidOrderOutContext
(
	mach_port_t server,
	unsigned context
);

/* Routine LaunchApplicationWithIdentifier */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t LaunchApplicationWithIdentifier
(
	mach_port_t server,
	int unk0,
	int unk1,
	int unk2,
	int unk3,
	int unk4,
	int unk5,
	int unk6,
	string_t identifier,
	boolean_t suspended,
	int url
);

/* Routine RegisterStatusBarWindowContextId */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t RegisterStatusBarWindowContextId
(
	mach_port_t server,
	unsigned context
);

/* Routine CheckInTaskPort */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t CheckInTaskPort
(
	mach_port_t server,
	int one,
	int two,
	int thr,
	int fr
);

/* Routine RegisterRemoteView */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t RegisterRemoteView
(
	mach_port_t server,
	int one,
	int two
);

__END_DECLS

/********************** Caution **************************/
/* The following data types should be used to calculate  */
/* maximum message sizes only. The actual message may be */
/* smaller, and the position of the arguments within the */
/* message layout may vary from what is presented here.  */
/* For example, if any of the arguments are variable-    */
/* sized, and less than the maximum is sent, the data    */
/* will be packed tight in the actual message to reduce  */
/* the presence of holes.                                */
/********************** Caution **************************/

/* typedefs for all requests */

#ifndef __Request__SpringBoardServices_subsystem__defined
#define __Request__SpringBoardServices_subsystem__defined

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		unsigned context;
		float windowLevel;
		int windowOutput;
	} __Request__AppWillOrderInContext_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		unsigned context;
	} __Request__AppDidOrderOutContext_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		int unk0;
		int unk1;
		int unk2;
		int unk3;
		int unk4;
		int unk5;
		int unk6;
		mach_msg_type_number_t identifierOffset; /* MiG doesn't use it */
		mach_msg_type_number_t identifierCnt;
		char identifier[1024];
		boolean_t suspended;
		int url;
	} __Request__LaunchApplicationWithIdentifier_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		unsigned context;
	} __Request__RegisterStatusBarWindowContextId_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		int one;
		int two;
		int thr;
		int fr;
	} __Request__CheckInTaskPort_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		int one;
		int two;
	} __Request__RegisterRemoteView_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif
#endif /* !__Request__SpringBoardServices_subsystem__defined */

/* union of all requests */

#ifndef __RequestUnion__SpringBoardServices_subsystem__defined
#define __RequestUnion__SpringBoardServices_subsystem__defined
union __RequestUnion__SpringBoardServices_subsystem {
	__Request__AppWillOrderInContext_t Request_AppWillOrderInContext;
	__Request__AppDidOrderOutContext_t Request_AppDidOrderOutContext;
	__Request__LaunchApplicationWithIdentifier_t Request_LaunchApplicationWithIdentifier;
	__Request__RegisterStatusBarWindowContextId_t Request_RegisterStatusBarWindowContextId;
	__Request__CheckInTaskPort_t Request_CheckInTaskPort;
	__Request__RegisterRemoteView_t Request_RegisterRemoteView;
};
#endif /* !__RequestUnion__SpringBoardServices_subsystem__defined */
/* typedefs for all replies */

#ifndef __Reply__SpringBoardServices_subsystem__defined
#define __Reply__SpringBoardServices_subsystem__defined

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		kern_return_t RetCode;
	} __Reply__AppWillOrderInContext_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		kern_return_t RetCode;
	} __Reply__AppDidOrderOutContext_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		kern_return_t RetCode;
	} __Reply__LaunchApplicationWithIdentifier_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		kern_return_t RetCode;
	} __Reply__RegisterStatusBarWindowContextId_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		kern_return_t RetCode;
	} __Reply__CheckInTaskPort_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		kern_return_t RetCode;
	} __Reply__RegisterRemoteView_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif
#endif /* !__Reply__SpringBoardServices_subsystem__defined */

/* union of all replies */

#ifndef __ReplyUnion__SpringBoardServices_subsystem__defined
#define __ReplyUnion__SpringBoardServices_subsystem__defined
union __ReplyUnion__SpringBoardServices_subsystem {
	__Reply__AppWillOrderInContext_t Reply_AppWillOrderInContext;
	__Reply__AppDidOrderOutContext_t Reply_AppDidOrderOutContext;
	__Reply__LaunchApplicationWithIdentifier_t Reply_LaunchApplicationWithIdentifier;
	__Reply__RegisterStatusBarWindowContextId_t Reply_RegisterStatusBarWindowContextId;
	__Reply__CheckInTaskPort_t Reply_CheckInTaskPort;
	__Reply__RegisterRemoteView_t Reply_RegisterRemoteView;
};
#endif /* !__RequestUnion__SpringBoardServices_subsystem__defined */

#ifndef subsystem_to_name_map_SpringBoardServices
#define subsystem_to_name_map_SpringBoardServices \
    { "AppWillOrderInContext", 2000000 },\
    { "AppDidOrderOutContext", 2000001 },\
    { "LaunchApplicationWithIdentifier", 2000003 },\
    { "RegisterStatusBarWindowContextId", 2000022 },\
    { "CheckInTaskPort", 2000118 },\
    { "RegisterRemoteView", 2000120 }
#endif

#ifdef __AfterMigUserHeader
__AfterMigUserHeader
#endif /* __AfterMigUserHeader */

#endif	 /* _SpringBoardServices_user_ */
