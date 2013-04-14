/* Expose Manager */

#import <Foundation/Foundation.h>
#import "MXPaneManager.h"

@interface MXPaneManager (Expose)

- (void) toggleExpose;

- (void) startExpose:(BOOL)newSession;
- (void) startExpose;

- (void) stopExpose;

@end
