/*
 * MachO Image Loader
 * This isn't from dyld, I wrote it myself.
 */

#include <mach/mach_time.h> 
#include <mach/mach_init.h> 
#include <mach-o/loader.h> 
#include <mach-o/nlist.h> 

#include <mach/mach.h>
#include <mach/mach_init.h>

#include <mach-o/dyld.h>
#include <mach-o/fat.h>
#include <mach-o/loader.h>

#include <mach-o/nlist.h>

#define BSD_KERNEL_PRIVATE
#include <machine/types.h>
#import <unistd.h>
#include <list>


typedef struct mach_header macho_header;
typedef struct nlist macho_nlist;
typedef struct segment_command macho_segment_command;
typedef struct section macho_section;
typedef struct routines_command macho_routines_command;

class Symbol {
	protected:
	macho_nlist fNlist;
	size_t fSlide;
	
	public:
	Symbol(macho_nlist nlist, size_t slide);
	
	uint32_t getValue();
	void* getPtrValue();
};

class ImageLoaderMachO {
	protected:
		macho_header* fMachOHeader;
		
		macho_segment_command* fSegmentCommands[255];
		macho_segment_command* fLinkEdit;
		uint8_t* fLinkEditBase;
		symtab_command* fSymtab;
		uint32_t fSegmentCount;
		size_t fSlide;
	
	public:
		ImageLoaderMachO(const macho_header* mh, size_t slide);
		
		void parseLoadCommands();
		void parseSegment(macho_segment_command* segment);
	
		const macho_segment_command* segLoadCommand(uint32_t segIndex);
		
		Symbol* getSymbolByName(const char* name);
		Symbol* getSymbolByName(const char* name, uint32_t index);
	
		uintptr_t segLoadAddress(uint32_t index);
		uint32_t segFileSize(uint32_t index);
		uintptr_t segFileOffset(uint32_t index);
	
		void getSectionContent(uint32_t segIndex, const char* sectionName, void** start, size_t* length);
};

namespace dyld {
	ImageLoaderMachO* getDyldImage(const char* name);
}
