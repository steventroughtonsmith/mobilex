/*
 
 # MXBundle
 # SpringBoardSupport
 
 A flat, file based bundle
 Unlike (CF/NS)Bundle, this bundle does not cache
 It also lacks the capability to bootstrap code
 
 MXBundle is a essentially a nice wrapper for the Info.plist file
 */

#import "MXBundle.h"

@implementation MXBundle

- (NSString*) bundleIdentifier
{
	return [_infoDictionary objectForKey:(NSString*)kCFBundleIdentifierKey];
}

- (NSString*) executablePath
{
	NSString* path = _executablePath;
	
	if ([path hasPrefix:@"/private/var/"])
	{
		path = [path stringByReplacingCharactersInRange:NSMakeRange(0, [@"/private/var/" length]) withString:@"/var/"];
	}
	
	return path;
}

- (NSDictionary*) infoDictionary
{
	return _infoDictionary;
}

- (void) dealloc
{
	[_bundlePath release];
	[_infoDictionary release];
	
	[super dealloc];
}

- (NSString*) description
{
	return [NSString stringWithFormat:@"<Bundle '%@'>",[self bundleIdentifier]];
}

- (NSString*) bundlePath
{
	return _bundlePath;
}

- (id) initWithPath:(NSString*)path
{
	_bundlePath = path;
	
	NSString* infoPlistPath = [path stringByAppendingPathComponent:@"Info.plist"];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:infoPlistPath])
	{
		_infoDictionary = [NSDictionary dictionaryWithContentsOfFile:infoPlistPath];
		
		_executablePath = [_bundlePath stringByAppendingPathComponent:[_infoDictionary objectForKey:(NSString*)kCFBundleExecutableKey]];
		
		[_executablePath retain];
		[_infoDictionary retain];
		[_bundlePath retain];
		
		if ([self bundleIdentifier] == nil)
		{
			MSLog(@"Failed to load bundle at path %@ (the bundle is missing an identifier)",path);
			return nil;
		}
		
		return self;
	}
	else 
	{
		MSLog(@"Failed to load bundle at path %@ (missing Info.plist)",path);
		return nil;
	}
}

@end
