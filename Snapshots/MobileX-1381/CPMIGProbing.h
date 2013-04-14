/*
 *  CPMIGProbing.h
 *  AppSupport
 */

#import <Foundation/Foundation.h>

/*
 * MiG Packet analyzer
 * Run on a mach_msg_header to get a dump
 */
void CPProbeMachHeader(mach_msg_header_t* InHeadP,int msgSize);

void CPProbeInMemStruct(void* InHeadP, int offset, int size);