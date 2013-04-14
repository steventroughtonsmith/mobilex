//
//  coreAnimationPatcher.m
//  MobileX
//
//  Created by Nick on 01/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "coreAnimationPatcher.h"
#import "ImageLoaderMachO.h"
#include <mach-o/nlist.h>
#include <dlfcn.h>

#include <sys/mman.h>
#include <sys/stat.h>
#include <dlfcn.h>

extern "C" {
	void caFix();
	void sys_icache_invalidate(void* one, uint32_t two);
}

void patchCoreAnimation(void) {
	const char* uiKitPath =
	"/System/Library/Frameworks/QuartzCore.framework/QuartzCore";
	
	/* get dyld to load UIKit */
	dlopen(uiKitPath, RTLD_NOW);
	
	ImageLoaderMachO* loader =
	dyld::getDyldImage(uiKitPath);
	
	Symbol* sym = 
	loader->getSymbolByName("_CASSetDisplayOverscanAdjustment");
	
	void* symAddr = 
	sym->getPtrValue();
	
	int page = getpagesize();
    uintptr_t address = (uintptr_t)symAddr;
    uintptr_t base = address / page * page;
	
    if (page - (address - base) < 8)
        page *= 2;
	
    mach_port_t self = mach_task_self();
	
    if (kern_return_t error = vm_protect(self, base, page, FALSE, VM_PROT_READ | VM_PROT_WRITE | VM_PROT_COPY)) {
        fprintf(stderr, "can't acquire write access to symtab, vm_protect():%d\n", error);
        return;
    }
	
	*((uint8_t*)symAddr) = 0x70;
	*((uint8_t*)symAddr+1) = 0x47;
	
	printf("sym: %p \n", sym);
	
	//sys_icache_invalidate(symAddr, 32);
	//sys_icache_invalidate(*((void**)symAddr), 32);
}