/*
 MXTableSectionHeader:Impl
 
 Text layer to serve as the section header label.
 */

#import "MXTableSectionHeader.h"
#import "MXUIDrawing.h"
#import "MXTableView.h"

@implementation MXTableSectionHeader

- (id) init
{
	[super init];
	
	[self setHorizontalAlign:kMXTextHorizontalAlignLeft];
	[self setFont:[MXFont boldFontWithFamily:@"Helvetica" size:17]];
	[self setShadowColor:WHT(1)];
	[self setShadowOffset:CGSizeMake(0, 1)];
	
	return self;
}

- (void) drawInContext:(CGContextRef)ctx
{
	CALayer* tableView = [[[self superlayer] superlayer] superlayer];
	if (tableView != nil && [tableView isKindOfClass:[MXTableView class]])
	{
		[(MXTableView*)tableView drawSectionHeader:self
										 inContext:ctx];
	}
	[super drawInContext:ctx];
}

- (float) cellHeight
{
	return 30;
}

@end
