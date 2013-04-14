//
//  NSDictionary+BOOL.h
//  BuildBot
//
//  Created by Nick on 11/03/1981.
//  Copyright 1981 MxWmSrvApp_NX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+BOOL.h"

@interface NSDictionary (booleanDict)

- (BOOL) boolForKey:(NSString*)key;
- (void) addKeysFromDictionary:(NSDictionary*)md;

@end
