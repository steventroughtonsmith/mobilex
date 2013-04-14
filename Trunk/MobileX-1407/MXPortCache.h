//
//  MXPortCache.h
//  MobileX
//
//  Created by Nick on 18/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct __MXPortCacheEntry {
	mach_port_t port;
	id entry;
} MXPortCacheEntry;

void MXPortCacheStart();
void MXPortCacheCheckIn(mach_port_t port, id entry);
id MXPortCacheLookup(mach_port_t port);