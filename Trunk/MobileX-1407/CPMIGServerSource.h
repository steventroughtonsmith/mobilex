/*
 *  CPMIGServerSource.h
 *  AppSupport
 */

#import <Foundation/Foundation.h>

CFRunLoopSourceRef
CPCreateMIGServerSource(void* subsystem,
						mach_port_t port,
						int order);

