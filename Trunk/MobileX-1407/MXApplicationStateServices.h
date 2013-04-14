/* 
 State services.
 Interaction with applications.
 */

#import <Foundation/Foundation.h>

/*
 * Runs an application for a specific identifier 
 * This is the only function that should be used for starting applications.
 */
void MXLaunchApplicationWithIdentifier(NSString* identifier);