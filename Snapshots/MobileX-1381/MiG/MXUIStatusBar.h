#ifndef	_MXUIStatusBar_user_
#define	_MXUIStatusBar_user_

/* Module MXUIStatusBar */

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

#ifndef	MXUIStatusBar_MSG_COUNT
#define	MXUIStatusBar_MSG_COUNT	16
#endif	/* MXUIStatusBar_MSG_COUNT */

#include <mach/std_types.h>
#include <mach/mig.h>
#include <mach/mig.h>
#include <mach/mach_types.h>
#include "MXUIStatusBarServerCommon.h"

#ifdef __BeforeMigUserHeader
__BeforeMigUserHeader
#endif /* __BeforeMigUserHeader */

#include <sys/cdefs.h>
__BEGIN_DECLS


/* Routine GetStatusBarData */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t MXUIStatusBarGetStatusBarData
(
	mach_port_t server,
	serialized_t *list,
	mach_msg_type_number_t *listCnt
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

#ifndef __Request__MXUIStatusBar_subsystem__defined
#define __Request__MXUIStatusBar_subsystem__defined

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
	} __Request__GetStatusBarData_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif
#endif /* !__Request__MXUIStatusBar_subsystem__defined */

/* union of all requests */

#ifndef __RequestUnion__MXUIStatusBarMXUIStatusBar_subsystem__defined
#define __RequestUnion__MXUIStatusBarMXUIStatusBar_subsystem__defined
union __RequestUnion__MXUIStatusBarMXUIStatusBar_subsystem {
	__Request__GetStatusBarData_t Request_MXUIStatusBarGetStatusBarData;
};
#endif /* !__RequestUnion__MXUIStatusBarMXUIStatusBar_subsystem__defined */
/* typedefs for all replies */

#ifndef __Reply__MXUIStatusBar_subsystem__defined
#define __Reply__MXUIStatusBar_subsystem__defined

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		/* start of the kernel processed data */
		mach_msg_body_t msgh_body;
		mach_msg_ool_descriptor_t list;
		/* end of the kernel processed data */
		NDR_record_t NDR;
		mach_msg_type_number_t listCnt;
	} __Reply__GetStatusBarData_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif
#endif /* !__Reply__MXUIStatusBar_subsystem__defined */

/* union of all replies */

#ifndef __ReplyUnion__MXUIStatusBarMXUIStatusBar_subsystem__defined
#define __ReplyUnion__MXUIStatusBarMXUIStatusBar_subsystem__defined
union __ReplyUnion__MXUIStatusBarMXUIStatusBar_subsystem {
	__Reply__GetStatusBarData_t Reply_MXUIStatusBarGetStatusBarData;
};
#endif /* !__RequestUnion__MXUIStatusBarMXUIStatusBar_subsystem__defined */

#ifndef subsystem_to_name_map_MXUIStatusBar
#define subsystem_to_name_map_MXUIStatusBar \
    { "GetStatusBarData", 33011 }
#endif

#ifdef __AfterMigUserHeader
__AfterMigUserHeader
#endif /* __AfterMigUserHeader */

#endif	 /* _MXUIStatusBar_user_ */
