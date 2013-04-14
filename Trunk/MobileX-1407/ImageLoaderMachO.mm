/*
 * MachO Image Loader
 * This isn't from dyld, I wrote it myself.
 */

#import "ImageLoaderMachO.h"

ImageLoaderMachO* dyld::getDyldImage(const char *name) {
	for (uint32_t image = (0), images =(_dyld_image_count()); image != images; ++image) {
		if (strcmp(_dyld_get_image_name(image), name) == 0)
		{
			/* so it doesn't segfault */
			assert(_dyld_get_image_header(image) != NULL);
			
            return new ImageLoaderMachO((macho_header*)_dyld_get_image_header(image), 
										(uint32_t)_dyld_get_image_vmaddr_slide(image));
		}
	}
	
	return NULL;
}

Symbol::Symbol(macho_nlist nlist, size_t slide) {
	this->fNlist = nlist;
	this->fSlide = slide;
}

uint32_t Symbol::getValue() {
	if ((this->fNlist.n_desc & N_ARM_THUMB_DEF) != 0) {
		return (this->fNlist.n_value | 0x00000001) + fSlide;
	}
	else {
		return this->fNlist.n_value + fSlide;
	}
}

void* Symbol::getPtrValue() {
	return (void*)this->getValue();
}

ImageLoaderMachO::ImageLoaderMachO(const macho_header* mh, size_t slide) {
	this->fMachOHeader = (macho_header*)mh;
	this->fSlide = slide;
	this->fSegmentCount = 0;
	
	this->parseLoadCommands();
}

const macho_segment_command* ImageLoaderMachO::segLoadCommand(uint32_t segIndex) {
	macho_segment_command* seg = fSegmentCommands[segIndex];
	return seg;
}

Symbol* ImageLoaderMachO::getSymbolByName(const char* name, uint32_t index) {
	uint8_t* linkEditBase = fLinkEditBase;

	const char* symbolTableStrings = (const char*)&linkEditBase[fSymtab->stroff];
	const macho_nlist* symbolTable = (macho_nlist*)(&linkEditBase[fSymtab->symoff]);
	uint32_t hits = 0;
	
	for (int i = 0; i < fSymtab->nsyms; i++) {
		macho_nlist sym = symbolTable[i];
		if (sym.n_un.n_strx == 0 || (sym.n_type & N_STAB) != 0)
			continue;
		
		const char *symname = &symbolTableStrings[sym.n_un.n_strx];
		
		if (strcmp(name, symname) == 0 && symname != NULL) {
			if (hits == index) {
				return new Symbol(sym, fSlide);
			}
			
			hits++;
		}
	}
	
	return NULL;
}

uintptr_t ImageLoaderMachO::segLoadAddress(uint32_t index) {
	return (this->segLoadCommand(index)->vmaddr + fSlide);
}

uint32_t ImageLoaderMachO::segFileSize(uint32_t index) {
	return (this->segLoadCommand(index)->filesize);
}

uintptr_t ImageLoaderMachO::segFileOffset(uint32_t index) {
	return (this->segLoadCommand(index)->fileoff);
}

Symbol* ImageLoaderMachO::getSymbolByName(const char* name) {
	return this->getSymbolByName(name, 0);
}

void ImageLoaderMachO::getSectionContent(uint32_t segIndex, const char* sectionName, void** start, size_t* length)
{
	uint8_t* position = (uint8_t*)segLoadCommand(segIndex) + 
						sizeof(macho_segment_command);
	
	for (int i = 0; i < segLoadCommand(segIndex)->nsects; i++) {
		macho_section* sect = (macho_section*)(position);
		
		if (strcmp(sect->sectname, sectionName) == 0) {
			*start = (void*)(fSlide + sect->addr);
			*length = sect->size;
			
			return;
		}
		
		position += sizeof(macho_section);
	}
}

void ImageLoaderMachO::parseSegment(macho_segment_command* seg) {
	fSegmentCommands[fSegmentCount] = seg;

	if (strcmp(SEG_LINKEDIT, seg->segname) == 0) {
		fLinkEdit = seg;
		fLinkEditBase = (uint8_t*)(this->segLoadAddress(fSegmentCount) -
								   this->segFileOffset(fSegmentCount));
	}
	else if (strcmp(SEG_TEXT, seg->segname) == 0) {
		/*
		 * __TEXT segment is always at the beginning
		 */
	}
	
	fSegmentCount++;
}

void ImageLoaderMachO::parseLoadCommands() {
	uint32_t position = (uint32_t)(sizeof(macho_header) +
								   ((uint8_t*)(fMachOHeader))); /* wat? */
	
	load_command* cmd = NULL;
	
	for (int i = 0; i < fMachOHeader->ncmds; i++) {
		cmd = (load_command*)(position);
		switch (cmd->cmd) {
			case LC_LOADFVMLIB:
				{
					fvmlib_command* l = 
					(fvmlib_command*)cmd;
					l=l;
					
					/* ugh */
				}
				break;
			case LC_SYMTAB:
				{
					fSymtab = (struct symtab_command*)cmd;
				}
				break;
			case LC_SEGMENT:
				{
					macho_segment_command* seg = 
					(macho_segment_command*)cmd;
					
					this->parseSegment(seg);
				}
				break;
			default:
				{
					
				}
				break;
		}
		
		position += cmd->cmdsize;
	}
}