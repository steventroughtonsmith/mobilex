/* Module MXUIStatusBar */

#define	__MIG_check__Request__MXUIStatusBar_subsystem__ 1
#define	__NDR_convert__Request__MXUIStatusBar_subsystem__ 1

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
#include "MXUIStatusBarServerCommon.h"

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

#ifndef __ReplyUnion___MXUIXXStatusBarServer_MXUIStatusBar_subsystem__defined
#define __ReplyUnion___MXUIXXStatusBarServer_MXUIStatusBar_subsystem__defined
union __ReplyUnion___MXUIXXStatusBarServer_MXUIStatusBar_subsystem {
	__Reply__GetStatusBarData_t Reply_GetStatusBarData;
};
#endif /* __RequestUnion___MXUIXXStatusBarServer_MXUIStatusBar_subsystem__defined */
/* Forward Declarations */


mig_internal novalue _XGetStatusBarData
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP);


#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Request__MXUIStatusBar_subsystem__
#if !defined(__MIG_check__Request__GetStatusBarData_t__defined)
#define __MIG_check__Request__GetStatusBarData_t__defined

mig_internal kern_return_t __MIG_check__Request__GetStatusBarData_t(__attribute__((__unused__)) __Request__GetStatusBarData_t *In0P)
{

	typedef __Request__GetStatusBarData_t __Request;
#if	__MigTypeCheck
	if ((In0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (In0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Request)))
		return MIG_BAD_ARGUMENTS;
#endif	/* __MigTypeCheck */

	return MACH_MSG_SUCCESS;
}
#endif /* !defined(__MIG_check__Request__GetStatusBarData_t__defined) */
#endif /* __MIG_check__Request__MXUIStatusBar_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine GetStatusBarData */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t _MXUIXXStatusBarServer_GetStatusBarData
(
	mach_port_t server,
	serialized_t *list,
	mach_msg_type_number_t *listCnt,
	audit_token_t token
);

/* Routine GetStatusBarData */
mig_internal novalue _XGetStatusBarData
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
	typedef __Request__GetStatusBarData_t __Request;
	typedef __Reply__GetStatusBarData_t Reply;

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
#ifdef	__MIG_check__Request__GetStatusBarData_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Request__GetStatusBarData_t__defined */

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
	__DeclareRcvRpc(33011, "GetStatusBarData")
	__BeforeRcvRpc(33011, "GetStatusBarData")

#if	defined(__MIG_check__Request__GetStatusBarData_t__defined)
	check_result = __MIG_check__Request__GetStatusBarData_t((__Request *)In0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ MIG_RETURN_ERROR(OutP, check_result); }
#endif	/* defined(__MIG_check__Request__GetStatusBarData_t__defined) */

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


	RetCode = _MXUIXXStatusBarServer_GetStatusBarData(In0P->Head.msgh_request_port, (serialized_t *)&(OutP->list.address), &OutP->listCnt, TrailerP->msgh_audit);
	if (RetCode != KERN_SUCCESS) {
		MIG_RETURN_ERROR(OutP, RetCode);
	}
	OutP->list.size = OutP->listCnt;


	OutP->NDR = NDR_record;


	OutP->Head.msgh_bits |= MACH_MSGH_BITS_COMPLEX;
	OutP->Head.msgh_size = (mach_msg_size_t)(sizeof(Reply));
	OutP->msgh_body.msgh_descriptor_count = 1;
	__AfterRcvRpc(33011, "GetStatusBarData")
}


extern boolean_t MXUIStatusBar_server(
		mach_msg_header_t *InHeadP,
		mach_msg_header_t *OutHeadP);

extern mig_routine_t MXUIStatusBar_server_routine(
		mach_msg_header_t *InHeadP);


/* Description of this subsystem, for use in direct RPC */
const struct _MXUIXXStatusBarServer_MXUIStatusBar_subsystem {
	mig_server_routine_t 	server;	/* Server routine */
	mach_msg_id_t	start;	/* Min routine number */
	mach_msg_id_t	end;	/* Max routine number + 1 */
	unsigned int	maxsize;	/* Max msg size */
	vm_address_t	reserved;	/* Reserved */
	struct routine_descriptor	/*Array of routine descriptors */
		routine[16];
} _MXUIXXStatusBarServer_MXUIStatusBar_subsystem = {
	MXUIStatusBar_server_routine,
	33000,
	33016,
	(mach_msg_size_t)sizeof(union __ReplyUnion___MXUIXXStatusBarServer_MXUIStatusBar_subsystem),
	(vm_address_t)0,
	{
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
          { (mig_impl_routine_t) 0,
          (mig_stub_routine_t) _XGetStatusBarData, 11, 0, (routine_arg_descriptor_t)0, (mach_msg_size_t)sizeof(__Reply__GetStatusBarData_t)},
		{0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0},
	}
};

mig_external boolean_t MXUIStatusBar_server
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

	if ((InHeadP->msgh_id > 33015) || (InHeadP->msgh_id < 33000) ||
	    ((routine = _MXUIXXStatusBarServer_MXUIStatusBar_subsystem.routine[InHeadP->msgh_id - 33000].stub_routine) == 0)) {
		((mig_reply_error_t *)OutHeadP)->NDR = NDR_record;
		((mig_reply_error_t *)OutHeadP)->RetCode = MIG_BAD_ID;
		return FALSE;
	}
	(*routine) (InHeadP, OutHeadP);
	return TRUE;
}

mig_external mig_routine_t MXUIStatusBar_server_routine
	(mach_msg_header_t *InHeadP)
{
	register int msgh_id;

	msgh_id = InHeadP->msgh_id - 33000;

	if ((msgh_id > 15) || (msgh_id < 0))
		return 0;

	return _MXUIXXStatusBarServer_MXUIStatusBar_subsystem.routine[msgh_id].stub_routine;
}
