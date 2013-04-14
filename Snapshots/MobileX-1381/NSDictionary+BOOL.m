//
//  NSDictionary+BOOL.m
//  BuildBot
//
//  Created by Nick on 11/03/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import "NSDictionary+BOOL.h"


@implementation NSDictionary (booleanDict)

- (void) addKeysFromDictionary:(NSDictionary*)md
{
	if (![self isKindOfClass:[NSMutableDictionary class]])
	{
		MXLog(@" *** A non mutalbe type can't merge.");
		return;
	}
	
	for (NSString* key in md)
	{
		[(NSMutableDictionary*)self setObject:[md objectForKey:key] forKey:key];
	}
}

- (BOOL) boolForKey:(NSString*)key
{
	id value = [self objectForKey:key];
	
	if ([value isKindOfClass:[NSString class]])
	{
		if ([value isEqualToString:@"YES"])
		{
			return TRUE;
		}
		else 
		{
			return FALSE;
		}
	}
	else if ([value isKindOfClass:[NSNumber class]])
	{
		if ([value intValue] == 1)
		{
			return TRUE;
		}
		else 
		{
			return FALSE;
		}
	}
	else 
	{
		return FALSE;
	}
}

@end
