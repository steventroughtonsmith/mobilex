/*
 *  CPMIGProbing.h
 *  AppSupport
 */

#import "CPMIGProbing.h"
#import <mach/mach.h>

void CPProbeInMemStruct(void* InHeadP, int offset, int size)
{
	int fourCount = 0;
	int four = 3;
	
	printf("---------------------------------------------------------------------------------\n");
	printf(" Addr   | IntVal       | PtrVal       | FloatVal                | Byte  |  Char  \n");
	printf("---------------------------------------------------------------------------------\n");
	for (int i = offset; i <= size; i++)
	{
		int* ptr = (int*)((char*)(InHeadP) + i);
		int deref = *(ptr);
		float deref_fl = *(ptr);
		char deref_ch = *(ptr);
		
		if (deref_ch == 0){
			deref_ch = ' ';
		}
		
		if (four == 3) {
			fourCount++;
			printf("I: ");
			four=0;
		}
		else {
			printf("   ");
			four+=1;
		}
		
		
		printf("%-4d | %12d | %12p | %23f | %5d | %1c \n",i,deref,(void*)deref,deref_fl,deref_ch,deref_ch);
	}
	printf("---------------------------------------------------------------------------------\n");
}

void CPProbeMachHeader(mach_msg_header_t* InHeadP,int msgSize)
{
	printf("\n\n");
	printf("------------------------------------- MiG Probe ---------------------------------\n");
	printf("Size: %d\n",InHeadP->msgh_size);
	printf("ID  : %d \n",InHeadP->msgh_id);
	printf("Ptr : %p\n",InHeadP);
	printf("Vers: %d \n",((mig_reply_error_t *)InHeadP)->NDR.mig_vers);
	
	CPProbeInMemStruct(InHeadP, 32, InHeadP->msgh_size);
}