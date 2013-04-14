/*
 
 # MXBundle
 # SpringBoardSupport
 
 A flat, file based bundle
 Unlike (CF/NS)Bundle, this bundle does not cache
 It also lacks the capability to bootstrap code
 
 MXBundle is a essentially a nice wrapper for the Info.plist file
 */


#import <Foundation/Foundation.h>

@interface MXBundle : NSObject {
	NSDictionary* _infoDictionary;
	NSString* _bundlePath;
	NSString* _executablePath;
}

- (id) initWithPath:(NSString*)path;

- (NSString*) bundleIdentifier;
- (NSDictionary*) infoDictionary;
- (NSString*) executablePath;
- (NSString*) bundleIdentifier;
- (NSString*) bundlePath;

@end
