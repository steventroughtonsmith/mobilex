/*
 * IDENTIFICATION:
 * stub generated Sun Jan  1 00:22:18 2012
 * with a MiG generated Mon Aug 15 08:22:01 PDT 2011 by root@sundevil.apple.com
 * OPTIONS: 
 */

/* Module MobileXRPC */

#define	__MIG_check__Request__MobileXRPC_subsystem__ 1
#define	__NDR_convert__Request__MobileXRPC_subsystem__ 1

#include <string.h>
#include <mach/ndr.h>
#include <mach/boolean.h>
#include <mach/kern_return.h>
#include <mach/notify.h>
#include <mach/mach_types.h>
#include <mach/message.h>
#include <mach/mig_errors.h>
#include <mach/port.h>

#include <mach/std_types.h>
#include <mach/mig.h>
#include <mach/mig.h>
#include <mach/mach_types.h>
#include "MXRPCCommon.h"

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

#ifndef	__DeclareRcvRpc
#define	__DeclareRcvRpc(_NUM_, _NAME_)
#endif	/* __DeclareRcvRpc */

#ifndef	__BeforeRcvRpc
#define	__BeforeRcvRpc(_NUM_, _NAME_)
#endif	/* __BeforeRcvRpc */

#ifndef	__AfterRcvRpc
#define	__AfterRcvRpc(_NUM_, _NAME_)
#endif	/* __AfterRcvRpc */

#ifndef	__DeclareRcvSimple
#define	__DeclareRcvSimple(_NUM_, _NAME_)
#endif	/* __DeclareRcvSimple */

#ifndef	__BeforeRcvSimple
#define	__BeforeRcvSimple(_NUM_, _NAME_)
#endif	/* __BeforeRcvSimple */

#ifndef	__AfterRcvSimple
#define	__AfterRcvSimple(_NUM_, _NAME_)
#endif	/* __AfterRcvSimple */

#define novalue void

#define msgh_request_port	msgh_local_port
#define MACH_MSGH_BITS_REQUEST(bits)	MACH_MSGH_BITS_LOCAL(bits)
#define msgh_reply_port		msgh_remote_port
#define MACH_MSGH_BITS_REPLY(bits)	MACH_MSGH_BITS_REMOTE(bits)

#define MIG_RETURN_ERROR(X, code)	{\
				((mig_reply_error_t *)X)->RetCode = code;\
				((mig_reply_error_t *)X)->NDR = NDR_record;\
				return;\
				}

/* typedefs for all requests */

#ifndef __Request__MobileXRPC_subsystem__defined
#define __Request__MobileXRPC_subsystem__defined

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
	} __Request__CopyApplicationList_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		mach_msg_type_number_t identifierOffset; /* MiG doesn't use it */
		mach_msg_type_number_t identifierCnt;
		char identifier[1024];
	} __Request__LaunchApplication_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		boolean_t isFullscreen;
		integer_t windowLevel;
		boolean_t shouldOffsetizeContext;
		boolean_t keepAlive;
		float contextSizeWidth;
		float contextSizeHeight;
		float contextOriginX;
		float contextOriginY;
	} __Request__CheckIn_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
	} __Request__CopyScreenDimensions_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		integer_t selector;
	} __Request__CallMethod_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif
#endif /* !__Request__MobileXRPC_subsystem__defined */

/* typedefs for all replies */

#ifndef __Reply__MobileXRPC_subsystem__defined
#define __Reply__MobileXRPC_subsystem__defined

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
	} __Reply__CopyApplicationList_t;
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
	} __Reply__LaunchApplication_t;
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
	} __Reply__CheckIn_t;
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
		integer_t width;
		integer_t height;
	} __Reply__CopyScreenDimensions_t;
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
	} __Reply__CallMethod_t;
#ifdef  __MigPackStructs
#pragma pack()
#endif
#endif /* !__Reply__MobileXRPC_subsystem__defined */


/* union of all replies */

#ifndef __ReplyUnion___MXRPCCall_MobileXRPC_subsystem__defined
#define __ReplyUnion___MXRPCCall_MobileXRPC_subsystem__defined
union __ReplyUnion___MXRPCCall_MobileXRPC_subsystem {
	__Reply__CopyApplicationList_t Reply_CopyApplicationList;
	__Reply__LaunchApplication_t Reply_LaunchApplication;
	__Reply__CheckIn_t Reply_CheckIn;
	__Reply__CopyScreenDimensions_t Reply_CopyScreenDimensions;
	__Reply__CallMethod_t Reply_CallMethod;
};
#endif /* __RequestUnion___MXRPCCall_MobileXRPC_subsystem__defined */
/* Forward Declarations */


mig_internal novalue _XCopyApplicationList
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP);

mig_internal novalue _XLaunchApplication
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP);

mig_internal novalue _XCheckIn
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP);

mig_internal novalue _XCopyScreenDimensions
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP);

mig_internal novalue _XCallMethod
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP);


#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Request__MobileXRPC_subsystem__
#if !defined(__MIG_check__Request__CopyApplicationList_t__defined)
#define __MIG_check__Request__CopyApplicationList_t__defined

mig_internal kern_return_t __MIG_check__Request__CopyApplicationList_t(__attribute__((__unused__)) __Request__CopyApplicationList_t *In0P)
{

	typedef __Request__CopyApplicationList_t __Request;
#if	__MigTypeCheck
	if ((In0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (In0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Request)))
		return MIG_BAD_ARGUMENTS;
#endif	/* __MigTypeCheck */

	return MACH_MSG_SUCCESS;
}
#endif /* !defined(__MIG_check__Request__CopyApplicationList_t__defined) */
#endif /* __MIG_check__Request__MobileXRPC_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine CopyApplicationList */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t _MXRPCCall_CopyApplicationList
(
	mach_port_t server,
	serialized_t *list,
	mach_msg_type_number_t *listCnt,
	audit_token_t token
);

/* Routine CopyApplicationList */
mig_internal novalue _XCopyApplicationList
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP)
{

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		mach_msg_max_trailer_t trailer;
	} Request;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	typedef __Request__CopyApplicationList_t __Request;
	typedef __Reply__CopyApplicationList_t Reply;

	/*
	 * typedef struct {
	 * 	mach_msg_header_t Head;
	 * 	NDR_record_t NDR;
	 * 	kern_return_t RetCode;
	 * } mig_reply_error_t;
	 */

	Request *In0P = (Request *) InHeadP;
	Reply *OutP = (Reply *) OutHeadP;
	mach_msg_max_trailer_t *TrailerP;
#if	__MigTypeCheck
	unsigned int trailer_size;
#endif	/* __MigTypeCheck */
#ifdef	__MIG_check__Request__CopyApplicationList_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Request__CopyApplicationList_t__defined */

#if	UseStaticTemplates
	const static mach_msg_ool_descriptor_t listTemplate = {
		/* addr = */		(void *)0,
		/* size = */		0,
		/* deal = */		FALSE,
		/* copy = */		MACH_MSG_VIRTUAL_COPY,
		/* pad2 = */		0,
		/* type = */		MACH_MSG_OOL_DESCRIPTOR,
	};
#endif	/* UseStaticTemplates */

	kern_return_t RetCode;
	__DeclareRcvRpc(70300, "CopyApplicationList")
	__BeforeRcvRpc(70300, "CopyApplicationList")

#if	defined(__MIG_check__Request__CopyApplicationList_t__defined)
	check_result = __MIG_check__Request__CopyApplicationList_t((__Request *)In0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ MIG_RETURN_ERROR(OutP, check_result); }
#endif	/* defined(__MIG_check__Request__CopyApplicationList_t__defined) */

	TrailerP = (mach_msg_max_trailer_t *)((vm_offset_t)In0P +
		round_msg(In0P->Head.msgh_size));
	if (TrailerP->msgh_trailer_type != MACH_MSG_TRAILER_FORMAT_0)
		{ MIG_RETURN_ERROR(In0P, MIG_TRAILER_ERROR); }
#if	__MigTypeCheck
	trailer_size = TrailerP->msgh_trailer_size -
		(mach_msg_size_t)(sizeof(mach_msg_trailer_type_t) - sizeof(mach_msg_trailer_size_t));
#endif	/* __MigTypeCheck */
#if	__MigTypeCheck
	if (trailer_size < (mach_msg_size_t)sizeof(audit_token_t))
		{ MIG_RETURN_ERROR(OutP, MIG_TRAILER_ERROR); }
	trailer_size -= (mach_msg_size_t)sizeof(audit_token_t);
#endif	/* __MigTypeCheck */
#if	UseStaticTemplates
	OutP->list = listTemplate;
#else	/* UseStaticTemplates */
	OutP->list.deallocate =  FALSE;
	OutP->list.copy = MACH_MSG_VIRTUAL_COPY;
	OutP->list.type = MACH_MSG_OOL_DESCRIPTOR;
#endif	/* UseStaticTemplates */


	RetCode = _MXRPCCall_CopyApplicationList(In0P->Head.msgh_request_port, (serialized_t *)&(OutP->list.address), &OutP->listCnt, TrailerP->msgh_audit);
	if (RetCode != KERN_SUCCESS) {
		MIG_RETURN_ERROR(OutP, RetCode);
	}
	OutP->list.size = OutP->listCnt;


	OutP->NDR = NDR_record;


	OutP->Head.msgh_bits |= MACH_MSGH_BITS_COMPLEX;
	OutP->Head.msgh_size = (mach_msg_size_t)(sizeof(Reply));
	OutP->msgh_body.msgh_descriptor_count = 1;
	__AfterRcvRpc(70300, "CopyApplicationList")
}

#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Request__MobileXRPC_subsystem__
#if !defined(__MIG_check__Request__LaunchApplication_t__defined)
#define __MIG_check__Request__LaunchApplication_t__defined
#ifndef __NDR_convert__int_rep__Request__LaunchApplication_t__identifier__defined
#if	defined(__NDR_convert__int_rep__MobileXRPC__string_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplication_t__identifier__defined
#define	__NDR_convert__int_rep__Request__LaunchApplication_t__identifier(a, f, c) \
	__NDR_convert__int_rep__MobileXRPC__string_t((string_t *)(a), f, c)
#elif	defined(__NDR_convert__int_rep__string_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplication_t__identifier__defined
#define	__NDR_convert__int_rep__Request__LaunchApplication_t__identifier(a, f, c) \
	__NDR_convert__int_rep__string_t((string_t *)(a), f, c)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__LaunchApplication_t__identifier__defined */

#ifndef __NDR_convert__int_rep__Request__LaunchApplication_t__identifierCnt__defined
#if	defined(__NDR_convert__int_rep__MobileXRPC__mach_msg_type_number_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplication_t__identifierCnt__defined
#define	__NDR_convert__int_rep__Request__LaunchApplication_t__identifierCnt(a, f) \
	__NDR_convert__int_rep__MobileXRPC__mach_msg_type_number_t((mach_msg_type_number_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__mach_msg_type_number_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplication_t__identifierCnt__defined
#define	__NDR_convert__int_rep__Request__LaunchApplication_t__identifierCnt(a, f) \
	__NDR_convert__int_rep__mach_msg_type_number_t((mach_msg_type_number_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__LaunchApplication_t__identifierCnt__defined */

#ifndef __NDR_convert__char_rep__Request__LaunchApplication_t__identifier__defined
#if	defined(__NDR_convert__char_rep__MobileXRPC__string_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplication_t__identifier__defined
#define	__NDR_convert__char_rep__Request__LaunchApplication_t__identifier(a, f, c) \
	__NDR_convert__char_rep__MobileXRPC__string_t((string_t *)(a), f, c)
#elif	defined(__NDR_convert__char_rep__string_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplication_t__identifier__defined
#define	__NDR_convert__char_rep__Request__LaunchApplication_t__identifier(a, f, c) \
	__NDR_convert__char_rep__string_t((string_t *)(a), f, c)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__LaunchApplication_t__identifier__defined */

#ifndef __NDR_convert__float_rep__Request__LaunchApplication_t__identifier__defined
#if	defined(__NDR_convert__float_rep__MobileXRPC__string_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplication_t__identifier__defined
#define	__NDR_convert__float_rep__Request__LaunchApplication_t__identifier(a, f, c) \
	__NDR_convert__float_rep__MobileXRPC__string_t((string_t *)(a), f, c)
#elif	defined(__NDR_convert__float_rep__string_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplication_t__identifier__defined
#define	__NDR_convert__float_rep__Request__LaunchApplication_t__identifier(a, f, c) \
	__NDR_convert__float_rep__string_t((string_t *)(a), f, c)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__LaunchApplication_t__identifier__defined */


mig_internal kern_return_t __MIG_check__Request__LaunchApplication_t(__attribute__((__unused__)) __Request__LaunchApplication_t *In0P)
{

	typedef __Request__LaunchApplication_t __Request;
#if	__MigTypeCheck
	unsigned int msgh_size;
#endif	/* __MigTypeCheck */

#if	__MigTypeCheck
	msgh_size = In0P->Head.msgh_size;
	if ((In0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (msgh_size < (mach_msg_size_t)(sizeof(__Request) - 1024)) ||  (msgh_size > (mach_msg_size_t)sizeof(__Request)))
		return MIG_BAD_ARGUMENTS;
#endif	/* __MigTypeCheck */

#if defined(__NDR_convert__int_rep__Request__LaunchApplication_t__identifierCnt__defined)
	if (In0P->NDR.int_rep != NDR_record.int_rep)
		__NDR_convert__int_rep__Request__LaunchApplication_t__identifierCnt(&In0P->identifierCnt, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__LaunchApplication_t__identifierCnt__defined */
#if	__MigTypeCheck
	if ( In0P->identifierCnt > 1024 )
		return MIG_BAD_ARGUMENTS;
	if (((msgh_size - (mach_msg_size_t)(sizeof(__Request) - 1024)) != _WALIGN_(In0P->identifierCnt)) ||
	    (msgh_size != (mach_msg_size_t)(sizeof(__Request) - 1024) + _WALIGN_(In0P->identifierCnt)))
		return MIG_BAD_ARGUMENTS;
#endif	/* __MigTypeCheck */

#if	defined(__NDR_convert__int_rep__Request__LaunchApplication_t__identifier__defined) || \
	defined(__NDR_convert__int_rep__Request__LaunchApplication_t__identifierCnt__defined)
	if (In0P->NDR.int_rep != NDR_record.int_rep) {
#if defined(__NDR_convert__int_rep__Request__LaunchApplication_t__identifier__defined)
		__NDR_convert__int_rep__Request__LaunchApplication_t__identifier(&In0P->identifier, In0P->NDR.int_rep, In0P->identifierCnt);
#endif	/* __NDR_convert__int_rep__Request__LaunchApplication_t__identifier__defined */
	}
#endif	/* defined(__NDR_convert__int_rep...) */

#if	defined(__NDR_convert__char_rep__Request__LaunchApplication_t__identifier__defined) || \
	0
	if (In0P->NDR.char_rep != NDR_record.char_rep) {
#if defined(__NDR_convert__char_rep__Request__LaunchApplication_t__identifier__defined)
		__NDR_convert__char_rep__Request__LaunchApplication_t__identifier(&In0P->identifier, In0P->NDR.char_rep, In0P->identifierCnt);
#endif	/* __NDR_convert__char_rep__Request__LaunchApplication_t__identifier__defined */
	}
#endif	/* defined(__NDR_convert__char_rep...) */

#if	defined(__NDR_convert__float_rep__Request__LaunchApplication_t__identifier__defined) || \
	0
	if (In0P->NDR.float_rep != NDR_record.float_rep) {
#if defined(__NDR_convert__float_rep__Request__LaunchApplication_t__identifier__defined)
		__NDR_convert__float_rep__Request__LaunchApplication_t__identifier(&In0P->identifier, In0P->NDR.float_rep, In0P->identifierCnt);
#endif	/* __NDR_convert__float_rep__Request__LaunchApplication_t__identifier__defined */
	}
#endif	/* defined(__NDR_convert__float_rep...) */

#if __MigTypeCheck
	{
		char * msg_limit = ((char *) In0P) + In0P->Head.msgh_size;
		size_t memchr_limit;

		memchr_limit = min((msg_limit - In0P->identifier),  1024);
		if (( memchr(In0P->identifier, '\0', memchr_limit) == NULL ))
			return MIG_BAD_ARGUMENTS; // string length exceeds buffer length!
	}
#endif	/* __MigTypeCheck */

	return MACH_MSG_SUCCESS;
}
#endif /* !defined(__MIG_check__Request__LaunchApplication_t__defined) */
#endif /* __MIG_check__Request__MobileXRPC_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine LaunchApplication */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t _MXRPCCall_LaunchApplication
(
	mach_port_t server,
	string_t identifier,
	audit_token_t token
);

/* Routine LaunchApplication */
mig_internal novalue _XLaunchApplication
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP)
{

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		mach_msg_type_number_t identifierOffset; /* MiG doesn't use it */
		mach_msg_type_number_t identifierCnt;
		char identifier[1024];
		mach_msg_max_trailer_t trailer;
	} Request;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	typedef __Request__LaunchApplication_t __Request;
	typedef __Reply__LaunchApplication_t Reply;

	/*
	 * typedef struct {
	 * 	mach_msg_header_t Head;
	 * 	NDR_record_t NDR;
	 * 	kern_return_t RetCode;
	 * } mig_reply_error_t;
	 */

	Request *In0P = (Request *) InHeadP;
	Reply *OutP = (Reply *) OutHeadP;
	mach_msg_max_trailer_t *TrailerP;
#if	__MigTypeCheck
	unsigned int trailer_size;
#endif	/* __MigTypeCheck */
#ifdef	__MIG_check__Request__LaunchApplication_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Request__LaunchApplication_t__defined */

	__DeclareRcvRpc(70301, "LaunchApplication")
	__BeforeRcvRpc(70301, "LaunchApplication")

#if	defined(__MIG_check__Request__LaunchApplication_t__defined)
	check_result = __MIG_check__Request__LaunchApplication_t((__Request *)In0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ MIG_RETURN_ERROR(OutP, check_result); }
#endif	/* defined(__MIG_check__Request__LaunchApplication_t__defined) */

	TrailerP = (mach_msg_max_trailer_t *)((vm_offset_t)In0P +
		round_msg(In0P->Head.msgh_size));
	if (TrailerP->msgh_trailer_type != MACH_MSG_TRAILER_FORMAT_0)
		{ MIG_RETURN_ERROR(In0P, MIG_TRAILER_ERROR); }
#if	__MigTypeCheck
	trailer_size = TrailerP->msgh_trailer_size -
		(mach_msg_size_t)(sizeof(mach_msg_trailer_type_t) - sizeof(mach_msg_trailer_size_t));
#endif	/* __MigTypeCheck */
#if	__MigTypeCheck
	if (trailer_size < (mach_msg_size_t)sizeof(audit_token_t))
		{ MIG_RETURN_ERROR(OutP, MIG_TRAILER_ERROR); }
	trailer_size -= (mach_msg_size_t)sizeof(audit_token_t);
#endif	/* __MigTypeCheck */
	OutP->RetCode = _MXRPCCall_LaunchApplication(In0P->Head.msgh_request_port, In0P->identifier, TrailerP->msgh_audit);

	OutP->NDR = NDR_record;


	__AfterRcvRpc(70301, "LaunchApplication")
}

#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Request__MobileXRPC_subsystem__
#if !defined(__MIG_check__Request__CheckIn_t__defined)
#define __MIG_check__Request__CheckIn_t__defined
#ifndef __NDR_convert__int_rep__Request__CheckIn_t__isFullscreen__defined
#if	defined(__NDR_convert__int_rep__MobileXRPC__boolean_t__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__isFullscreen__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__isFullscreen(a, f) \
	__NDR_convert__int_rep__MobileXRPC__boolean_t((boolean_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__boolean_t__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__isFullscreen__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__isFullscreen(a, f) \
	__NDR_convert__int_rep__boolean_t((boolean_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__CheckIn_t__isFullscreen__defined */

#ifndef __NDR_convert__int_rep__Request__CheckIn_t__windowLevel__defined
#if	defined(__NDR_convert__int_rep__MobileXRPC__integer_t__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__windowLevel__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__windowLevel(a, f) \
	__NDR_convert__int_rep__MobileXRPC__integer_t((integer_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__integer_t__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__windowLevel__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__windowLevel(a, f) \
	__NDR_convert__int_rep__integer_t((integer_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__MobileXRPC__int32_t__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__windowLevel__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__windowLevel(a, f) \
	__NDR_convert__int_rep__MobileXRPC__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__windowLevel__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__windowLevel(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__CheckIn_t__windowLevel__defined */

#ifndef __NDR_convert__int_rep__Request__CheckIn_t__shouldOffsetizeContext__defined
#if	defined(__NDR_convert__int_rep__MobileXRPC__boolean_t__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__shouldOffsetizeContext__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__shouldOffsetizeContext(a, f) \
	__NDR_convert__int_rep__MobileXRPC__boolean_t((boolean_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__boolean_t__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__shouldOffsetizeContext__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__shouldOffsetizeContext(a, f) \
	__NDR_convert__int_rep__boolean_t((boolean_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__CheckIn_t__shouldOffsetizeContext__defined */

#ifndef __NDR_convert__int_rep__Request__CheckIn_t__keepAlive__defined
#if	defined(__NDR_convert__int_rep__MobileXRPC__boolean_t__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__keepAlive__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__keepAlive(a, f) \
	__NDR_convert__int_rep__MobileXRPC__boolean_t((boolean_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__boolean_t__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__keepAlive__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__keepAlive(a, f) \
	__NDR_convert__int_rep__boolean_t((boolean_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__CheckIn_t__keepAlive__defined */

#ifndef __NDR_convert__int_rep__Request__CheckIn_t__contextSizeWidth__defined
#if	defined(__NDR_convert__int_rep__MobileXRPC__float__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextSizeWidth__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextSizeWidth(a, f) \
	__NDR_convert__int_rep__MobileXRPC__float((float *)(a), f)
#elif	defined(__NDR_convert__int_rep__float__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextSizeWidth__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextSizeWidth(a, f) \
	__NDR_convert__int_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__CheckIn_t__contextSizeWidth__defined */

#ifndef __NDR_convert__int_rep__Request__CheckIn_t__contextSizeHeight__defined
#if	defined(__NDR_convert__int_rep__MobileXRPC__float__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextSizeHeight__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextSizeHeight(a, f) \
	__NDR_convert__int_rep__MobileXRPC__float((float *)(a), f)
#elif	defined(__NDR_convert__int_rep__float__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextSizeHeight__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextSizeHeight(a, f) \
	__NDR_convert__int_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__CheckIn_t__contextSizeHeight__defined */

#ifndef __NDR_convert__int_rep__Request__CheckIn_t__contextOriginX__defined
#if	defined(__NDR_convert__int_rep__MobileXRPC__float__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextOriginX__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextOriginX(a, f) \
	__NDR_convert__int_rep__MobileXRPC__float((float *)(a), f)
#elif	defined(__NDR_convert__int_rep__float__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextOriginX__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextOriginX(a, f) \
	__NDR_convert__int_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__CheckIn_t__contextOriginX__defined */

#ifndef __NDR_convert__int_rep__Request__CheckIn_t__contextOriginY__defined
#if	defined(__NDR_convert__int_rep__MobileXRPC__float__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextOriginY__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextOriginY(a, f) \
	__NDR_convert__int_rep__MobileXRPC__float((float *)(a), f)
#elif	defined(__NDR_convert__int_rep__float__defined)
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextOriginY__defined
#define	__NDR_convert__int_rep__Request__CheckIn_t__contextOriginY(a, f) \
	__NDR_convert__int_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__CheckIn_t__contextOriginY__defined */

#ifndef __NDR_convert__char_rep__Request__CheckIn_t__isFullscreen__defined
#if	defined(__NDR_convert__char_rep__MobileXRPC__boolean_t__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__isFullscreen__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__isFullscreen(a, f) \
	__NDR_convert__char_rep__MobileXRPC__boolean_t((boolean_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__boolean_t__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__isFullscreen__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__isFullscreen(a, f) \
	__NDR_convert__char_rep__boolean_t((boolean_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__CheckIn_t__isFullscreen__defined */

#ifndef __NDR_convert__char_rep__Request__CheckIn_t__windowLevel__defined
#if	defined(__NDR_convert__char_rep__MobileXRPC__integer_t__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__windowLevel__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__windowLevel(a, f) \
	__NDR_convert__char_rep__MobileXRPC__integer_t((integer_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__integer_t__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__windowLevel__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__windowLevel(a, f) \
	__NDR_convert__char_rep__integer_t((integer_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__MobileXRPC__int32_t__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__windowLevel__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__windowLevel(a, f) \
	__NDR_convert__char_rep__MobileXRPC__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__windowLevel__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__windowLevel(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__CheckIn_t__windowLevel__defined */

#ifndef __NDR_convert__char_rep__Request__CheckIn_t__shouldOffsetizeContext__defined
#if	defined(__NDR_convert__char_rep__MobileXRPC__boolean_t__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__shouldOffsetizeContext__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__shouldOffsetizeContext(a, f) \
	__NDR_convert__char_rep__MobileXRPC__boolean_t((boolean_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__boolean_t__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__shouldOffsetizeContext__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__shouldOffsetizeContext(a, f) \
	__NDR_convert__char_rep__boolean_t((boolean_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__CheckIn_t__shouldOffsetizeContext__defined */

#ifndef __NDR_convert__char_rep__Request__CheckIn_t__keepAlive__defined
#if	defined(__NDR_convert__char_rep__MobileXRPC__boolean_t__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__keepAlive__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__keepAlive(a, f) \
	__NDR_convert__char_rep__MobileXRPC__boolean_t((boolean_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__boolean_t__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__keepAlive__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__keepAlive(a, f) \
	__NDR_convert__char_rep__boolean_t((boolean_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__CheckIn_t__keepAlive__defined */

#ifndef __NDR_convert__char_rep__Request__CheckIn_t__contextSizeWidth__defined
#if	defined(__NDR_convert__char_rep__MobileXRPC__float__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextSizeWidth__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextSizeWidth(a, f) \
	__NDR_convert__char_rep__MobileXRPC__float((float *)(a), f)
#elif	defined(__NDR_convert__char_rep__float__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextSizeWidth__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextSizeWidth(a, f) \
	__NDR_convert__char_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__CheckIn_t__contextSizeWidth__defined */

#ifndef __NDR_convert__char_rep__Request__CheckIn_t__contextSizeHeight__defined
#if	defined(__NDR_convert__char_rep__MobileXRPC__float__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextSizeHeight__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextSizeHeight(a, f) \
	__NDR_convert__char_rep__MobileXRPC__float((float *)(a), f)
#elif	defined(__NDR_convert__char_rep__float__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextSizeHeight__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextSizeHeight(a, f) \
	__NDR_convert__char_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__CheckIn_t__contextSizeHeight__defined */

#ifndef __NDR_convert__char_rep__Request__CheckIn_t__contextOriginX__defined
#if	defined(__NDR_convert__char_rep__MobileXRPC__float__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextOriginX__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextOriginX(a, f) \
	__NDR_convert__char_rep__MobileXRPC__float((float *)(a), f)
#elif	defined(__NDR_convert__char_rep__float__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextOriginX__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextOriginX(a, f) \
	__NDR_convert__char_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__CheckIn_t__contextOriginX__defined */

#ifndef __NDR_convert__char_rep__Request__CheckIn_t__contextOriginY__defined
#if	defined(__NDR_convert__char_rep__MobileXRPC__float__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextOriginY__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextOriginY(a, f) \
	__NDR_convert__char_rep__MobileXRPC__float((float *)(a), f)
#elif	defined(__NDR_convert__char_rep__float__defined)
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextOriginY__defined
#define	__NDR_convert__char_rep__Request__CheckIn_t__contextOriginY(a, f) \
	__NDR_convert__char_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__CheckIn_t__contextOriginY__defined */

#ifndef __NDR_convert__float_rep__Request__CheckIn_t__isFullscreen__defined
#if	defined(__NDR_convert__float_rep__MobileXRPC__boolean_t__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__isFullscreen__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__isFullscreen(a, f) \
	__NDR_convert__float_rep__MobileXRPC__boolean_t((boolean_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__boolean_t__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__isFullscreen__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__isFullscreen(a, f) \
	__NDR_convert__float_rep__boolean_t((boolean_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__CheckIn_t__isFullscreen__defined */

#ifndef __NDR_convert__float_rep__Request__CheckIn_t__windowLevel__defined
#if	defined(__NDR_convert__float_rep__MobileXRPC__integer_t__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__windowLevel__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__windowLevel(a, f) \
	__NDR_convert__float_rep__MobileXRPC__integer_t((integer_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__integer_t__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__windowLevel__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__windowLevel(a, f) \
	__NDR_convert__float_rep__integer_t((integer_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__MobileXRPC__int32_t__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__windowLevel__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__windowLevel(a, f) \
	__NDR_convert__float_rep__MobileXRPC__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__windowLevel__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__windowLevel(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__CheckIn_t__windowLevel__defined */

#ifndef __NDR_convert__float_rep__Request__CheckIn_t__shouldOffsetizeContext__defined
#if	defined(__NDR_convert__float_rep__MobileXRPC__boolean_t__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__shouldOffsetizeContext__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__shouldOffsetizeContext(a, f) \
	__NDR_convert__float_rep__MobileXRPC__boolean_t((boolean_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__boolean_t__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__shouldOffsetizeContext__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__shouldOffsetizeContext(a, f) \
	__NDR_convert__float_rep__boolean_t((boolean_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__CheckIn_t__shouldOffsetizeContext__defined */

#ifndef __NDR_convert__float_rep__Request__CheckIn_t__keepAlive__defined
#if	defined(__NDR_convert__float_rep__MobileXRPC__boolean_t__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__keepAlive__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__keepAlive(a, f) \
	__NDR_convert__float_rep__MobileXRPC__boolean_t((boolean_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__boolean_t__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__keepAlive__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__keepAlive(a, f) \
	__NDR_convert__float_rep__boolean_t((boolean_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__CheckIn_t__keepAlive__defined */

#ifndef __NDR_convert__float_rep__Request__CheckIn_t__contextSizeWidth__defined
#if	defined(__NDR_convert__float_rep__MobileXRPC__float__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextSizeWidth__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextSizeWidth(a, f) \
	__NDR_convert__float_rep__MobileXRPC__float((float *)(a), f)
#elif	defined(__NDR_convert__float_rep__float__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextSizeWidth__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextSizeWidth(a, f) \
	__NDR_convert__float_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__CheckIn_t__contextSizeWidth__defined */

#ifndef __NDR_convert__float_rep__Request__CheckIn_t__contextSizeHeight__defined
#if	defined(__NDR_convert__float_rep__MobileXRPC__float__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextSizeHeight__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextSizeHeight(a, f) \
	__NDR_convert__float_rep__MobileXRPC__float((float *)(a), f)
#elif	defined(__NDR_convert__float_rep__float__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextSizeHeight__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextSizeHeight(a, f) \
	__NDR_convert__float_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__CheckIn_t__contextSizeHeight__defined */

#ifndef __NDR_convert__float_rep__Request__CheckIn_t__contextOriginX__defined
#if	defined(__NDR_convert__float_rep__MobileXRPC__float__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextOriginX__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextOriginX(a, f) \
	__NDR_convert__float_rep__MobileXRPC__float((float *)(a), f)
#elif	defined(__NDR_convert__float_rep__float__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextOriginX__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextOriginX(a, f) \
	__NDR_convert__float_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__CheckIn_t__contextOriginX__defined */

#ifndef __NDR_convert__float_rep__Request__CheckIn_t__contextOriginY__defined
#if	defined(__NDR_convert__float_rep__MobileXRPC__float__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextOriginY__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextOriginY(a, f) \
	__NDR_convert__float_rep__MobileXRPC__float((float *)(a), f)
#elif	defined(__NDR_convert__float_rep__float__defined)
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextOriginY__defined
#define	__NDR_convert__float_rep__Request__CheckIn_t__contextOriginY(a, f) \
	__NDR_convert__float_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__CheckIn_t__contextOriginY__defined */


mig_internal kern_return_t __MIG_check__Request__CheckIn_t(__attribute__((__unused__)) __Request__CheckIn_t *In0P)
{

	typedef __Request__CheckIn_t __Request;
#if	__MigTypeCheck
	if ((In0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (In0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Request)))
		return MIG_BAD_ARGUMENTS;
#endif	/* __MigTypeCheck */

#if	defined(__NDR_convert__int_rep__Request__CheckIn_t__isFullscreen__defined) || \
	defined(__NDR_convert__int_rep__Request__CheckIn_t__windowLevel__defined) || \
	defined(__NDR_convert__int_rep__Request__CheckIn_t__shouldOffsetizeContext__defined) || \
	defined(__NDR_convert__int_rep__Request__CheckIn_t__keepAlive__defined) || \
	defined(__NDR_convert__int_rep__Request__CheckIn_t__contextSizeWidth__defined) || \
	defined(__NDR_convert__int_rep__Request__CheckIn_t__contextSizeHeight__defined) || \
	defined(__NDR_convert__int_rep__Request__CheckIn_t__contextOriginX__defined) || \
	defined(__NDR_convert__int_rep__Request__CheckIn_t__contextOriginY__defined)
	if (In0P->NDR.int_rep != NDR_record.int_rep) {
#if defined(__NDR_convert__int_rep__Request__CheckIn_t__isFullscreen__defined)
		__NDR_convert__int_rep__Request__CheckIn_t__isFullscreen(&In0P->isFullscreen, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__CheckIn_t__isFullscreen__defined */
#if defined(__NDR_convert__int_rep__Request__CheckIn_t__windowLevel__defined)
		__NDR_convert__int_rep__Request__CheckIn_t__windowLevel(&In0P->windowLevel, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__CheckIn_t__windowLevel__defined */
#if defined(__NDR_convert__int_rep__Request__CheckIn_t__shouldOffsetizeContext__defined)
		__NDR_convert__int_rep__Request__CheckIn_t__shouldOffsetizeContext(&In0P->shouldOffsetizeContext, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__CheckIn_t__shouldOffsetizeContext__defined */
#if defined(__NDR_convert__int_rep__Request__CheckIn_t__keepAlive__defined)
		__NDR_convert__int_rep__Request__CheckIn_t__keepAlive(&In0P->keepAlive, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__CheckIn_t__keepAlive__defined */
#if defined(__NDR_convert__int_rep__Request__CheckIn_t__contextSizeWidth__defined)
		__NDR_convert__int_rep__Request__CheckIn_t__contextSizeWidth(&In0P->contextSizeWidth, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__CheckIn_t__contextSizeWidth__defined */
#if defined(__NDR_convert__int_rep__Request__CheckIn_t__contextSizeHeight__defined)
		__NDR_convert__int_rep__Request__CheckIn_t__contextSizeHeight(&In0P->contextSizeHeight, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__CheckIn_t__contextSizeHeight__defined */
#if defined(__NDR_convert__int_rep__Request__CheckIn_t__contextOriginX__defined)
		__NDR_convert__int_rep__Request__CheckIn_t__contextOriginX(&In0P->contextOriginX, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__CheckIn_t__contextOriginX__defined */
#if defined(__NDR_convert__int_rep__Request__CheckIn_t__contextOriginY__defined)
		__NDR_convert__int_rep__Request__CheckIn_t__contextOriginY(&In0P->contextOriginY, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__CheckIn_t__contextOriginY__defined */
	}
#endif	/* defined(__NDR_convert__int_rep...) */

#if	defined(__NDR_convert__char_rep__Request__CheckIn_t__isFullscreen__defined) || \
	defined(__NDR_convert__char_rep__Request__CheckIn_t__windowLevel__defined) || \
	defined(__NDR_convert__char_rep__Request__CheckIn_t__shouldOffsetizeContext__defined) || \
	defined(__NDR_convert__char_rep__Request__CheckIn_t__keepAlive__defined) || \
	defined(__NDR_convert__char_rep__Request__CheckIn_t__contextSizeWidth__defined) || \
	defined(__NDR_convert__char_rep__Request__CheckIn_t__contextSizeHeight__defined) || \
	defined(__NDR_convert__char_rep__Request__CheckIn_t__contextOriginX__defined) || \
	defined(__NDR_convert__char_rep__Request__CheckIn_t__contextOriginY__defined)
	if (In0P->NDR.char_rep != NDR_record.char_rep) {
#if defined(__NDR_convert__char_rep__Request__CheckIn_t__isFullscreen__defined)
		__NDR_convert__char_rep__Request__CheckIn_t__isFullscreen(&In0P->isFullscreen, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__CheckIn_t__isFullscreen__defined */
#if defined(__NDR_convert__char_rep__Request__CheckIn_t__windowLevel__defined)
		__NDR_convert__char_rep__Request__CheckIn_t__windowLevel(&In0P->windowLevel, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__CheckIn_t__windowLevel__defined */
#if defined(__NDR_convert__char_rep__Request__CheckIn_t__shouldOffsetizeContext__defined)
		__NDR_convert__char_rep__Request__CheckIn_t__shouldOffsetizeContext(&In0P->shouldOffsetizeContext, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__CheckIn_t__shouldOffsetizeContext__defined */
#if defined(__NDR_convert__char_rep__Request__CheckIn_t__keepAlive__defined)
		__NDR_convert__char_rep__Request__CheckIn_t__keepAlive(&In0P->keepAlive, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__CheckIn_t__keepAlive__defined */
#if defined(__NDR_convert__char_rep__Request__CheckIn_t__contextSizeWidth__defined)
		__NDR_convert__char_rep__Request__CheckIn_t__contextSizeWidth(&In0P->contextSizeWidth, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__CheckIn_t__contextSizeWidth__defined */
#if defined(__NDR_convert__char_rep__Request__CheckIn_t__contextSizeHeight__defined)
		__NDR_convert__char_rep__Request__CheckIn_t__contextSizeHeight(&In0P->contextSizeHeight, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__CheckIn_t__contextSizeHeight__defined */
#if defined(__NDR_convert__char_rep__Request__CheckIn_t__contextOriginX__defined)
		__NDR_convert__char_rep__Request__CheckIn_t__contextOriginX(&In0P->contextOriginX, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__CheckIn_t__contextOriginX__defined */
#if defined(__NDR_convert__char_rep__Request__CheckIn_t__contextOriginY__defined)
		__NDR_convert__char_rep__Request__CheckIn_t__contextOriginY(&In0P->contextOriginY, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__CheckIn_t__contextOriginY__defined */
	}
#endif	/* defined(__NDR_convert__char_rep...) */

#if	defined(__NDR_convert__float_rep__Request__CheckIn_t__isFullscreen__defined) || \
	defined(__NDR_convert__float_rep__Request__CheckIn_t__windowLevel__defined) || \
	defined(__NDR_convert__float_rep__Request__CheckIn_t__shouldOffsetizeContext__defined) || \
	defined(__NDR_convert__float_rep__Request__CheckIn_t__keepAlive__defined) || \
	defined(__NDR_convert__float_rep__Request__CheckIn_t__contextSizeWidth__defined) || \
	defined(__NDR_convert__float_rep__Request__CheckIn_t__contextSizeHeight__defined) || \
	defined(__NDR_convert__float_rep__Request__CheckIn_t__contextOriginX__defined) || \
	defined(__NDR_convert__float_rep__Request__CheckIn_t__contextOriginY__defined)
	if (In0P->NDR.float_rep != NDR_record.float_rep) {
#if defined(__NDR_convert__float_rep__Request__CheckIn_t__isFullscreen__defined)
		__NDR_convert__float_rep__Request__CheckIn_t__isFullscreen(&In0P->isFullscreen, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__CheckIn_t__isFullscreen__defined */
#if defined(__NDR_convert__float_rep__Request__CheckIn_t__windowLevel__defined)
		__NDR_convert__float_rep__Request__CheckIn_t__windowLevel(&In0P->windowLevel, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__CheckIn_t__windowLevel__defined */
#if defined(__NDR_convert__float_rep__Request__CheckIn_t__shouldOffsetizeContext__defined)
		__NDR_convert__float_rep__Request__CheckIn_t__shouldOffsetizeContext(&In0P->shouldOffsetizeContext, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__CheckIn_t__shouldOffsetizeContext__defined */
#if defined(__NDR_convert__float_rep__Request__CheckIn_t__keepAlive__defined)
		__NDR_convert__float_rep__Request__CheckIn_t__keepAlive(&In0P->keepAlive, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__CheckIn_t__keepAlive__defined */
#if defined(__NDR_convert__float_rep__Request__CheckIn_t__contextSizeWidth__defined)
		__NDR_convert__float_rep__Request__CheckIn_t__contextSizeWidth(&In0P->contextSizeWidth, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__CheckIn_t__contextSizeWidth__defined */
#if defined(__NDR_convert__float_rep__Request__CheckIn_t__contextSizeHeight__defined)
		__NDR_convert__float_rep__Request__CheckIn_t__contextSizeHeight(&In0P->contextSizeHeight, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__CheckIn_t__contextSizeHeight__defined */
#if defined(__NDR_convert__float_rep__Request__CheckIn_t__contextOriginX__defined)
		__NDR_convert__float_rep__Request__CheckIn_t__contextOriginX(&In0P->contextOriginX, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__CheckIn_t__contextOriginX__defined */
#if defined(__NDR_convert__float_rep__Request__CheckIn_t__contextOriginY__defined)
		__NDR_convert__float_rep__Request__CheckIn_t__contextOriginY(&In0P->contextOriginY, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__CheckIn_t__contextOriginY__defined */
	}
#endif	/* defined(__NDR_convert__float_rep...) */

	return MACH_MSG_SUCCESS;
}
#endif /* !defined(__MIG_check__Request__CheckIn_t__defined) */
#endif /* __MIG_check__Request__MobileXRPC_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine CheckIn */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t _MXRPCCall_CheckIn
(
	mach_port_t server,
	boolean_t isFullscreen,
	integer_t windowLevel,
	boolean_t shouldOffsetizeContext,
	boolean_t keepAlive,
	float contextSizeWidth,
	float contextSizeHeight,
	float contextOriginX,
	float contextOriginY,
	audit_token_t token
);

/* Routine CheckIn */
mig_internal novalue _XCheckIn
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP)
{

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		boolean_t isFullscreen;
		integer_t windowLevel;
		boolean_t shouldOffsetizeContext;
		boolean_t keepAlive;
		float contextSizeWidth;
		float contextSizeHeight;
		float contextOriginX;
		float contextOriginY;
		mach_msg_max_trailer_t trailer;
	} Request;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	typedef __Request__CheckIn_t __Request;
	typedef __Reply__CheckIn_t Reply;

	/*
	 * typedef struct {
	 * 	mach_msg_header_t Head;
	 * 	NDR_record_t NDR;
	 * 	kern_return_t RetCode;
	 * } mig_reply_error_t;
	 */

	Request *In0P = (Request *) InHeadP;
	Reply *OutP = (Reply *) OutHeadP;
	mach_msg_max_trailer_t *TrailerP;
#if	__MigTypeCheck
	unsigned int trailer_size;
#endif	/* __MigTypeCheck */
#ifdef	__MIG_check__Request__CheckIn_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Request__CheckIn_t__defined */

	__DeclareRcvRpc(70302, "CheckIn")
	__BeforeRcvRpc(70302, "CheckIn")

#if	defined(__MIG_check__Request__CheckIn_t__defined)
	check_result = __MIG_check__Request__CheckIn_t((__Request *)In0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ MIG_RETURN_ERROR(OutP, check_result); }
#endif	/* defined(__MIG_check__Request__CheckIn_t__defined) */

	TrailerP = (mach_msg_max_trailer_t *)((vm_offset_t)In0P +
		round_msg(In0P->Head.msgh_size));
	if (TrailerP->msgh_trailer_type != MACH_MSG_TRAILER_FORMAT_0)
		{ MIG_RETURN_ERROR(In0P, MIG_TRAILER_ERROR); }
#if	__MigTypeCheck
	trailer_size = TrailerP->msgh_trailer_size -
		(mach_msg_size_t)(sizeof(mach_msg_trailer_type_t) - sizeof(mach_msg_trailer_size_t));
#endif	/* __MigTypeCheck */
#if	__MigTypeCheck
	if (trailer_size < (mach_msg_size_t)sizeof(audit_token_t))
		{ MIG_RETURN_ERROR(OutP, MIG_TRAILER_ERROR); }
	trailer_size -= (mach_msg_size_t)sizeof(audit_token_t);
#endif	/* __MigTypeCheck */
	OutP->RetCode = _MXRPCCall_CheckIn(In0P->Head.msgh_request_port, In0P->isFullscreen, In0P->windowLevel, In0P->shouldOffsetizeContext, In0P->keepAlive, In0P->contextSizeWidth, In0P->contextSizeHeight, In0P->contextOriginX, In0P->contextOriginY, TrailerP->msgh_audit);

	OutP->NDR = NDR_record;


	__AfterRcvRpc(70302, "CheckIn")
}

#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Request__MobileXRPC_subsystem__
#if !defined(__MIG_check__Request__CopyScreenDimensions_t__defined)
#define __MIG_check__Request__CopyScreenDimensions_t__defined

mig_internal kern_return_t __MIG_check__Request__CopyScreenDimensions_t(__attribute__((__unused__)) __Request__CopyScreenDimensions_t *In0P)
{

	typedef __Request__CopyScreenDimensions_t __Request;
#if	__MigTypeCheck
	if ((In0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (In0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Request)))
		return MIG_BAD_ARGUMENTS;
#endif	/* __MigTypeCheck */

	return MACH_MSG_SUCCESS;
}
#endif /* !defined(__MIG_check__Request__CopyScreenDimensions_t__defined) */
#endif /* __MIG_check__Request__MobileXRPC_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine CopyScreenDimensions */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t _MXRPCCall_CopyScreenDimensions
(
	mach_port_t server,
	integer_t *width,
	integer_t *height,
	audit_token_t token
);

/* Routine CopyScreenDimensions */
mig_internal novalue _XCopyScreenDimensions
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP)
{

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		mach_msg_max_trailer_t trailer;
	} Request;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	typedef __Request__CopyScreenDimensions_t __Request;
	typedef __Reply__CopyScreenDimensions_t Reply;

	/*
	 * typedef struct {
	 * 	mach_msg_header_t Head;
	 * 	NDR_record_t NDR;
	 * 	kern_return_t RetCode;
	 * } mig_reply_error_t;
	 */

	Request *In0P = (Request *) InHeadP;
	Reply *OutP = (Reply *) OutHeadP;
	mach_msg_max_trailer_t *TrailerP;
#if	__MigTypeCheck
	unsigned int trailer_size;
#endif	/* __MigTypeCheck */
#ifdef	__MIG_check__Request__CopyScreenDimensions_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Request__CopyScreenDimensions_t__defined */

	__DeclareRcvRpc(70303, "CopyScreenDimensions")
	__BeforeRcvRpc(70303, "CopyScreenDimensions")

#if	defined(__MIG_check__Request__CopyScreenDimensions_t__defined)
	check_result = __MIG_check__Request__CopyScreenDimensions_t((__Request *)In0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ MIG_RETURN_ERROR(OutP, check_result); }
#endif	/* defined(__MIG_check__Request__CopyScreenDimensions_t__defined) */

	TrailerP = (mach_msg_max_trailer_t *)((vm_offset_t)In0P +
		round_msg(In0P->Head.msgh_size));
	if (TrailerP->msgh_trailer_type != MACH_MSG_TRAILER_FORMAT_0)
		{ MIG_RETURN_ERROR(In0P, MIG_TRAILER_ERROR); }
#if	__MigTypeCheck
	trailer_size = TrailerP->msgh_trailer_size -
		(mach_msg_size_t)(sizeof(mach_msg_trailer_type_t) - sizeof(mach_msg_trailer_size_t));
#endif	/* __MigTypeCheck */
#if	__MigTypeCheck
	if (trailer_size < (mach_msg_size_t)sizeof(audit_token_t))
		{ MIG_RETURN_ERROR(OutP, MIG_TRAILER_ERROR); }
	trailer_size -= (mach_msg_size_t)sizeof(audit_token_t);
#endif	/* __MigTypeCheck */
	OutP->RetCode = _MXRPCCall_CopyScreenDimensions(In0P->Head.msgh_request_port, &OutP->width, &OutP->height, TrailerP->msgh_audit);
	if (OutP->RetCode != KERN_SUCCESS) {
		MIG_RETURN_ERROR(OutP, OutP->RetCode);
	}

	OutP->NDR = NDR_record;


	OutP->Head.msgh_size = (mach_msg_size_t)(sizeof(Reply));
	__AfterRcvRpc(70303, "CopyScreenDimensions")
}

#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Request__MobileXRPC_subsystem__
#if !defined(__MIG_check__Request__CallMethod_t__defined)
#define __MIG_check__Request__CallMethod_t__defined
#ifndef __NDR_convert__int_rep__Request__CallMethod_t__selector__defined
#if	defined(__NDR_convert__int_rep__MobileXRPC__integer_t__defined)
#define	__NDR_convert__int_rep__Request__CallMethod_t__selector__defined
#define	__NDR_convert__int_rep__Request__CallMethod_t__selector(a, f) \
	__NDR_convert__int_rep__MobileXRPC__integer_t((integer_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__integer_t__defined)
#define	__NDR_convert__int_rep__Request__CallMethod_t__selector__defined
#define	__NDR_convert__int_rep__Request__CallMethod_t__selector(a, f) \
	__NDR_convert__int_rep__integer_t((integer_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__MobileXRPC__int32_t__defined)
#define	__NDR_convert__int_rep__Request__CallMethod_t__selector__defined
#define	__NDR_convert__int_rep__Request__CallMethod_t__selector(a, f) \
	__NDR_convert__int_rep__MobileXRPC__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__CallMethod_t__selector__defined
#define	__NDR_convert__int_rep__Request__CallMethod_t__selector(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__CallMethod_t__selector__defined */

#ifndef __NDR_convert__char_rep__Request__CallMethod_t__selector__defined
#if	defined(__NDR_convert__char_rep__MobileXRPC__integer_t__defined)
#define	__NDR_convert__char_rep__Request__CallMethod_t__selector__defined
#define	__NDR_convert__char_rep__Request__CallMethod_t__selector(a, f) \
	__NDR_convert__char_rep__MobileXRPC__integer_t((integer_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__integer_t__defined)
#define	__NDR_convert__char_rep__Request__CallMethod_t__selector__defined
#define	__NDR_convert__char_rep__Request__CallMethod_t__selector(a, f) \
	__NDR_convert__char_rep__integer_t((integer_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__MobileXRPC__int32_t__defined)
#define	__NDR_convert__char_rep__Request__CallMethod_t__selector__defined
#define	__NDR_convert__char_rep__Request__CallMethod_t__selector(a, f) \
	__NDR_convert__char_rep__MobileXRPC__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__CallMethod_t__selector__defined
#define	__NDR_convert__char_rep__Request__CallMethod_t__selector(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__CallMethod_t__selector__defined */

#ifndef __NDR_convert__float_rep__Request__CallMethod_t__selector__defined
#if	defined(__NDR_convert__float_rep__MobileXRPC__integer_t__defined)
#define	__NDR_convert__float_rep__Request__CallMethod_t__selector__defined
#define	__NDR_convert__float_rep__Request__CallMethod_t__selector(a, f) \
	__NDR_convert__float_rep__MobileXRPC__integer_t((integer_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__integer_t__defined)
#define	__NDR_convert__float_rep__Request__CallMethod_t__selector__defined
#define	__NDR_convert__float_rep__Request__CallMethod_t__selector(a, f) \
	__NDR_convert__float_rep__integer_t((integer_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__MobileXRPC__int32_t__defined)
#define	__NDR_convert__float_rep__Request__CallMethod_t__selector__defined
#define	__NDR_convert__float_rep__Request__CallMethod_t__selector(a, f) \
	__NDR_convert__float_rep__MobileXRPC__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__CallMethod_t__selector__defined
#define	__NDR_convert__float_rep__Request__CallMethod_t__selector(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__CallMethod_t__selector__defined */


mig_internal kern_return_t __MIG_check__Request__CallMethod_t(__attribute__((__unused__)) __Request__CallMethod_t *In0P)
{

	typedef __Request__CallMethod_t __Request;
#if	__MigTypeCheck
	if ((In0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (In0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Request)))
		return MIG_BAD_ARGUMENTS;
#endif	/* __MigTypeCheck */

#if	defined(__NDR_convert__int_rep__Request__CallMethod_t__selector__defined)
	if (In0P->NDR.int_rep != NDR_record.int_rep) {
#if defined(__NDR_convert__int_rep__Request__CallMethod_t__selector__defined)
		__NDR_convert__int_rep__Request__CallMethod_t__selector(&In0P->selector, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__CallMethod_t__selector__defined */
	}
#endif	/* defined(__NDR_convert__int_rep...) */

#if	defined(__NDR_convert__char_rep__Request__CallMethod_t__selector__defined)
	if (In0P->NDR.char_rep != NDR_record.char_rep) {
#if defined(__NDR_convert__char_rep__Request__CallMethod_t__selector__defined)
		__NDR_convert__char_rep__Request__CallMethod_t__selector(&In0P->selector, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__CallMethod_t__selector__defined */
	}
#endif	/* defined(__NDR_convert__char_rep...) */

#if	defined(__NDR_convert__float_rep__Request__CallMethod_t__selector__defined)
	if (In0P->NDR.float_rep != NDR_record.float_rep) {
#if defined(__NDR_convert__float_rep__Request__CallMethod_t__selector__defined)
		__NDR_convert__float_rep__Request__CallMethod_t__selector(&In0P->selector, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__CallMethod_t__selector__defined */
	}
#endif	/* defined(__NDR_convert__float_rep...) */

	return MACH_MSG_SUCCESS;
}
#endif /* !defined(__MIG_check__Request__CallMethod_t__defined) */
#endif /* __MIG_check__Request__MobileXRPC_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine CallMethod */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t _MXRPCCall_CallMethod
(
	mach_port_t server,
	integer_t selector,
	audit_token_t token
);

/* Routine CallMethod */
mig_internal novalue _XCallMethod
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP)
{

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		integer_t selector;
		mach_msg_max_trailer_t trailer;
	} Request;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	typedef __Request__CallMethod_t __Request;
	typedef __Reply__CallMethod_t Reply;

	/*
	 * typedef struct {
	 * 	mach_msg_header_t Head;
	 * 	NDR_record_t NDR;
	 * 	kern_return_t RetCode;
	 * } mig_reply_error_t;
	 */

	Request *In0P = (Request *) InHeadP;
	Reply *OutP = (Reply *) OutHeadP;
	mach_msg_max_trailer_t *TrailerP;
#if	__MigTypeCheck
	unsigned int trailer_size;
#endif	/* __MigTypeCheck */
#ifdef	__MIG_check__Request__CallMethod_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Request__CallMethod_t__defined */

	__DeclareRcvRpc(70304, "CallMethod")
	__BeforeRcvRpc(70304, "CallMethod")

#if	defined(__MIG_check__Request__CallMethod_t__defined)
	check_result = __MIG_check__Request__CallMethod_t((__Request *)In0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ MIG_RETURN_ERROR(OutP, check_result); }
#endif	/* defined(__MIG_check__Request__CallMethod_t__defined) */

	TrailerP = (mach_msg_max_trailer_t *)((vm_offset_t)In0P +
		round_msg(In0P->Head.msgh_size));
	if (TrailerP->msgh_trailer_type != MACH_MSG_TRAILER_FORMAT_0)
		{ MIG_RETURN_ERROR(In0P, MIG_TRAILER_ERROR); }
#if	__MigTypeCheck
	trailer_size = TrailerP->msgh_trailer_size -
		(mach_msg_size_t)(sizeof(mach_msg_trailer_type_t) - sizeof(mach_msg_trailer_size_t));
#endif	/* __MigTypeCheck */
#if	__MigTypeCheck
	if (trailer_size < (mach_msg_size_t)sizeof(audit_token_t))
		{ MIG_RETURN_ERROR(OutP, MIG_TRAILER_ERROR); }
	trailer_size -= (mach_msg_size_t)sizeof(audit_token_t);
#endif	/* __MigTypeCheck */
	OutP->RetCode = _MXRPCCall_CallMethod(In0P->Head.msgh_request_port, In0P->selector, TrailerP->msgh_audit);

	OutP->NDR = NDR_record;


	__AfterRcvRpc(70304, "CallMethod")
}


#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
boolean_t MobileXRPC_server(
		mach_msg_header_t *InHeadP,
		mach_msg_header_t *OutHeadP);

#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
mig_routine_t MobileXRPC_server_routine(
		mach_msg_header_t *InHeadP);


/* Description of this subsystem, for use in direct RPC */
const struct _MXRPCCall_MobileXRPC_subsystem {
	mig_server_routine_t 	server;	/* Server routine */
	mach_msg_id_t	start;	/* Min routine number */
	mach_msg_id_t	end;	/* Max routine number + 1 */
	unsigned int	maxsize;	/* Max msg size */
	vm_address_t	reserved;	/* Reserved */
	struct routine_descriptor	/*Array of routine descriptors */
		routine[5];
} _MXRPCCall_MobileXRPC_subsystem = {
	MobileXRPC_server_routine,
	70300,
	70305,
	(mach_msg_size_t)sizeof(union __ReplyUnion___MXRPCCall_MobileXRPC_subsystem),
	(vm_address_t)0,
	{
          { (mig_impl_routine_t) 0,
          (mig_stub_routine_t) _XCopyApplicationList, 11, 0, (routine_arg_descriptor_t)0, (mach_msg_size_t)sizeof(__Reply__CopyApplicationList_t)},
          { (mig_impl_routine_t) 0,
          (mig_stub_routine_t) _XLaunchApplication, 10, 0, (routine_arg_descriptor_t)0, (mach_msg_size_t)sizeof(__Reply__LaunchApplication_t)},
          { (mig_impl_routine_t) 0,
          (mig_stub_routine_t) _XCheckIn, 17, 0, (routine_arg_descriptor_t)0, (mach_msg_size_t)sizeof(__Reply__CheckIn_t)},
          { (mig_impl_routine_t) 0,
          (mig_stub_routine_t) _XCopyScreenDimensions, 11, 0, (routine_arg_descriptor_t)0, (mach_msg_size_t)sizeof(__Reply__CopyScreenDimensions_t)},
          { (mig_impl_routine_t) 0,
          (mig_stub_routine_t) _XCallMethod, 10, 0, (routine_arg_descriptor_t)0, (mach_msg_size_t)sizeof(__Reply__CallMethod_t)},
	}
};

mig_external boolean_t MobileXRPC_server
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP)
{
	/*
	 * typedef struct {
	 * 	mach_msg_header_t Head;
	 * 	NDR_record_t NDR;
	 * 	kern_return_t RetCode;
	 * } mig_reply_error_t;
	 */

	register mig_routine_t routine;

	OutHeadP->msgh_bits = MACH_MSGH_BITS(MACH_MSGH_BITS_REPLY(InHeadP->msgh_bits), 0);
	OutHeadP->msgh_remote_port = InHeadP->msgh_reply_port;
	/* Minimal size: routine() will update it if different */
	OutHeadP->msgh_size = (mach_msg_size_t)sizeof(mig_reply_error_t);
	OutHeadP->msgh_local_port = MACH_PORT_NULL;
	OutHeadP->msgh_id = InHeadP->msgh_id + 100;

	if ((InHeadP->msgh_id > 70304) || (InHeadP->msgh_id < 70300) ||
	    ((routine = _MXRPCCall_MobileXRPC_subsystem.routine[InHeadP->msgh_id - 70300].stub_routine) == 0)) {
		((mig_reply_error_t *)OutHeadP)->NDR = NDR_record;
		((mig_reply_error_t *)OutHeadP)->RetCode = MIG_BAD_ID;
		return FALSE;
	}
	(*routine) (InHeadP, OutHeadP);
	return TRUE;
}

mig_external mig_routine_t MobileXRPC_server_routine
	(mach_msg_header_t *InHeadP)
{
	register int msgh_id;

	msgh_id = InHeadP->msgh_id - 70300;

	if ((msgh_id > 4) || (msgh_id < 0))
		return 0;

	return _MXRPCCall_MobileXRPC_subsystem.routine[msgh_id].stub_routine;
}
