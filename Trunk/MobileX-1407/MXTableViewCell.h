/*
 MXTableViewCell:Header
 
 UITableViewCell-like thing. Well. Not really.
 Still works though.
 */

#import <Foundation/Foundation.h>
#import "MXText.h"
#import "MXCG.h"
#import "MXColors.h"
#import "MXCheckbox.h"
#import "MXLayer.h"

@interface MXTableViewCell : MXLayer {
	MXText* _label;
	NSIndexPath* _indexPath;
	BOOL _highlighted;
}

@property (readonly) MXText* label;
@property (retain) NSIndexPath* indexPath;

@end
