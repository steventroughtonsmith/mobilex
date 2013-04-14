//
//  MXPortCache.m
//  MobileX
//
//  Created by Nick on 18/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXPortCache.h"

static MXPortCacheEntry* _entries;
static int _count = 0;

void MXPortCacheStart()
{
	/* XXX: This is bound to crash. */
	_entries = malloc(sizeof(MXPortCacheEntry)*1024);
}

void MXPortCacheCheckIn(mach_port_t port, id entry)
{
	_entries[_count].port = port;
	_entries[_count].entry = entry;
	_count += 1;
}

id MXPortCacheLookup(mach_port_t port)
{
	for (int i = 0; i < _count; i++) {
		if (_entries[i].port == port) {
			return _entries[i].entry;
		}
	}
	
	return nil;
}