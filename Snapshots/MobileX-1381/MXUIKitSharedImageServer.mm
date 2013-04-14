/*
 
 # UIKit Shared Image Server Stub
 # SpringBoardSupport
 
 Can I haz UIKit? 
 
 */

#import "MXUIKitSharedImageServer.h"
#import "ImageLoaderMachO.h"
#include <mach-o/nlist.h>
#include <dlfcn.h>

#include <sys/mman.h>
#include <sys/stat.h>
#include <dlfcn.h>

#include <string.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#import "legacyUiSharedImageServer.h"

//#define ownServer

extern "C" {
	typedef void* (*meth__UISharedImageInitialize)(void);
}

#define assertSym(val, sym) if (!val) { printf(" *** Failed to locate symbol %s\n", #sym); _exit(0); }

#define loadSymbol(symbol) \
Symbol* sym_##symbol = loader->getSymbolByName(("_" #symbol));\
assertSym(sym_##symbol != 0, sym_##symbol);\
meth_##symbol symbol = (meth_##symbol)sym_##symbol->getValue();\
symbol = symbol;\
delete sym_##symbol

void StartUIKitSharedImageServer()
{
	//legacyUiSharedImageServerStart();
	//return;

	/*
	 * super hacky way of loading the bootstrapping
	 * UIKit's shared image server.
	 */
	
	const char* uiKitPath =
	"/System/Library/Frameworks/UIKit.framework/UIKit";
	
	/* get dyld to load UIKit */
	dlopen(uiKitPath, RTLD_NOW);
	
	ImageLoaderMachO* loader =
	dyld::getDyldImage(uiKitPath);
	
	loadSymbol(_UISharedImageInitialize);

	_UISharedImageInitialize();
}