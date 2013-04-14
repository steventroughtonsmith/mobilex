/*
 * IDENTIFICATION:
 * stub generated Sun Jan  1 08:55:29 2012
 * with a MiG generated Mon Aug 15 08:22:01 PDT 2011 by root@sundevil.apple.com
 * OPTIONS: 
 */
#define	__MIG_check__Reply__SpringBoardServices_subsystem__ 1
#define	__NDR_convert__Reply__SpringBoardServices_subsystem__ 1
#define	__NDR_convert__mig_reply_error_subsystem__ 1

#include "SpringBoardServices.h"


#ifndef	mig_internal
#define	mig_internal	static __inline__
#endif	/* mig_internal */

#ifndef	mig_external
#define mig_external
#endif	/* mig_external */

#if	!defined(__MigTypeCheck) && defined(TypeCheck)
#define	__MigTypeCheck		TypeCheck	/* Legacy setting */
#endif	/* !defined(__MigTypeCheck) */

#if	!defined(__MigKernelSpecificCode) && defined(_MIG_KERNEL_SPECIFIC_CODE_)
#define	__MigKernelSpecificCode	_MIG_KERNEL_SPECIFIC_CODE_	/* Legacy setting */
#endif	/* !defined(__MigKernelSpecificCode) */

#ifndef	LimitCheck
#define	LimitCheck 0
#endif	/* LimitCheck */

#ifndef	min
#define	min(a,b)  ( ((a) < (b))? (a): (b) )
#endif	/* min */

#if !defined(_WALIGN_)
#define _WALIGN_(x) (((x) + 3) & ~3)
#endif /* !defined(_WALIGN_) */

#if !defined(_WALIGNSZ_)
#define _WALIGNSZ_(x) _WALIGN_(sizeof(x))
#endif /* !defined(_WALIGNSZ_) */

#ifndef	UseStaticTemplates
#define	UseStaticTemplates	0
#endif	/* UseStaticTemplates */

#ifndef	__MachMsgErrorWithTimeout
#define	__MachMsgErrorWithTimeout(_R_) { \
	switch (_R_) { \
	case MACH_SEND_INVALID_DATA: \
	case MACH_SEND_INVALID_DEST: \
	case MACH_SEND_INVALID_HEADER: \
		mig_put_reply_port(InP->Head.msgh_reply_port); \
		break; \
	case MACH_SEND_TIMED_OUT: \
	case MACH_RCV_TIMED_OUT: \
	default: \
		mig_dealloc_reply_port(InP->Head.msgh_reply_port); \
	} \
}
#endif	/* __MachMsgErrorWithTimeout */

#ifndef	__MachMsgErrorWithoutTimeout
#define	__MachMsgErrorWithoutTimeout(_R_) { \
	switch (_R_) { \
	case MACH_SEND_INVALID_DATA: \
	case MACH_SEND_INVALID_DEST: \
	case MACH_SEND_INVALID_HEADER: \
		mig_put_reply_port(InP->Head.msgh_reply_port); \
		break; \
	default: \
		mig_dealloc_reply_port(InP->Head.msgh_reply_port); \
	} \
}
#endif	/* __MachMsgErrorWithoutTimeout */

#ifndef	__DeclareSendRpc
#define	__DeclareSendRpc(_NUM_, _NAME_)
#endif	/* __DeclareSendRpc */

#ifndef	__BeforeSendRpc
#define	__BeforeSendRpc(_NUM_, _NAME_)
#endif	/* __BeforeSendRpc */

#ifndef	__AfterSendRpc
#define	__AfterSendRpc(_NUM_, _NAME_)
#endif	/* __AfterSendRpc */

#ifndef	__DeclareSendSimple
#define	__DeclareSendSimple(_NUM_, _NAME_)
#endif	/* __DeclareSendSimple */

#ifndef	__BeforeSendSimple
#define	__BeforeSendSimple(_NUM_, _NAME_)
#endif	/* __BeforeSendSimple */

#ifndef	__AfterSendSimple
#define	__AfterSendSimple(_NUM_, _NAME_)
#endif	/* __AfterSendSimple */

#define msgh_request_port	msgh_remote_port
#define msgh_reply_port		msgh_local_port



#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Reply__SpringBoardServices_subsystem__
#if !defined(__MIG_check__Reply__AppWillOrderInContext_t__defined)
#define __MIG_check__Reply__AppWillOrderInContext_t__defined
#ifndef __NDR_convert__int_rep__Reply__AppWillOrderInContext_t__RetCode__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__kern_return_t__defined)
#define	__NDR_convert__int_rep__Reply__AppWillOrderInContext_t__RetCode__defined
#define	__NDR_convert__int_rep__Reply__AppWillOrderInContext_t__RetCode(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__kern_return_t((kern_return_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__kern_return_t__defined)
#define	__NDR_convert__int_rep__Reply__AppWillOrderInContext_t__RetCode__defined
#define	__NDR_convert__int_rep__Reply__AppWillOrderInContext_t__RetCode(a, f) \
	__NDR_convert__int_rep__kern_return_t((kern_return_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Reply__AppWillOrderInContext_t__RetCode__defined */





mig_internal kern_return_t __MIG_check__Reply__AppWillOrderInContext_t(__Reply__AppWillOrderInContext_t *Out0P)
{

	typedef __Reply__AppWillOrderInContext_t __Reply;
	if (Out0P->Head.msgh_id != 2000100) {
	    if (Out0P->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		{ return MIG_SERVER_DIED; }
	    else
		{ return MIG_REPLY_MISMATCH; }
	}

#if	__MigTypeCheck
	if ((Out0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (Out0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Reply)))
		{ return MIG_TYPE_ERROR ; }
#endif	/* __MigTypeCheck */

#if defined(__NDR_convert__int_rep__Reply__AppWillOrderInContext_t__RetCode__defined)
	if (Out0P->NDR.int_rep != NDR_record.int_rep)
		__NDR_convert__int_rep__Reply__AppWillOrderInContext_t__RetCode(&Out0P->RetCode, Out0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Reply__AppWillOrderInContext_t__RetCode__defined */
	{
		return Out0P->RetCode;
	}
}
#endif /* !defined(__MIG_check__Reply__AppWillOrderInContext_t__defined) */
#endif /* __MIG_check__Reply__SpringBoardServices_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine AppWillOrderInContext */
mig_external kern_return_t AppWillOrderInContext
(
	mach_port_t server,
	unsigned context,
	float windowLevel,
	int windowOutput
)
{

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		unsigned context;
		float windowLevel;
		int windowOutput;
	} Request;
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
		mach_msg_trailer_t trailer;
	} Reply;
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
	} __Reply;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	/*
	 * typedef struct {
	 * 	mach_msg_header_t Head;
	 * 	NDR_record_t NDR;
	 * 	kern_return_t RetCode;
	 * } mig_reply_error_t;
	 */

	union {
		Request In;
		Reply Out;
	} Mess;

	Request *InP = &Mess.In;
	Reply *Out0P = &Mess.Out;

	mach_msg_return_t msg_result;

#ifdef	__MIG_check__Reply__AppWillOrderInContext_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Reply__AppWillOrderInContext_t__defined */

	__DeclareSendRpc(2000000, "AppWillOrderInContext")

	InP->NDR = NDR_record;

	InP->context = context;

	InP->windowLevel = windowLevel;

	InP->windowOutput = windowOutput;

	InP->Head.msgh_bits =
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = server;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_id = 2000000;

	__BeforeSendRpc(2000000, "AppWillOrderInContext")
	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, (mach_msg_size_t)sizeof(Request), (mach_msg_size_t)sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	__AfterSendRpc(2000000, "AppWillOrderInContext")
	if (msg_result != MACH_MSG_SUCCESS) {
		__MachMsgErrorWithoutTimeout(msg_result);
		{ return msg_result; }
	}


#if	defined(__MIG_check__Reply__AppWillOrderInContext_t__defined)
	check_result = __MIG_check__Reply__AppWillOrderInContext_t((__Reply__AppWillOrderInContext_t *)Out0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ return check_result; }
#endif	/* defined(__MIG_check__Reply__AppWillOrderInContext_t__defined) */

	return KERN_SUCCESS;
}

#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Reply__SpringBoardServices_subsystem__
#if !defined(__MIG_check__Reply__AppDidOrderOutContext_t__defined)
#define __MIG_check__Reply__AppDidOrderOutContext_t__defined
#ifndef __NDR_convert__int_rep__Reply__AppDidOrderOutContext_t__RetCode__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__kern_return_t__defined)
#define	__NDR_convert__int_rep__Reply__AppDidOrderOutContext_t__RetCode__defined
#define	__NDR_convert__int_rep__Reply__AppDidOrderOutContext_t__RetCode(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__kern_return_t((kern_return_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__kern_return_t__defined)
#define	__NDR_convert__int_rep__Reply__AppDidOrderOutContext_t__RetCode__defined
#define	__NDR_convert__int_rep__Reply__AppDidOrderOutContext_t__RetCode(a, f) \
	__NDR_convert__int_rep__kern_return_t((kern_return_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Reply__AppDidOrderOutContext_t__RetCode__defined */





mig_internal kern_return_t __MIG_check__Reply__AppDidOrderOutContext_t(__Reply__AppDidOrderOutContext_t *Out0P)
{

	typedef __Reply__AppDidOrderOutContext_t __Reply;
	if (Out0P->Head.msgh_id != 2000101) {
	    if (Out0P->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		{ return MIG_SERVER_DIED; }
	    else
		{ return MIG_REPLY_MISMATCH; }
	}

#if	__MigTypeCheck
	if ((Out0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (Out0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Reply)))
		{ return MIG_TYPE_ERROR ; }
#endif	/* __MigTypeCheck */

#if defined(__NDR_convert__int_rep__Reply__AppDidOrderOutContext_t__RetCode__defined)
	if (Out0P->NDR.int_rep != NDR_record.int_rep)
		__NDR_convert__int_rep__Reply__AppDidOrderOutContext_t__RetCode(&Out0P->RetCode, Out0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Reply__AppDidOrderOutContext_t__RetCode__defined */
	{
		return Out0P->RetCode;
	}
}
#endif /* !defined(__MIG_check__Reply__AppDidOrderOutContext_t__defined) */
#endif /* __MIG_check__Reply__SpringBoardServices_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine AppDidOrderOutContext */
mig_external kern_return_t AppDidOrderOutContext
(
	mach_port_t server,
	unsigned context
)
{

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		unsigned context;
	} Request;
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
		mach_msg_trailer_t trailer;
	} Reply;
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
	} __Reply;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	/*
	 * typedef struct {
	 * 	mach_msg_header_t Head;
	 * 	NDR_record_t NDR;
	 * 	kern_return_t RetCode;
	 * } mig_reply_error_t;
	 */

	union {
		Request In;
		Reply Out;
	} Mess;

	Request *InP = &Mess.In;
	Reply *Out0P = &Mess.Out;

	mach_msg_return_t msg_result;

#ifdef	__MIG_check__Reply__AppDidOrderOutContext_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Reply__AppDidOrderOutContext_t__defined */

	__DeclareSendRpc(2000001, "AppDidOrderOutContext")

	InP->NDR = NDR_record;

	InP->context = context;

	InP->Head.msgh_bits =
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = server;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_id = 2000001;

	__BeforeSendRpc(2000001, "AppDidOrderOutContext")
	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, (mach_msg_size_t)sizeof(Request), (mach_msg_size_t)sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	__AfterSendRpc(2000001, "AppDidOrderOutContext")
	if (msg_result != MACH_MSG_SUCCESS) {
		__MachMsgErrorWithoutTimeout(msg_result);
		{ return msg_result; }
	}


#if	defined(__MIG_check__Reply__AppDidOrderOutContext_t__defined)
	check_result = __MIG_check__Reply__AppDidOrderOutContext_t((__Reply__AppDidOrderOutContext_t *)Out0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ return check_result; }
#endif	/* defined(__MIG_check__Reply__AppDidOrderOutContext_t__defined) */

	return KERN_SUCCESS;
}

#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Reply__SpringBoardServices_subsystem__
#if !defined(__MIG_check__Reply__LaunchApplicationWithIdentifier_t__defined)
#define __MIG_check__Reply__LaunchApplicationWithIdentifier_t__defined
#ifndef __NDR_convert__int_rep__Reply__LaunchApplicationWithIdentifier_t__RetCode__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__kern_return_t__defined)
#define	__NDR_convert__int_rep__Reply__LaunchApplicationWithIdentifier_t__RetCode__defined
#define	__NDR_convert__int_rep__Reply__LaunchApplicationWithIdentifier_t__RetCode(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__kern_return_t((kern_return_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__kern_return_t__defined)
#define	__NDR_convert__int_rep__Reply__LaunchApplicationWithIdentifier_t__RetCode__defined
#define	__NDR_convert__int_rep__Reply__LaunchApplicationWithIdentifier_t__RetCode(a, f) \
	__NDR_convert__int_rep__kern_return_t((kern_return_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Reply__LaunchApplicationWithIdentifier_t__RetCode__defined */





mig_internal kern_return_t __MIG_check__Reply__LaunchApplicationWithIdentifier_t(__Reply__LaunchApplicationWithIdentifier_t *Out0P)
{

	typedef __Reply__LaunchApplicationWithIdentifier_t __Reply;
	if (Out0P->Head.msgh_id != 2000103) {
	    if (Out0P->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		{ return MIG_SERVER_DIED; }
	    else
		{ return MIG_REPLY_MISMATCH; }
	}

#if	__MigTypeCheck
	if ((Out0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (Out0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Reply)))
		{ return MIG_TYPE_ERROR ; }
#endif	/* __MigTypeCheck */

#if defined(__NDR_convert__int_rep__Reply__LaunchApplicationWithIdentifier_t__RetCode__defined)
	if (Out0P->NDR.int_rep != NDR_record.int_rep)
		__NDR_convert__int_rep__Reply__LaunchApplicationWithIdentifier_t__RetCode(&Out0P->RetCode, Out0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Reply__LaunchApplicationWithIdentifier_t__RetCode__defined */
	{
		return Out0P->RetCode;
	}
}
#endif /* !defined(__MIG_check__Reply__LaunchApplicationWithIdentifier_t__defined) */
#endif /* __MIG_check__Reply__SpringBoardServices_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine LaunchApplicationWithIdentifier */
mig_external kern_return_t LaunchApplicationWithIdentifier
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
)
{

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
	} Request;
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
		mach_msg_trailer_t trailer;
	} Reply;
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
	} __Reply;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	/*
	 * typedef struct {
	 * 	mach_msg_header_t Head;
	 * 	NDR_record_t NDR;
	 * 	kern_return_t RetCode;
	 * } mig_reply_error_t;
	 */

	union {
		Request In;
		Reply Out;
	} Mess;

	Request *InP = &Mess.In;
	Reply *Out0P = &Mess.Out;

	mach_msg_return_t msg_result;
	unsigned int msgh_size;
	unsigned int msgh_size_delta;


#ifdef	__MIG_check__Reply__LaunchApplicationWithIdentifier_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Reply__LaunchApplicationWithIdentifier_t__defined */

	__DeclareSendRpc(2000003, "LaunchApplicationWithIdentifier")

	InP->NDR = NDR_record;

	InP->unk0 = unk0;

	InP->unk1 = unk1;

	InP->unk2 = unk2;

	InP->unk3 = unk3;

	InP->unk4 = unk4;

	InP->unk5 = unk5;

	InP->unk6 = unk6;

	InP->identifierCnt = mig_strncpy(InP->identifier, identifier, 1024);

	msgh_size_delta = _WALIGN_(InP->identifierCnt);
	msgh_size = (mach_msg_size_t)(sizeof(Request) - 1024) + msgh_size_delta;
	InP = (Request *) ((pointer_t) InP + msgh_size_delta - 1024);

	InP->suspended = suspended;

	InP->url = url;

	InP = &Mess.In;
	InP->Head.msgh_bits =
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = server;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_id = 2000003;

	__BeforeSendRpc(2000003, "LaunchApplicationWithIdentifier")
	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, msgh_size, (mach_msg_size_t)sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	__AfterSendRpc(2000003, "LaunchApplicationWithIdentifier")
	if (msg_result != MACH_MSG_SUCCESS) {
		__MachMsgErrorWithoutTimeout(msg_result);
		{ return msg_result; }
	}


#if	defined(__MIG_check__Reply__LaunchApplicationWithIdentifier_t__defined)
	check_result = __MIG_check__Reply__LaunchApplicationWithIdentifier_t((__Reply__LaunchApplicationWithIdentifier_t *)Out0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ return check_result; }
#endif	/* defined(__MIG_check__Reply__LaunchApplicationWithIdentifier_t__defined) */

	return KERN_SUCCESS;
}

#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Reply__SpringBoardServices_subsystem__
#if !defined(__MIG_check__Reply__RegisterStatusBarWindowContextId_t__defined)
#define __MIG_check__Reply__RegisterStatusBarWindowContextId_t__defined
#ifndef __NDR_convert__int_rep__Reply__RegisterStatusBarWindowContextId_t__RetCode__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__kern_return_t__defined)
#define	__NDR_convert__int_rep__Reply__RegisterStatusBarWindowContextId_t__RetCode__defined
#define	__NDR_convert__int_rep__Reply__RegisterStatusBarWindowContextId_t__RetCode(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__kern_return_t((kern_return_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__kern_return_t__defined)
#define	__NDR_convert__int_rep__Reply__RegisterStatusBarWindowContextId_t__RetCode__defined
#define	__NDR_convert__int_rep__Reply__RegisterStatusBarWindowContextId_t__RetCode(a, f) \
	__NDR_convert__int_rep__kern_return_t((kern_return_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Reply__RegisterStatusBarWindowContextId_t__RetCode__defined */





mig_internal kern_return_t __MIG_check__Reply__RegisterStatusBarWindowContextId_t(__Reply__RegisterStatusBarWindowContextId_t *Out0P)
{

	typedef __Reply__RegisterStatusBarWindowContextId_t __Reply;
	if (Out0P->Head.msgh_id != 2000122) {
	    if (Out0P->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		{ return MIG_SERVER_DIED; }
	    else
		{ return MIG_REPLY_MISMATCH; }
	}

#if	__MigTypeCheck
	if ((Out0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (Out0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Reply)))
		{ return MIG_TYPE_ERROR ; }
#endif	/* __MigTypeCheck */

#if defined(__NDR_convert__int_rep__Reply__RegisterStatusBarWindowContextId_t__RetCode__defined)
	if (Out0P->NDR.int_rep != NDR_record.int_rep)
		__NDR_convert__int_rep__Reply__RegisterStatusBarWindowContextId_t__RetCode(&Out0P->RetCode, Out0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Reply__RegisterStatusBarWindowContextId_t__RetCode__defined */
	{
		return Out0P->RetCode;
	}
}
#endif /* !defined(__MIG_check__Reply__RegisterStatusBarWindowContextId_t__defined) */
#endif /* __MIG_check__Reply__SpringBoardServices_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine RegisterStatusBarWindowContextId */
mig_external kern_return_t RegisterStatusBarWindowContextId
(
	mach_port_t server,
	unsigned context
)
{

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		unsigned context;
	} Request;
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
		mach_msg_trailer_t trailer;
	} Reply;
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
	} __Reply;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	/*
	 * typedef struct {
	 * 	mach_msg_header_t Head;
	 * 	NDR_record_t NDR;
	 * 	kern_return_t RetCode;
	 * } mig_reply_error_t;
	 */

	union {
		Request In;
		Reply Out;
	} Mess;

	Request *InP = &Mess.In;
	Reply *Out0P = &Mess.Out;

	mach_msg_return_t msg_result;

#ifdef	__MIG_check__Reply__RegisterStatusBarWindowContextId_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Reply__RegisterStatusBarWindowContextId_t__defined */

	__DeclareSendRpc(2000022, "RegisterStatusBarWindowContextId")

	InP->NDR = NDR_record;

	InP->context = context;

	InP->Head.msgh_bits =
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = server;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_id = 2000022;

	__BeforeSendRpc(2000022, "RegisterStatusBarWindowContextId")
	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, (mach_msg_size_t)sizeof(Request), (mach_msg_size_t)sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	__AfterSendRpc(2000022, "RegisterStatusBarWindowContextId")
	if (msg_result != MACH_MSG_SUCCESS) {
		__MachMsgErrorWithoutTimeout(msg_result);
		{ return msg_result; }
	}


#if	defined(__MIG_check__Reply__RegisterStatusBarWindowContextId_t__defined)
	check_result = __MIG_check__Reply__RegisterStatusBarWindowContextId_t((__Reply__RegisterStatusBarWindowContextId_t *)Out0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ return check_result; }
#endif	/* defined(__MIG_check__Reply__RegisterStatusBarWindowContextId_t__defined) */

	return KERN_SUCCESS;
}

#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Reply__SpringBoardServices_subsystem__
#if !defined(__MIG_check__Reply__CheckInTaskPort_t__defined)
#define __MIG_check__Reply__CheckInTaskPort_t__defined
#ifndef __NDR_convert__int_rep__Reply__CheckInTaskPort_t__RetCode__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__kern_return_t__defined)
#define	__NDR_convert__int_rep__Reply__CheckInTaskPort_t__RetCode__defined
#define	__NDR_convert__int_rep__Reply__CheckInTaskPort_t__RetCode(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__kern_return_t((kern_return_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__kern_return_t__defined)
#define	__NDR_convert__int_rep__Reply__CheckInTaskPort_t__RetCode__defined
#define	__NDR_convert__int_rep__Reply__CheckInTaskPort_t__RetCode(a, f) \
	__NDR_convert__int_rep__kern_return_t((kern_return_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Reply__CheckInTaskPort_t__RetCode__defined */





mig_internal kern_return_t __MIG_check__Reply__CheckInTaskPort_t(__Reply__CheckInTaskPort_t *Out0P)
{

	typedef __Reply__CheckInTaskPort_t __Reply;
	if (Out0P->Head.msgh_id != 2000218) {
	    if (Out0P->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		{ return MIG_SERVER_DIED; }
	    else
		{ return MIG_REPLY_MISMATCH; }
	}

#if	__MigTypeCheck
	if ((Out0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (Out0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Reply)))
		{ return MIG_TYPE_ERROR ; }
#endif	/* __MigTypeCheck */

#if defined(__NDR_convert__int_rep__Reply__CheckInTaskPort_t__RetCode__defined)
	if (Out0P->NDR.int_rep != NDR_record.int_rep)
		__NDR_convert__int_rep__Reply__CheckInTaskPort_t__RetCode(&Out0P->RetCode, Out0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Reply__CheckInTaskPort_t__RetCode__defined */
	{
		return Out0P->RetCode;
	}
}
#endif /* !defined(__MIG_check__Reply__CheckInTaskPort_t__defined) */
#endif /* __MIG_check__Reply__SpringBoardServices_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine CheckInTaskPort */
mig_external kern_return_t CheckInTaskPort
(
	mach_port_t server,
	int one,
	int two,
	int thr,
	int fr
)
{

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
	} Request;
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
		mach_msg_trailer_t trailer;
	} Reply;
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
	} __Reply;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	/*
	 * typedef struct {
	 * 	mach_msg_header_t Head;
	 * 	NDR_record_t NDR;
	 * 	kern_return_t RetCode;
	 * } mig_reply_error_t;
	 */

	union {
		Request In;
		Reply Out;
	} Mess;

	Request *InP = &Mess.In;
	Reply *Out0P = &Mess.Out;

	mach_msg_return_t msg_result;

#ifdef	__MIG_check__Reply__CheckInTaskPort_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Reply__CheckInTaskPort_t__defined */

	__DeclareSendRpc(2000118, "CheckInTaskPort")

	InP->NDR = NDR_record;

	InP->one = one;

	InP->two = two;

	InP->thr = thr;

	InP->fr = fr;

	InP->Head.msgh_bits =
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = server;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_id = 2000118;

	__BeforeSendRpc(2000118, "CheckInTaskPort")
	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, (mach_msg_size_t)sizeof(Request), (mach_msg_size_t)sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	__AfterSendRpc(2000118, "CheckInTaskPort")
	if (msg_result != MACH_MSG_SUCCESS) {
		__MachMsgErrorWithoutTimeout(msg_result);
		{ return msg_result; }
	}


#if	defined(__MIG_check__Reply__CheckInTaskPort_t__defined)
	check_result = __MIG_check__Reply__CheckInTaskPort_t((__Reply__CheckInTaskPort_t *)Out0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ return check_result; }
#endif	/* defined(__MIG_check__Reply__CheckInTaskPort_t__defined) */

	return KERN_SUCCESS;
}

#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Reply__SpringBoardServices_subsystem__
#if !defined(__MIG_check__Reply__RegisterRemoteView_t__defined)
#define __MIG_check__Reply__RegisterRemoteView_t__defined
#ifndef __NDR_convert__int_rep__Reply__RegisterRemoteView_t__RetCode__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__kern_return_t__defined)
#define	__NDR_convert__int_rep__Reply__RegisterRemoteView_t__RetCode__defined
#define	__NDR_convert__int_rep__Reply__RegisterRemoteView_t__RetCode(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__kern_return_t((kern_return_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__kern_return_t__defined)
#define	__NDR_convert__int_rep__Reply__RegisterRemoteView_t__RetCode__defined
#define	__NDR_convert__int_rep__Reply__RegisterRemoteView_t__RetCode(a, f) \
	__NDR_convert__int_rep__kern_return_t((kern_return_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Reply__RegisterRemoteView_t__RetCode__defined */





mig_internal kern_return_t __MIG_check__Reply__RegisterRemoteView_t(__Reply__RegisterRemoteView_t *Out0P)
{

	typedef __Reply__RegisterRemoteView_t __Reply;
	if (Out0P->Head.msgh_id != 2000220) {
	    if (Out0P->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		{ return MIG_SERVER_DIED; }
	    else
		{ return MIG_REPLY_MISMATCH; }
	}

#if	__MigTypeCheck
	if ((Out0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (Out0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Reply)))
		{ return MIG_TYPE_ERROR ; }
#endif	/* __MigTypeCheck */

#if defined(__NDR_convert__int_rep__Reply__RegisterRemoteView_t__RetCode__defined)
	if (Out0P->NDR.int_rep != NDR_record.int_rep)
		__NDR_convert__int_rep__Reply__RegisterRemoteView_t__RetCode(&Out0P->RetCode, Out0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Reply__RegisterRemoteView_t__RetCode__defined */
	{
		return Out0P->RetCode;
	}
}
#endif /* !defined(__MIG_check__Reply__RegisterRemoteView_t__defined) */
#endif /* __MIG_check__Reply__SpringBoardServices_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine RegisterRemoteView */
mig_external kern_return_t RegisterRemoteView
(
	mach_port_t server,
	int one,
	int two
)
{

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		int one;
		int two;
	} Request;
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
		mach_msg_trailer_t trailer;
	} Reply;
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
	} __Reply;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	/*
	 * typedef struct {
	 * 	mach_msg_header_t Head;
	 * 	NDR_record_t NDR;
	 * 	kern_return_t RetCode;
	 * } mig_reply_error_t;
	 */

	union {
		Request In;
		Reply Out;
	} Mess;

	Request *InP = &Mess.In;
	Reply *Out0P = &Mess.Out;

	mach_msg_return_t msg_result;

#ifdef	__MIG_check__Reply__RegisterRemoteView_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Reply__RegisterRemoteView_t__defined */

	__DeclareSendRpc(2000120, "RegisterRemoteView")

	InP->NDR = NDR_record;

	InP->one = one;

	InP->two = two;

	InP->Head.msgh_bits =
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = server;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_id = 2000120;

	__BeforeSendRpc(2000120, "RegisterRemoteView")
	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, (mach_msg_size_t)sizeof(Request), (mach_msg_size_t)sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	__AfterSendRpc(2000120, "RegisterRemoteView")
	if (msg_result != MACH_MSG_SUCCESS) {
		__MachMsgErrorWithoutTimeout(msg_result);
		{ return msg_result; }
	}


#if	defined(__MIG_check__Reply__RegisterRemoteView_t__defined)
	check_result = __MIG_check__Reply__RegisterRemoteView_t((__Reply__RegisterRemoteView_t *)Out0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ return check_result; }
#endif	/* defined(__MIG_check__Reply__RegisterRemoteView_t__defined) */

	return KERN_SUCCESS;
}
