/* Module SpringBoardServices */

#define	__MIG_check__Request__SpringBoardServices_subsystem__ 1
#define	__NDR_convert__Request__SpringBoardServices_subsystem__ 1

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
#include "SpringBoardServices_Common.h"

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

#ifndef __ReplyUnion___SBXXSpringBoardServices_subsystem__defined
#define __ReplyUnion___SBXXSpringBoardServices_subsystem__defined
union __ReplyUnion___SBXXSpringBoardServices_subsystem {
	__Reply__AppWillOrderInContext_t Reply_AppWillOrderInContext;
	__Reply__AppDidOrderOutContext_t Reply_AppDidOrderOutContext;
	__Reply__LaunchApplicationWithIdentifier_t Reply_LaunchApplicationWithIdentifier;
	__Reply__RegisterStatusBarWindowContextId_t Reply_RegisterStatusBarWindowContextId;
	__Reply__CheckInTaskPort_t Reply_CheckInTaskPort;
	__Reply__RegisterRemoteView_t Reply_RegisterRemoteView;
};
#endif /* __RequestUnion___SBXXSpringBoardServices_subsystem__defined */
/* Forward Declarations */


mig_internal novalue _XAppWillOrderInContext
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP);

mig_internal novalue _XAppDidOrderOutContext
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP);

mig_internal novalue _XLaunchApplicationWithIdentifier
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP);

mig_internal novalue _XRegisterStatusBarWindowContextId
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP);

mig_internal novalue _XCheckInTaskPort
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP);

mig_internal novalue _XRegisterRemoteView
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP);


#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Request__SpringBoardServices_subsystem__
#if !defined(__MIG_check__Request__AppWillOrderInContext_t__defined)
#define __MIG_check__Request__AppWillOrderInContext_t__defined
#ifndef __NDR_convert__int_rep__Request__AppWillOrderInContext_t__context__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__unsigned__defined)
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__context__defined
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__context(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__int_rep__unsigned__defined)
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__context__defined
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__context(a, f) \
	__NDR_convert__int_rep__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__uint32_t__defined)
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__context__defined
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__context(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__uint32_t((uint32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__uint32_t__defined)
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__context__defined
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__context(a, f) \
	__NDR_convert__int_rep__uint32_t((uint32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__AppWillOrderInContext_t__context__defined */

#ifndef __NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowLevel__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__float__defined)
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowLevel__defined
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowLevel(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__float((float *)(a), f)
#elif	defined(__NDR_convert__int_rep__float__defined)
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowLevel__defined
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowLevel(a, f) \
	__NDR_convert__int_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowLevel__defined */

#ifndef __NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowOutput(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowOutput(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowOutput(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#define	__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowOutput(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowOutput__defined */

#ifndef __NDR_convert__char_rep__Request__AppWillOrderInContext_t__context__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__unsigned__defined)
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__context__defined
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__context(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__char_rep__unsigned__defined)
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__context__defined
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__context(a, f) \
	__NDR_convert__char_rep__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__uint32_t__defined)
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__context__defined
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__context(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__uint32_t((uint32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__uint32_t__defined)
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__context__defined
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__context(a, f) \
	__NDR_convert__char_rep__uint32_t((uint32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__AppWillOrderInContext_t__context__defined */

#ifndef __NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowLevel__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__float__defined)
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowLevel__defined
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowLevel(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__float((float *)(a), f)
#elif	defined(__NDR_convert__char_rep__float__defined)
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowLevel__defined
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowLevel(a, f) \
	__NDR_convert__char_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowLevel__defined */

#ifndef __NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowOutput(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowOutput(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowOutput(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#define	__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowOutput(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowOutput__defined */

#ifndef __NDR_convert__float_rep__Request__AppWillOrderInContext_t__context__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__unsigned__defined)
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__context__defined
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__context(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__float_rep__unsigned__defined)
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__context__defined
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__context(a, f) \
	__NDR_convert__float_rep__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__uint32_t__defined)
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__context__defined
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__context(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__uint32_t((uint32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__uint32_t__defined)
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__context__defined
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__context(a, f) \
	__NDR_convert__float_rep__uint32_t((uint32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__AppWillOrderInContext_t__context__defined */

#ifndef __NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowLevel__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__float__defined)
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowLevel__defined
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowLevel(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__float((float *)(a), f)
#elif	defined(__NDR_convert__float_rep__float__defined)
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowLevel__defined
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowLevel(a, f) \
	__NDR_convert__float_rep__float((float *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowLevel__defined */

#ifndef __NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowOutput(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowOutput(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowOutput(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowOutput__defined
#define	__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowOutput(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowOutput__defined */


mig_internal kern_return_t __MIG_check__Request__AppWillOrderInContext_t(__attribute__((__unused__)) __Request__AppWillOrderInContext_t *In0P)
{

	typedef __Request__AppWillOrderInContext_t __Request;
#if	__MigTypeCheck
	if ((In0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (In0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Request)))
		return MIG_BAD_ARGUMENTS;
#endif	/* __MigTypeCheck */

#if	defined(__NDR_convert__int_rep__Request__AppWillOrderInContext_t__context__defined) || \
	defined(__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowLevel__defined) || \
	defined(__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowOutput__defined)
	if (In0P->NDR.int_rep != NDR_record.int_rep) {
#if defined(__NDR_convert__int_rep__Request__AppWillOrderInContext_t__context__defined)
		__NDR_convert__int_rep__Request__AppWillOrderInContext_t__context(&In0P->context, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__AppWillOrderInContext_t__context__defined */
#if defined(__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowLevel__defined)
		__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowLevel(&In0P->windowLevel, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowLevel__defined */
#if defined(__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowOutput__defined)
		__NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowOutput(&In0P->windowOutput, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__AppWillOrderInContext_t__windowOutput__defined */
	}
#endif	/* defined(__NDR_convert__int_rep...) */

#if	defined(__NDR_convert__char_rep__Request__AppWillOrderInContext_t__context__defined) || \
	defined(__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowLevel__defined) || \
	defined(__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowOutput__defined)
	if (In0P->NDR.char_rep != NDR_record.char_rep) {
#if defined(__NDR_convert__char_rep__Request__AppWillOrderInContext_t__context__defined)
		__NDR_convert__char_rep__Request__AppWillOrderInContext_t__context(&In0P->context, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__AppWillOrderInContext_t__context__defined */
#if defined(__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowLevel__defined)
		__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowLevel(&In0P->windowLevel, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowLevel__defined */
#if defined(__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowOutput__defined)
		__NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowOutput(&In0P->windowOutput, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__AppWillOrderInContext_t__windowOutput__defined */
	}
#endif	/* defined(__NDR_convert__char_rep...) */

#if	defined(__NDR_convert__float_rep__Request__AppWillOrderInContext_t__context__defined) || \
	defined(__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowLevel__defined) || \
	defined(__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowOutput__defined)
	if (In0P->NDR.float_rep != NDR_record.float_rep) {
#if defined(__NDR_convert__float_rep__Request__AppWillOrderInContext_t__context__defined)
		__NDR_convert__float_rep__Request__AppWillOrderInContext_t__context(&In0P->context, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__AppWillOrderInContext_t__context__defined */
#if defined(__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowLevel__defined)
		__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowLevel(&In0P->windowLevel, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowLevel__defined */
#if defined(__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowOutput__defined)
		__NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowOutput(&In0P->windowOutput, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__AppWillOrderInContext_t__windowOutput__defined */
	}
#endif	/* defined(__NDR_convert__float_rep...) */

	return MACH_MSG_SUCCESS;
}
#endif /* !defined(__MIG_check__Request__AppWillOrderInContext_t__defined) */
#endif /* __MIG_check__Request__SpringBoardServices_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine AppWillOrderInContext */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t _SBXXAppWillOrderInContext
(
	mach_port_t server,
	unsigned context,
	float windowLevel,
	int windowOutput,
	audit_token_t token
);

/* Routine AppWillOrderInContext */
mig_internal novalue _XAppWillOrderInContext
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP)
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
		mach_msg_max_trailer_t trailer;
	} Request;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	typedef __Request__AppWillOrderInContext_t __Request;
	typedef __Reply__AppWillOrderInContext_t Reply;

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
#ifdef	__MIG_check__Request__AppWillOrderInContext_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Request__AppWillOrderInContext_t__defined */

	__DeclareRcvRpc(2000000, "AppWillOrderInContext")
	__BeforeRcvRpc(2000000, "AppWillOrderInContext")

#if	defined(__MIG_check__Request__AppWillOrderInContext_t__defined)
	check_result = __MIG_check__Request__AppWillOrderInContext_t((__Request *)In0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ MIG_RETURN_ERROR(OutP, check_result); }
#endif	/* defined(__MIG_check__Request__AppWillOrderInContext_t__defined) */

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
	OutP->RetCode = _SBXXAppWillOrderInContext(In0P->Head.msgh_request_port, In0P->context, In0P->windowLevel, In0P->windowOutput, TrailerP->msgh_audit);

	OutP->NDR = NDR_record;


	__AfterRcvRpc(2000000, "AppWillOrderInContext")
}

#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Request__SpringBoardServices_subsystem__
#if !defined(__MIG_check__Request__AppDidOrderOutContext_t__defined)
#define __MIG_check__Request__AppDidOrderOutContext_t__defined
#ifndef __NDR_convert__int_rep__Request__AppDidOrderOutContext_t__context__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__unsigned__defined)
#define	__NDR_convert__int_rep__Request__AppDidOrderOutContext_t__context__defined
#define	__NDR_convert__int_rep__Request__AppDidOrderOutContext_t__context(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__int_rep__unsigned__defined)
#define	__NDR_convert__int_rep__Request__AppDidOrderOutContext_t__context__defined
#define	__NDR_convert__int_rep__Request__AppDidOrderOutContext_t__context(a, f) \
	__NDR_convert__int_rep__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__uint32_t__defined)
#define	__NDR_convert__int_rep__Request__AppDidOrderOutContext_t__context__defined
#define	__NDR_convert__int_rep__Request__AppDidOrderOutContext_t__context(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__uint32_t((uint32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__uint32_t__defined)
#define	__NDR_convert__int_rep__Request__AppDidOrderOutContext_t__context__defined
#define	__NDR_convert__int_rep__Request__AppDidOrderOutContext_t__context(a, f) \
	__NDR_convert__int_rep__uint32_t((uint32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__AppDidOrderOutContext_t__context__defined */

#ifndef __NDR_convert__char_rep__Request__AppDidOrderOutContext_t__context__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__unsigned__defined)
#define	__NDR_convert__char_rep__Request__AppDidOrderOutContext_t__context__defined
#define	__NDR_convert__char_rep__Request__AppDidOrderOutContext_t__context(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__char_rep__unsigned__defined)
#define	__NDR_convert__char_rep__Request__AppDidOrderOutContext_t__context__defined
#define	__NDR_convert__char_rep__Request__AppDidOrderOutContext_t__context(a, f) \
	__NDR_convert__char_rep__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__uint32_t__defined)
#define	__NDR_convert__char_rep__Request__AppDidOrderOutContext_t__context__defined
#define	__NDR_convert__char_rep__Request__AppDidOrderOutContext_t__context(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__uint32_t((uint32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__uint32_t__defined)
#define	__NDR_convert__char_rep__Request__AppDidOrderOutContext_t__context__defined
#define	__NDR_convert__char_rep__Request__AppDidOrderOutContext_t__context(a, f) \
	__NDR_convert__char_rep__uint32_t((uint32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__AppDidOrderOutContext_t__context__defined */

#ifndef __NDR_convert__float_rep__Request__AppDidOrderOutContext_t__context__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__unsigned__defined)
#define	__NDR_convert__float_rep__Request__AppDidOrderOutContext_t__context__defined
#define	__NDR_convert__float_rep__Request__AppDidOrderOutContext_t__context(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__float_rep__unsigned__defined)
#define	__NDR_convert__float_rep__Request__AppDidOrderOutContext_t__context__defined
#define	__NDR_convert__float_rep__Request__AppDidOrderOutContext_t__context(a, f) \
	__NDR_convert__float_rep__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__uint32_t__defined)
#define	__NDR_convert__float_rep__Request__AppDidOrderOutContext_t__context__defined
#define	__NDR_convert__float_rep__Request__AppDidOrderOutContext_t__context(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__uint32_t((uint32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__uint32_t__defined)
#define	__NDR_convert__float_rep__Request__AppDidOrderOutContext_t__context__defined
#define	__NDR_convert__float_rep__Request__AppDidOrderOutContext_t__context(a, f) \
	__NDR_convert__float_rep__uint32_t((uint32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__AppDidOrderOutContext_t__context__defined */


mig_internal kern_return_t __MIG_check__Request__AppDidOrderOutContext_t(__attribute__((__unused__)) __Request__AppDidOrderOutContext_t *In0P)
{

	typedef __Request__AppDidOrderOutContext_t __Request;
#if	__MigTypeCheck
	if ((In0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (In0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Request)))
		return MIG_BAD_ARGUMENTS;
#endif	/* __MigTypeCheck */

#if	defined(__NDR_convert__int_rep__Request__AppDidOrderOutContext_t__context__defined)
	if (In0P->NDR.int_rep != NDR_record.int_rep) {
#if defined(__NDR_convert__int_rep__Request__AppDidOrderOutContext_t__context__defined)
		__NDR_convert__int_rep__Request__AppDidOrderOutContext_t__context(&In0P->context, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__AppDidOrderOutContext_t__context__defined */
	}
#endif	/* defined(__NDR_convert__int_rep...) */

#if	defined(__NDR_convert__char_rep__Request__AppDidOrderOutContext_t__context__defined)
	if (In0P->NDR.char_rep != NDR_record.char_rep) {
#if defined(__NDR_convert__char_rep__Request__AppDidOrderOutContext_t__context__defined)
		__NDR_convert__char_rep__Request__AppDidOrderOutContext_t__context(&In0P->context, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__AppDidOrderOutContext_t__context__defined */
	}
#endif	/* defined(__NDR_convert__char_rep...) */

#if	defined(__NDR_convert__float_rep__Request__AppDidOrderOutContext_t__context__defined)
	if (In0P->NDR.float_rep != NDR_record.float_rep) {
#if defined(__NDR_convert__float_rep__Request__AppDidOrderOutContext_t__context__defined)
		__NDR_convert__float_rep__Request__AppDidOrderOutContext_t__context(&In0P->context, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__AppDidOrderOutContext_t__context__defined */
	}
#endif	/* defined(__NDR_convert__float_rep...) */

	return MACH_MSG_SUCCESS;
}
#endif /* !defined(__MIG_check__Request__AppDidOrderOutContext_t__defined) */
#endif /* __MIG_check__Request__SpringBoardServices_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine AppDidOrderOutContext */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t _SBXXAppDidOrderOutContext
(
	mach_port_t server,
	unsigned context,
	audit_token_t token
);

/* Routine AppDidOrderOutContext */
mig_internal novalue _XAppDidOrderOutContext
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP)
{

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		unsigned context;
		mach_msg_max_trailer_t trailer;
	} Request;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	typedef __Request__AppDidOrderOutContext_t __Request;
	typedef __Reply__AppDidOrderOutContext_t Reply;

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
#ifdef	__MIG_check__Request__AppDidOrderOutContext_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Request__AppDidOrderOutContext_t__defined */

	__DeclareRcvRpc(2000001, "AppDidOrderOutContext")
	__BeforeRcvRpc(2000001, "AppDidOrderOutContext")

#if	defined(__MIG_check__Request__AppDidOrderOutContext_t__defined)
	check_result = __MIG_check__Request__AppDidOrderOutContext_t((__Request *)In0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ MIG_RETURN_ERROR(OutP, check_result); }
#endif	/* defined(__MIG_check__Request__AppDidOrderOutContext_t__defined) */

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
	OutP->RetCode = _SBXXAppDidOrderOutContext(In0P->Head.msgh_request_port, In0P->context, TrailerP->msgh_audit);

	OutP->NDR = NDR_record;


	__AfterRcvRpc(2000001, "AppDidOrderOutContext")
}

#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Request__SpringBoardServices_subsystem__
#if !defined(__MIG_check__Request__LaunchApplicationWithIdentifier_t__defined)
#define __MIG_check__Request__LaunchApplicationWithIdentifier_t__defined
#ifndef __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk0(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk0(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk0(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk0(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined */

#ifndef __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk1(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk1(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk1(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk1(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined */

#ifndef __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk2(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk2(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk2(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk2(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined */

#ifndef __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk3(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk3(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk3(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk3(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined */

#ifndef __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk4(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk4(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk4(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk4(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined */

#ifndef __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk5(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk5(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk5(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk5(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined */

#ifndef __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk6(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk6(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk6(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk6(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined */

#ifndef __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__string_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifier(a, f, c) \
	__NDR_convert__int_rep__SpringBoardServices__string_t((string_t *)(a), f, c)
#elif	defined(__NDR_convert__int_rep__string_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifier(a, f, c) \
	__NDR_convert__int_rep__string_t((string_t *)(a), f, c)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined */

#ifndef __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifierCnt__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__mach_msg_type_number_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifierCnt__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifierCnt(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__mach_msg_type_number_t((mach_msg_type_number_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__mach_msg_type_number_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifierCnt__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifierCnt(a, f) \
	__NDR_convert__int_rep__mach_msg_type_number_t((mach_msg_type_number_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifierCnt__defined */

#ifndef __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__boolean_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__suspended(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__boolean_t((boolean_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__boolean_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__suspended(a, f) \
	__NDR_convert__int_rep__boolean_t((boolean_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined */

#ifndef __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__url(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__url(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__url(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#define	__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__url(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__url__defined */

#ifndef __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk0(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk0(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk0(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk0(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined */

#ifndef __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk1(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk1(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk1(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk1(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined */

#ifndef __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk2(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk2(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk2(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk2(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined */

#ifndef __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk3(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk3(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk3(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk3(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined */

#ifndef __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk4(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk4(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk4(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk4(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined */

#ifndef __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk5(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk5(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk5(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk5(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined */

#ifndef __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk6(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk6(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk6(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk6(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined */

#ifndef __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__string_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__identifier(a, f, c) \
	__NDR_convert__char_rep__SpringBoardServices__string_t((string_t *)(a), f, c)
#elif	defined(__NDR_convert__char_rep__string_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__identifier(a, f, c) \
	__NDR_convert__char_rep__string_t((string_t *)(a), f, c)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined */

#ifndef __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__boolean_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__suspended(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__boolean_t((boolean_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__boolean_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__suspended(a, f) \
	__NDR_convert__char_rep__boolean_t((boolean_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined */

#ifndef __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__url(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__url(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__url(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#define	__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__url(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__url__defined */

#ifndef __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk0(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk0(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk0(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk0(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined */

#ifndef __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk1(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk1(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk1(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk1(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined */

#ifndef __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk2(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk2(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk2(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk2(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined */

#ifndef __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk3(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk3(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk3(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk3(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined */

#ifndef __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk4(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk4(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk4(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk4(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined */

#ifndef __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk5(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk5(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk5(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk5(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined */

#ifndef __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk6(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk6(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk6(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk6(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined */

#ifndef __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__string_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__identifier(a, f, c) \
	__NDR_convert__float_rep__SpringBoardServices__string_t((string_t *)(a), f, c)
#elif	defined(__NDR_convert__float_rep__string_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__identifier(a, f, c) \
	__NDR_convert__float_rep__string_t((string_t *)(a), f, c)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined */

#ifndef __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__boolean_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__suspended(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__boolean_t((boolean_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__boolean_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__suspended(a, f) \
	__NDR_convert__float_rep__boolean_t((boolean_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined */

#ifndef __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__url(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__url(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__url(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__url__defined
#define	__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__url(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__url__defined */


mig_internal kern_return_t __MIG_check__Request__LaunchApplicationWithIdentifier_t(__attribute__((__unused__)) __Request__LaunchApplicationWithIdentifier_t *In0P, __attribute__((__unused__)) __Request__LaunchApplicationWithIdentifier_t **In1PP)
{

	typedef __Request__LaunchApplicationWithIdentifier_t __Request;
	__Request *In1P;
#if	__MigTypeCheck
	unsigned int msgh_size;
#endif	/* __MigTypeCheck */
	unsigned int msgh_size_delta;

#if	__MigTypeCheck
	msgh_size = In0P->Head.msgh_size;
	if ((In0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (msgh_size < (mach_msg_size_t)(sizeof(__Request) - 1024)) ||  (msgh_size > (mach_msg_size_t)sizeof(__Request)))
		return MIG_BAD_ARGUMENTS;
#endif	/* __MigTypeCheck */

#if defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifierCnt__defined)
	if (In0P->NDR.int_rep != NDR_record.int_rep)
		__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifierCnt(&In0P->identifierCnt, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifierCnt__defined */
	msgh_size_delta = _WALIGN_(In0P->identifierCnt);
#if	__MigTypeCheck
	if (msgh_size != (mach_msg_size_t)(sizeof(__Request) - 1024) + msgh_size_delta)
		return MIG_BAD_ARGUMENTS;
#endif	/* __MigTypeCheck */

	*In1PP = In1P = (__Request *) ((pointer_t) In0P + msgh_size_delta - 1024);

#if __MigTypeCheck
	{
		char * msg_limit = ((char *) In0P) + In0P->Head.msgh_size;
		size_t memchr_limit;

		memchr_limit = min((msg_limit - In0P->identifier),  1024);
		if (( memchr(In0P->identifier, '\0', memchr_limit) == NULL ))
			return MIG_BAD_ARGUMENTS; // string length exceeds buffer length!
	}
#endif	/* __MigTypeCheck */

#if	defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined) || \
	defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined) || \
	defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined) || \
	defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined) || \
	defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined) || \
	defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined) || \
	defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined) || \
	defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined) || \
	defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifierCnt__defined) || \
	defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined) || \
	defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__url__defined)
	if (In0P->NDR.int_rep != NDR_record.int_rep) {
#if defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined)
		__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk0(&In0P->unk0, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined */
#if defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined)
		__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk1(&In0P->unk1, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined */
#if defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined)
		__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk2(&In0P->unk2, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined */
#if defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined)
		__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk3(&In0P->unk3, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined */
#if defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined)
		__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk4(&In0P->unk4, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined */
#if defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined)
		__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk5(&In0P->unk5, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined */
#if defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined)
		__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk6(&In0P->unk6, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined */
#if defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined)
		__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifier(&In0P->identifier, In0P->NDR.int_rep, In0P->identifierCnt);
#endif	/* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined */
#if defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined)
		__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__suspended(&In1P->suspended, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined */
#if defined(__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__url__defined)
		__NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__url(&In1P->url, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__LaunchApplicationWithIdentifier_t__url__defined */
	}
#endif	/* defined(__NDR_convert__int_rep...) */

#if	defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined) || \
	defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined) || \
	defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined) || \
	defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined) || \
	defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined) || \
	defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined) || \
	defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined) || \
	defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined) || \
	0 || \
	defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined) || \
	defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__url__defined)
	if (In0P->NDR.char_rep != NDR_record.char_rep) {
#if defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined)
		__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk0(&In0P->unk0, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined */
#if defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined)
		__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk1(&In0P->unk1, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined */
#if defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined)
		__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk2(&In0P->unk2, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined */
#if defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined)
		__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk3(&In0P->unk3, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined */
#if defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined)
		__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk4(&In0P->unk4, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined */
#if defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined)
		__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk5(&In0P->unk5, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined */
#if defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined)
		__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk6(&In0P->unk6, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined */
#if defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined)
		__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__identifier(&In0P->identifier, In0P->NDR.char_rep, In0P->identifierCnt);
#endif	/* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined */
#if defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined)
		__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__suspended(&In1P->suspended, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined */
#if defined(__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__url__defined)
		__NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__url(&In1P->url, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__LaunchApplicationWithIdentifier_t__url__defined */
	}
#endif	/* defined(__NDR_convert__char_rep...) */

#if	defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined) || \
	defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined) || \
	defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined) || \
	defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined) || \
	defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined) || \
	defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined) || \
	defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined) || \
	defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined) || \
	0 || \
	defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined) || \
	defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__url__defined)
	if (In0P->NDR.float_rep != NDR_record.float_rep) {
#if defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined)
		__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk0(&In0P->unk0, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk0__defined */
#if defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined)
		__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk1(&In0P->unk1, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk1__defined */
#if defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined)
		__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk2(&In0P->unk2, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk2__defined */
#if defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined)
		__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk3(&In0P->unk3, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk3__defined */
#if defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined)
		__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk4(&In0P->unk4, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk4__defined */
#if defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined)
		__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk5(&In0P->unk5, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk5__defined */
#if defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined)
		__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk6(&In0P->unk6, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__unk6__defined */
#if defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined)
		__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__identifier(&In0P->identifier, In0P->NDR.float_rep, In0P->identifierCnt);
#endif	/* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__identifier__defined */
#if defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined)
		__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__suspended(&In1P->suspended, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__suspended__defined */
#if defined(__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__url__defined)
		__NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__url(&In1P->url, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__LaunchApplicationWithIdentifier_t__url__defined */
	}
#endif	/* defined(__NDR_convert__float_rep...) */

	return MACH_MSG_SUCCESS;
}
#endif /* !defined(__MIG_check__Request__LaunchApplicationWithIdentifier_t__defined) */
#endif /* __MIG_check__Request__SpringBoardServices_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine LaunchApplicationWithIdentifier */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t _SBXXLaunchApplicationWithIdentifier
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
	int url,
	audit_token_t token
);

/* Routine LaunchApplicationWithIdentifier */
mig_internal novalue _XLaunchApplicationWithIdentifier
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP)
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
		mach_msg_max_trailer_t trailer;
	} Request;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	typedef __Request__LaunchApplicationWithIdentifier_t __Request;
	typedef __Reply__LaunchApplicationWithIdentifier_t Reply;

	/*
	 * typedef struct {
	 * 	mach_msg_header_t Head;
	 * 	NDR_record_t NDR;
	 * 	kern_return_t RetCode;
	 * } mig_reply_error_t;
	 */

	Request *In0P = (Request *) InHeadP;
	Request *In1P;
	Reply *OutP = (Reply *) OutHeadP;
	mach_msg_max_trailer_t *TrailerP;
#if	__MigTypeCheck
	unsigned int trailer_size;
#endif	/* __MigTypeCheck */
#ifdef	__MIG_check__Request__LaunchApplicationWithIdentifier_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Request__LaunchApplicationWithIdentifier_t__defined */

	__DeclareRcvRpc(2000003, "LaunchApplicationWithIdentifier")
	__BeforeRcvRpc(2000003, "LaunchApplicationWithIdentifier")

#if	defined(__MIG_check__Request__LaunchApplicationWithIdentifier_t__defined)
	check_result = __MIG_check__Request__LaunchApplicationWithIdentifier_t((__Request *)In0P, (__Request **)&In1P);
	if (check_result != MACH_MSG_SUCCESS)
		{ MIG_RETURN_ERROR(OutP, check_result); }
#endif	/* defined(__MIG_check__Request__LaunchApplicationWithIdentifier_t__defined) */

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
	OutP->RetCode = _SBXXLaunchApplicationWithIdentifier(In0P->Head.msgh_request_port, In0P->unk0, In0P->unk1, In0P->unk2, In0P->unk3, In0P->unk4, In0P->unk5, In0P->unk6, In0P->identifier, In1P->suspended, In1P->url, TrailerP->msgh_audit);

	OutP->NDR = NDR_record;


	__AfterRcvRpc(2000003, "LaunchApplicationWithIdentifier")
}

#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Request__SpringBoardServices_subsystem__
#if !defined(__MIG_check__Request__RegisterStatusBarWindowContextId_t__defined)
#define __MIG_check__Request__RegisterStatusBarWindowContextId_t__defined
#ifndef __NDR_convert__int_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__unsigned__defined)
#define	__NDR_convert__int_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#define	__NDR_convert__int_rep__Request__RegisterStatusBarWindowContextId_t__context(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__int_rep__unsigned__defined)
#define	__NDR_convert__int_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#define	__NDR_convert__int_rep__Request__RegisterStatusBarWindowContextId_t__context(a, f) \
	__NDR_convert__int_rep__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__uint32_t__defined)
#define	__NDR_convert__int_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#define	__NDR_convert__int_rep__Request__RegisterStatusBarWindowContextId_t__context(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__uint32_t((uint32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__uint32_t__defined)
#define	__NDR_convert__int_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#define	__NDR_convert__int_rep__Request__RegisterStatusBarWindowContextId_t__context(a, f) \
	__NDR_convert__int_rep__uint32_t((uint32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__RegisterStatusBarWindowContextId_t__context__defined */

#ifndef __NDR_convert__char_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__unsigned__defined)
#define	__NDR_convert__char_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#define	__NDR_convert__char_rep__Request__RegisterStatusBarWindowContextId_t__context(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__char_rep__unsigned__defined)
#define	__NDR_convert__char_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#define	__NDR_convert__char_rep__Request__RegisterStatusBarWindowContextId_t__context(a, f) \
	__NDR_convert__char_rep__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__uint32_t__defined)
#define	__NDR_convert__char_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#define	__NDR_convert__char_rep__Request__RegisterStatusBarWindowContextId_t__context(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__uint32_t((uint32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__uint32_t__defined)
#define	__NDR_convert__char_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#define	__NDR_convert__char_rep__Request__RegisterStatusBarWindowContextId_t__context(a, f) \
	__NDR_convert__char_rep__uint32_t((uint32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__RegisterStatusBarWindowContextId_t__context__defined */

#ifndef __NDR_convert__float_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__unsigned__defined)
#define	__NDR_convert__float_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#define	__NDR_convert__float_rep__Request__RegisterStatusBarWindowContextId_t__context(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__float_rep__unsigned__defined)
#define	__NDR_convert__float_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#define	__NDR_convert__float_rep__Request__RegisterStatusBarWindowContextId_t__context(a, f) \
	__NDR_convert__float_rep__unsigned((unsigned *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__uint32_t__defined)
#define	__NDR_convert__float_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#define	__NDR_convert__float_rep__Request__RegisterStatusBarWindowContextId_t__context(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__uint32_t((uint32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__uint32_t__defined)
#define	__NDR_convert__float_rep__Request__RegisterStatusBarWindowContextId_t__context__defined
#define	__NDR_convert__float_rep__Request__RegisterStatusBarWindowContextId_t__context(a, f) \
	__NDR_convert__float_rep__uint32_t((uint32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__RegisterStatusBarWindowContextId_t__context__defined */


mig_internal kern_return_t __MIG_check__Request__RegisterStatusBarWindowContextId_t(__attribute__((__unused__)) __Request__RegisterStatusBarWindowContextId_t *In0P)
{

	typedef __Request__RegisterStatusBarWindowContextId_t __Request;
#if	__MigTypeCheck
	if ((In0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (In0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Request)))
		return MIG_BAD_ARGUMENTS;
#endif	/* __MigTypeCheck */

#if	defined(__NDR_convert__int_rep__Request__RegisterStatusBarWindowContextId_t__context__defined)
	if (In0P->NDR.int_rep != NDR_record.int_rep) {
#if defined(__NDR_convert__int_rep__Request__RegisterStatusBarWindowContextId_t__context__defined)
		__NDR_convert__int_rep__Request__RegisterStatusBarWindowContextId_t__context(&In0P->context, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__RegisterStatusBarWindowContextId_t__context__defined */
	}
#endif	/* defined(__NDR_convert__int_rep...) */

#if	defined(__NDR_convert__char_rep__Request__RegisterStatusBarWindowContextId_t__context__defined)
	if (In0P->NDR.char_rep != NDR_record.char_rep) {
#if defined(__NDR_convert__char_rep__Request__RegisterStatusBarWindowContextId_t__context__defined)
		__NDR_convert__char_rep__Request__RegisterStatusBarWindowContextId_t__context(&In0P->context, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__RegisterStatusBarWindowContextId_t__context__defined */
	}
#endif	/* defined(__NDR_convert__char_rep...) */

#if	defined(__NDR_convert__float_rep__Request__RegisterStatusBarWindowContextId_t__context__defined)
	if (In0P->NDR.float_rep != NDR_record.float_rep) {
#if defined(__NDR_convert__float_rep__Request__RegisterStatusBarWindowContextId_t__context__defined)
		__NDR_convert__float_rep__Request__RegisterStatusBarWindowContextId_t__context(&In0P->context, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__RegisterStatusBarWindowContextId_t__context__defined */
	}
#endif	/* defined(__NDR_convert__float_rep...) */

	return MACH_MSG_SUCCESS;
}
#endif /* !defined(__MIG_check__Request__RegisterStatusBarWindowContextId_t__defined) */
#endif /* __MIG_check__Request__SpringBoardServices_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine RegisterStatusBarWindowContextId */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t _SBXXRegisterStatusBarWindowContextId
(
	mach_port_t server,
	unsigned context,
	audit_token_t token
);

/* Routine RegisterStatusBarWindowContextId */
mig_internal novalue _XRegisterStatusBarWindowContextId
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP)
{

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		unsigned context;
		mach_msg_max_trailer_t trailer;
	} Request;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	typedef __Request__RegisterStatusBarWindowContextId_t __Request;
	typedef __Reply__RegisterStatusBarWindowContextId_t Reply;

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
#ifdef	__MIG_check__Request__RegisterStatusBarWindowContextId_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Request__RegisterStatusBarWindowContextId_t__defined */

	__DeclareRcvRpc(2000022, "RegisterStatusBarWindowContextId")
	__BeforeRcvRpc(2000022, "RegisterStatusBarWindowContextId")

#if	defined(__MIG_check__Request__RegisterStatusBarWindowContextId_t__defined)
	check_result = __MIG_check__Request__RegisterStatusBarWindowContextId_t((__Request *)In0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ MIG_RETURN_ERROR(OutP, check_result); }
#endif	/* defined(__MIG_check__Request__RegisterStatusBarWindowContextId_t__defined) */

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
	OutP->RetCode = _SBXXRegisterStatusBarWindowContextId(In0P->Head.msgh_request_port, In0P->context, TrailerP->msgh_audit);

	OutP->NDR = NDR_record;


	__AfterRcvRpc(2000022, "RegisterStatusBarWindowContextId")
}

#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Request__SpringBoardServices_subsystem__
#if !defined(__MIG_check__Request__CheckInTaskPort_t__defined)
#define __MIG_check__Request__CheckInTaskPort_t__defined
#ifndef __NDR_convert__int_rep__Request__CheckInTaskPort_t__one__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__one__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__one(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__one__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__one(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__one__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__one(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__one__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__one(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__CheckInTaskPort_t__one__defined */

#ifndef __NDR_convert__int_rep__Request__CheckInTaskPort_t__two__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__two__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__two(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__two__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__two(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__two__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__two(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__two__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__two(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__CheckInTaskPort_t__two__defined */

#ifndef __NDR_convert__int_rep__Request__CheckInTaskPort_t__thr__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__thr__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__thr(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__thr__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__thr(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__thr__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__thr(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__thr__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__thr(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__CheckInTaskPort_t__thr__defined */

#ifndef __NDR_convert__int_rep__Request__CheckInTaskPort_t__fr__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__fr__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__fr(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__fr__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__fr(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__fr__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__fr(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__fr__defined
#define	__NDR_convert__int_rep__Request__CheckInTaskPort_t__fr(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__CheckInTaskPort_t__fr__defined */

#ifndef __NDR_convert__char_rep__Request__CheckInTaskPort_t__one__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__one__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__one(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__one__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__one(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__one__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__one(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__one__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__one(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__CheckInTaskPort_t__one__defined */

#ifndef __NDR_convert__char_rep__Request__CheckInTaskPort_t__two__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__two__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__two(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__two__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__two(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__two__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__two(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__two__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__two(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__CheckInTaskPort_t__two__defined */

#ifndef __NDR_convert__char_rep__Request__CheckInTaskPort_t__thr__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__thr__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__thr(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__thr__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__thr(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__thr__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__thr(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__thr__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__thr(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__CheckInTaskPort_t__thr__defined */

#ifndef __NDR_convert__char_rep__Request__CheckInTaskPort_t__fr__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__fr__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__fr(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__fr__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__fr(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__fr__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__fr(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__fr__defined
#define	__NDR_convert__char_rep__Request__CheckInTaskPort_t__fr(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__CheckInTaskPort_t__fr__defined */

#ifndef __NDR_convert__float_rep__Request__CheckInTaskPort_t__one__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__one__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__one(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__one__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__one(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__one__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__one(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__one__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__one(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__CheckInTaskPort_t__one__defined */

#ifndef __NDR_convert__float_rep__Request__CheckInTaskPort_t__two__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__two__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__two(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__two__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__two(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__two__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__two(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__two__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__two(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__CheckInTaskPort_t__two__defined */

#ifndef __NDR_convert__float_rep__Request__CheckInTaskPort_t__thr__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__thr__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__thr(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__thr__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__thr(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__thr__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__thr(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__thr__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__thr(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__CheckInTaskPort_t__thr__defined */

#ifndef __NDR_convert__float_rep__Request__CheckInTaskPort_t__fr__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__fr__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__fr(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__fr__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__fr(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__fr__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__fr(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__fr__defined
#define	__NDR_convert__float_rep__Request__CheckInTaskPort_t__fr(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__CheckInTaskPort_t__fr__defined */


mig_internal kern_return_t __MIG_check__Request__CheckInTaskPort_t(__attribute__((__unused__)) __Request__CheckInTaskPort_t *In0P)
{

	typedef __Request__CheckInTaskPort_t __Request;
#if	__MigTypeCheck
	if ((In0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (In0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Request)))
		return MIG_BAD_ARGUMENTS;
#endif	/* __MigTypeCheck */

#if	defined(__NDR_convert__int_rep__Request__CheckInTaskPort_t__one__defined) || \
	defined(__NDR_convert__int_rep__Request__CheckInTaskPort_t__two__defined) || \
	defined(__NDR_convert__int_rep__Request__CheckInTaskPort_t__thr__defined) || \
	defined(__NDR_convert__int_rep__Request__CheckInTaskPort_t__fr__defined)
	if (In0P->NDR.int_rep != NDR_record.int_rep) {
#if defined(__NDR_convert__int_rep__Request__CheckInTaskPort_t__one__defined)
		__NDR_convert__int_rep__Request__CheckInTaskPort_t__one(&In0P->one, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__CheckInTaskPort_t__one__defined */
#if defined(__NDR_convert__int_rep__Request__CheckInTaskPort_t__two__defined)
		__NDR_convert__int_rep__Request__CheckInTaskPort_t__two(&In0P->two, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__CheckInTaskPort_t__two__defined */
#if defined(__NDR_convert__int_rep__Request__CheckInTaskPort_t__thr__defined)
		__NDR_convert__int_rep__Request__CheckInTaskPort_t__thr(&In0P->thr, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__CheckInTaskPort_t__thr__defined */
#if defined(__NDR_convert__int_rep__Request__CheckInTaskPort_t__fr__defined)
		__NDR_convert__int_rep__Request__CheckInTaskPort_t__fr(&In0P->fr, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__CheckInTaskPort_t__fr__defined */
	}
#endif	/* defined(__NDR_convert__int_rep...) */

#if	defined(__NDR_convert__char_rep__Request__CheckInTaskPort_t__one__defined) || \
	defined(__NDR_convert__char_rep__Request__CheckInTaskPort_t__two__defined) || \
	defined(__NDR_convert__char_rep__Request__CheckInTaskPort_t__thr__defined) || \
	defined(__NDR_convert__char_rep__Request__CheckInTaskPort_t__fr__defined)
	if (In0P->NDR.char_rep != NDR_record.char_rep) {
#if defined(__NDR_convert__char_rep__Request__CheckInTaskPort_t__one__defined)
		__NDR_convert__char_rep__Request__CheckInTaskPort_t__one(&In0P->one, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__CheckInTaskPort_t__one__defined */
#if defined(__NDR_convert__char_rep__Request__CheckInTaskPort_t__two__defined)
		__NDR_convert__char_rep__Request__CheckInTaskPort_t__two(&In0P->two, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__CheckInTaskPort_t__two__defined */
#if defined(__NDR_convert__char_rep__Request__CheckInTaskPort_t__thr__defined)
		__NDR_convert__char_rep__Request__CheckInTaskPort_t__thr(&In0P->thr, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__CheckInTaskPort_t__thr__defined */
#if defined(__NDR_convert__char_rep__Request__CheckInTaskPort_t__fr__defined)
		__NDR_convert__char_rep__Request__CheckInTaskPort_t__fr(&In0P->fr, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__CheckInTaskPort_t__fr__defined */
	}
#endif	/* defined(__NDR_convert__char_rep...) */

#if	defined(__NDR_convert__float_rep__Request__CheckInTaskPort_t__one__defined) || \
	defined(__NDR_convert__float_rep__Request__CheckInTaskPort_t__two__defined) || \
	defined(__NDR_convert__float_rep__Request__CheckInTaskPort_t__thr__defined) || \
	defined(__NDR_convert__float_rep__Request__CheckInTaskPort_t__fr__defined)
	if (In0P->NDR.float_rep != NDR_record.float_rep) {
#if defined(__NDR_convert__float_rep__Request__CheckInTaskPort_t__one__defined)
		__NDR_convert__float_rep__Request__CheckInTaskPort_t__one(&In0P->one, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__CheckInTaskPort_t__one__defined */
#if defined(__NDR_convert__float_rep__Request__CheckInTaskPort_t__two__defined)
		__NDR_convert__float_rep__Request__CheckInTaskPort_t__two(&In0P->two, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__CheckInTaskPort_t__two__defined */
#if defined(__NDR_convert__float_rep__Request__CheckInTaskPort_t__thr__defined)
		__NDR_convert__float_rep__Request__CheckInTaskPort_t__thr(&In0P->thr, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__CheckInTaskPort_t__thr__defined */
#if defined(__NDR_convert__float_rep__Request__CheckInTaskPort_t__fr__defined)
		__NDR_convert__float_rep__Request__CheckInTaskPort_t__fr(&In0P->fr, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__CheckInTaskPort_t__fr__defined */
	}
#endif	/* defined(__NDR_convert__float_rep...) */

	return MACH_MSG_SUCCESS;
}
#endif /* !defined(__MIG_check__Request__CheckInTaskPort_t__defined) */
#endif /* __MIG_check__Request__SpringBoardServices_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine CheckInTaskPort */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t _SBXXCheckInTaskPort
(
	mach_port_t server,
	int one,
	int two,
	int thr,
	int fr,
	audit_token_t token
);

/* Routine CheckInTaskPort */
mig_internal novalue _XCheckInTaskPort
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP)
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
		mach_msg_max_trailer_t trailer;
	} Request;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	typedef __Request__CheckInTaskPort_t __Request;
	typedef __Reply__CheckInTaskPort_t Reply;

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
#ifdef	__MIG_check__Request__CheckInTaskPort_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Request__CheckInTaskPort_t__defined */

	__DeclareRcvRpc(2000118, "CheckInTaskPort")
	__BeforeRcvRpc(2000118, "CheckInTaskPort")

#if	defined(__MIG_check__Request__CheckInTaskPort_t__defined)
	check_result = __MIG_check__Request__CheckInTaskPort_t((__Request *)In0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ MIG_RETURN_ERROR(OutP, check_result); }
#endif	/* defined(__MIG_check__Request__CheckInTaskPort_t__defined) */

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
	OutP->RetCode = _SBXXCheckInTaskPort(In0P->Head.msgh_request_port, In0P->one, In0P->two, In0P->thr, In0P->fr, TrailerP->msgh_audit);

	OutP->NDR = NDR_record;


	__AfterRcvRpc(2000118, "CheckInTaskPort")
}

#if ( __MigTypeCheck || __NDR_convert__ )
#if __MIG_check__Request__SpringBoardServices_subsystem__
#if !defined(__MIG_check__Request__RegisterRemoteView_t__defined)
#define __MIG_check__Request__RegisterRemoteView_t__defined
#ifndef __NDR_convert__int_rep__Request__RegisterRemoteView_t__one__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__one__defined
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__one(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__one__defined
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__one(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__one__defined
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__one(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__one__defined
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__one(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__RegisterRemoteView_t__one__defined */

#ifndef __NDR_convert__int_rep__Request__RegisterRemoteView_t__two__defined
#if	defined(__NDR_convert__int_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__two__defined
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__two(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__int__defined)
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__two__defined
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__two(a, f) \
	__NDR_convert__int_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__int_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__two__defined
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__two(a, f) \
	__NDR_convert__int_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__int_rep__int32_t__defined)
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__two__defined
#define	__NDR_convert__int_rep__Request__RegisterRemoteView_t__two(a, f) \
	__NDR_convert__int_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__int_rep__Request__RegisterRemoteView_t__two__defined */

#ifndef __NDR_convert__char_rep__Request__RegisterRemoteView_t__one__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__one__defined
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__one(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__one__defined
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__one(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__one__defined
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__one(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__one__defined
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__one(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__RegisterRemoteView_t__one__defined */

#ifndef __NDR_convert__char_rep__Request__RegisterRemoteView_t__two__defined
#if	defined(__NDR_convert__char_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__two__defined
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__two(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__int__defined)
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__two__defined
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__two(a, f) \
	__NDR_convert__char_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__char_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__two__defined
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__two(a, f) \
	__NDR_convert__char_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__char_rep__int32_t__defined)
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__two__defined
#define	__NDR_convert__char_rep__Request__RegisterRemoteView_t__two(a, f) \
	__NDR_convert__char_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__char_rep__Request__RegisterRemoteView_t__two__defined */

#ifndef __NDR_convert__float_rep__Request__RegisterRemoteView_t__one__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__one__defined
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__one(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__one__defined
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__one(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__one__defined
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__one(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__one__defined
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__one(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__RegisterRemoteView_t__one__defined */

#ifndef __NDR_convert__float_rep__Request__RegisterRemoteView_t__two__defined
#if	defined(__NDR_convert__float_rep__SpringBoardServices__int__defined)
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__two__defined
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__two(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__int__defined)
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__two__defined
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__two(a, f) \
	__NDR_convert__float_rep__int((int *)(a), f)
#elif	defined(__NDR_convert__float_rep__SpringBoardServices__int32_t__defined)
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__two__defined
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__two(a, f) \
	__NDR_convert__float_rep__SpringBoardServices__int32_t((int32_t *)(a), f)
#elif	defined(__NDR_convert__float_rep__int32_t__defined)
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__two__defined
#define	__NDR_convert__float_rep__Request__RegisterRemoteView_t__two(a, f) \
	__NDR_convert__float_rep__int32_t((int32_t *)(a), f)
#endif /* defined(__NDR_convert__*__defined) */
#endif /* __NDR_convert__float_rep__Request__RegisterRemoteView_t__two__defined */


mig_internal kern_return_t __MIG_check__Request__RegisterRemoteView_t(__attribute__((__unused__)) __Request__RegisterRemoteView_t *In0P)
{

	typedef __Request__RegisterRemoteView_t __Request;
#if	__MigTypeCheck
	if ((In0P->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (In0P->Head.msgh_size != (mach_msg_size_t)sizeof(__Request)))
		return MIG_BAD_ARGUMENTS;
#endif	/* __MigTypeCheck */

#if	defined(__NDR_convert__int_rep__Request__RegisterRemoteView_t__one__defined) || \
	defined(__NDR_convert__int_rep__Request__RegisterRemoteView_t__two__defined)
	if (In0P->NDR.int_rep != NDR_record.int_rep) {
#if defined(__NDR_convert__int_rep__Request__RegisterRemoteView_t__one__defined)
		__NDR_convert__int_rep__Request__RegisterRemoteView_t__one(&In0P->one, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__RegisterRemoteView_t__one__defined */
#if defined(__NDR_convert__int_rep__Request__RegisterRemoteView_t__two__defined)
		__NDR_convert__int_rep__Request__RegisterRemoteView_t__two(&In0P->two, In0P->NDR.int_rep);
#endif	/* __NDR_convert__int_rep__Request__RegisterRemoteView_t__two__defined */
	}
#endif	/* defined(__NDR_convert__int_rep...) */

#if	defined(__NDR_convert__char_rep__Request__RegisterRemoteView_t__one__defined) || \
	defined(__NDR_convert__char_rep__Request__RegisterRemoteView_t__two__defined)
	if (In0P->NDR.char_rep != NDR_record.char_rep) {
#if defined(__NDR_convert__char_rep__Request__RegisterRemoteView_t__one__defined)
		__NDR_convert__char_rep__Request__RegisterRemoteView_t__one(&In0P->one, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__RegisterRemoteView_t__one__defined */
#if defined(__NDR_convert__char_rep__Request__RegisterRemoteView_t__two__defined)
		__NDR_convert__char_rep__Request__RegisterRemoteView_t__two(&In0P->two, In0P->NDR.char_rep);
#endif	/* __NDR_convert__char_rep__Request__RegisterRemoteView_t__two__defined */
	}
#endif	/* defined(__NDR_convert__char_rep...) */

#if	defined(__NDR_convert__float_rep__Request__RegisterRemoteView_t__one__defined) || \
	defined(__NDR_convert__float_rep__Request__RegisterRemoteView_t__two__defined)
	if (In0P->NDR.float_rep != NDR_record.float_rep) {
#if defined(__NDR_convert__float_rep__Request__RegisterRemoteView_t__one__defined)
		__NDR_convert__float_rep__Request__RegisterRemoteView_t__one(&In0P->one, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__RegisterRemoteView_t__one__defined */
#if defined(__NDR_convert__float_rep__Request__RegisterRemoteView_t__two__defined)
		__NDR_convert__float_rep__Request__RegisterRemoteView_t__two(&In0P->two, In0P->NDR.float_rep);
#endif	/* __NDR_convert__float_rep__Request__RegisterRemoteView_t__two__defined */
	}
#endif	/* defined(__NDR_convert__float_rep...) */

	return MACH_MSG_SUCCESS;
}
#endif /* !defined(__MIG_check__Request__RegisterRemoteView_t__defined) */
#endif /* __MIG_check__Request__SpringBoardServices_subsystem__ */
#endif /* ( __MigTypeCheck || __NDR_convert__ ) */


/* Routine RegisterRemoteView */
#ifdef	mig_external
mig_external
#else
extern
#endif	/* mig_external */
kern_return_t _SBXXRegisterRemoteView
(
	mach_port_t server,
	int one,
	int two,
	audit_token_t token
);

/* Routine RegisterRemoteView */
mig_internal novalue _XRegisterRemoteView
	(mach_msg_header_t *InHeadP, mach_msg_header_t *OutHeadP)
{

#ifdef  __MigPackStructs
#pragma pack(4)
#endif
	typedef struct {
		mach_msg_header_t Head;
		NDR_record_t NDR;
		int one;
		int two;
		mach_msg_max_trailer_t trailer;
	} Request;
#ifdef  __MigPackStructs
#pragma pack()
#endif
	typedef __Request__RegisterRemoteView_t __Request;
	typedef __Reply__RegisterRemoteView_t Reply;

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
#ifdef	__MIG_check__Request__RegisterRemoteView_t__defined
	kern_return_t check_result;
#endif	/* __MIG_check__Request__RegisterRemoteView_t__defined */

	__DeclareRcvRpc(2000120, "RegisterRemoteView")
	__BeforeRcvRpc(2000120, "RegisterRemoteView")

#if	defined(__MIG_check__Request__RegisterRemoteView_t__defined)
	check_result = __MIG_check__Request__RegisterRemoteView_t((__Request *)In0P);
	if (check_result != MACH_MSG_SUCCESS)
		{ MIG_RETURN_ERROR(OutP, check_result); }
#endif	/* defined(__MIG_check__Request__RegisterRemoteView_t__defined) */

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
	OutP->RetCode = _SBXXRegisterRemoteView(In0P->Head.msgh_request_port, In0P->one, In0P->two, TrailerP->msgh_audit);

	OutP->NDR = NDR_record;


	__AfterRcvRpc(2000120, "RegisterRemoteView")
}


extern boolean_t SpringBoardServices_server(
		mach_msg_header_t *InHeadP,
		mach_msg_header_t *OutHeadP);

extern mig_routine_t SpringBoardServices_server_routine(
		mach_msg_header_t *InHeadP);


/* Description of this subsystem, for use in direct RPC */
const struct _SBXXSpringBoardServices_subsystem {
	mig_server_routine_t 	server;	/* Server routine */
	mach_msg_id_t	start;	/* Min routine number */
	mach_msg_id_t	end;	/* Max routine number + 1 */
	unsigned int	maxsize;	/* Max msg size */
	vm_address_t	reserved;	/* Reserved */
	struct routine_descriptor	/*Array of routine descriptors */
		routine[121];
} _SBXXSpringBoardServices_subsystem = {
	SpringBoardServices_server_routine,
	2000000,
	2000121,
	(mach_msg_size_t)sizeof(union __ReplyUnion___SBXXSpringBoardServices_subsystem),
	(vm_address_t)0,
	{
          { (mig_impl_routine_t) 0,
          (mig_stub_routine_t) _XAppWillOrderInContext, 12, 0, (routine_arg_descriptor_t)0, (mach_msg_size_t)sizeof(__Reply__AppWillOrderInContext_t)},
          { (mig_impl_routine_t) 0,
          (mig_stub_routine_t) _XAppDidOrderOutContext, 10, 0, (routine_arg_descriptor_t)0, (mach_msg_size_t)sizeof(__Reply__AppDidOrderOutContext_t)},
		{0, 0, 0, 0, 0, 0},
          { (mig_impl_routine_t) 0,
          (mig_stub_routine_t) _XLaunchApplicationWithIdentifier, 19, 0, (routine_arg_descriptor_t)0, (mach_msg_size_t)sizeof(__Reply__LaunchApplicationWithIdentifier_t)},
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
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
          { (mig_impl_routine_t) 0,
          (mig_stub_routine_t) _XRegisterStatusBarWindowContextId, 10, 0, (routine_arg_descriptor_t)0, (mach_msg_size_t)sizeof(__Reply__RegisterStatusBarWindowContextId_t)},
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
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0},
          { (mig_impl_routine_t) 0,
          (mig_stub_routine_t) _XCheckInTaskPort, 13, 0, (routine_arg_descriptor_t)0, (mach_msg_size_t)sizeof(__Reply__CheckInTaskPort_t)},
		{0, 0, 0, 0, 0, 0},
          { (mig_impl_routine_t) 0,
          (mig_stub_routine_t) _XRegisterRemoteView, 11, 0, (routine_arg_descriptor_t)0, (mach_msg_size_t)sizeof(__Reply__RegisterRemoteView_t)},
	}
};

mig_external boolean_t SpringBoardServices_server
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

	if ((InHeadP->msgh_id > 2000120) || (InHeadP->msgh_id < 2000000) ||
	    ((routine = _SBXXSpringBoardServices_subsystem.routine[InHeadP->msgh_id - 2000000].stub_routine) == 0)) {
		((mig_reply_error_t *)OutHeadP)->NDR = NDR_record;
		((mig_reply_error_t *)OutHeadP)->RetCode = MIG_BAD_ID;
		return FALSE;
	}
	(*routine) (InHeadP, OutHeadP);
	return TRUE;
}

mig_external mig_routine_t SpringBoardServices_server_routine
	(mach_msg_header_t *InHeadP)
{
	register int msgh_id;

	msgh_id = InHeadP->msgh_id - 2000000;

	if ((msgh_id > 120) || (msgh_id < 0))
		return 0;

	return _SBXXSpringBoardServices_subsystem.routine[msgh_id].stub_routine;
}
