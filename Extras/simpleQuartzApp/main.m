/*
 * main.m
 */

#import <Foundation/Foundation.h>

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import <QuartzCore/CAWindowServer.h>
#import <QuartzCore/CAWindowServerDisplay.h>
#import <QuartzCore/CAContext.h>

#import "simpleLayer.h"

@interface CADisplay : NSObject {
@private
	void* _impl;
}
@property(readonly, assign) CGRect bounds;
@property(readonly, assign) NSString* deviceName;
@property(readonly, assign) NSString* name;
+(id)displays;
+(id)mainDisplay;
+(id)TVOutDisplay;

@end

extern NSString* kCAContextDefinesDisplayBounds;
extern NSString* kCAWindowServerTVSignalType_Digital;

CAContext* lk_createContext() {
	mach_port_t t = 0;// CARenderServerGetServerPort(0);
	
	if (t == 0) {
		
		NSLog(@"enforcing autoresize via qrtz!!!!!!!");
		[CAWindowServer	server];
		return [CAContext localContextWithOptions:[NSDictionary dictionaryWithObjectsAndKeys:
												   (id)kCFBooleanTrue,kCAContextDefinesDisplayBounds,
												   nil]];
		
	}
	else {
		NSLog(@"purple stuff is running");
		//_exit(0);
		return [CAContext remoteContextWithOptions:[NSDictionary dictionaryWithObjectsAndKeys:
													(id)kCFBooleanTrue,kCAContextDefinesDisplayBounds,
													nil]];
	}
}

int main(int argc, char *argv[]) {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	CAContext* ctx = lk_createContext();
	CAWindowServer* srv = [CAWindowServer server];
	NSArray* displays = [srv displays];
	
	NSLog(@"main(per quartz) %@", [CADisplay mainDisplay]);
	
	NSLog(@"qrtz displays:");
	for (CADisplay* qd in [CADisplay displays]) {
		NSLog(@"\t%@ {%f %f}", qd, qd.bounds.size.width, qd.bounds.size.height);
	}
	
	NSLog(@"displays:");
	
	for (CAWindowServerDisplay* ds in displays) {
		NSLog(@"\t%@, size {%f, %f}, blank %d", [ds name], [ds bounds].size.width, [ds bounds].size.height, ds.isBlanked);
		
		if ([[ds name] isEqualToString:@"TVOut"]) {
			NSLog(@"\t\t * i can haz signal");
			[ds setTVSignalType:kCAWindowServerTVSignalType_Digital];
		}
	}
	
	CAWindowServerDisplay* u = [displays objectAtIndex:0];
	NSLog(@"using %@ as primary dsp.", [u name]);
	
	NSLog(@"force unblank on %@ (state: %d).", [u name], [u isBlanked]);
	[u setBlanked:FALSE];
	//CGRectMake(0, 0, u.bounds.size.width, u.bounds.size.height)
	
	simpleLayer* rt = [[simpleLayer alloc] initWithBoundsAndStyle:CGRectMake(0, 0, 1280, 720)
															style:2
															  red:0.6 
															 green:0.0
															 blue:0.0
															alpha:1.0];
	
	[ctx setLayer:rt];
	[ctx setLevel:100];
	
	CFRunLoopRun();
	
	[pool release];
}
