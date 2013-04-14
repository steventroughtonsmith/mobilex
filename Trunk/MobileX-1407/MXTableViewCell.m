/*
 MXTableViewCell:Impl
 
 UITableViewCell-like thing. Well. Not really.
 Still works though.
 */

#import "MXTableViewCell.h"
#import "MXUIDrawing.h"
#import "MXTableView.h"

@implementation MXTableViewCell

@synthesize indexPath=_indexPath;

- (id) init
{
	[super init];
	
	_label = [MXText text:@"" inRect:CGRectMake(0, 0, 10, 10)];
	[self addSublayer:_label];
	[_label setFont:[MXFont boldFontWithFamily:@"Helvetica" size:17]];
	[_label setColor:WHT(0)];
	[_label setHorizontalAlign:kMXTextHorizontalAlignLeft];
	[_label retain];
	
	return self;
}

- (MXText*) label
{
	return _label;
}

- (void) drawInContext:(CGContextRef)ctx
{
	CALayer* tableView = [[[self superlayer] superlayer] superlayer];
	if (tableView != nil && [tableView isKindOfClass:[MXTableView class]])
	{
		[(MXTableView*)tableView drawCell:self
								inContext:ctx];
	}
}

- (void) setFrame:(CGRect)frame
{
	[super setFrame:frame];
	[_label setFrame:CGRectMake(10, 0, self.frame.size.width, self.frame.size.height)];
}

@end
