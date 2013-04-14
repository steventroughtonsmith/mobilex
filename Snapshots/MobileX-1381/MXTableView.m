/*
 MXTableView:Impl
 
 My terrible implementation of UITableView.
 Works in a similar fashion to it (but doesn't support editing).
 */

#import "MXTableView.h"
#import "MXUIDrawing.h"

@implementation MXTableView

@synthesize dataSource=_dataSource;

- (id) initWithFrame:(CGRect)rect
{
	[super initWithFrame:rect];
	
	_sections = [NSMutableArray new];
	_specialCells = [NSMutableArray new];
	_style = kMXTableViewStylePlain;
	
	[self setScrollVertically:TRUE];
	return self;
}

- (id) initWithFrame:(CGRect)rect style:(MXTableViewStyle)style
{
	[super initWithFrame:rect];
	
	_sections = [NSMutableArray new];
	_specialCells = [NSMutableArray new];
	_style = style;
	
	[self setScrollVertically:TRUE];
	return self;
}

- (float) _headerCellHeight
{
	if (_style == kMXTableViewStylePlain) {
		return 18;
	}
	else {
		return 30;
	}
}

- (float) _cellHeight
{
	return 50;
}

- (NSInteger) _numberOfSections
{
	if (_dataSource != nil &&
		[_dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)])
	{
		return [_dataSource numberOfSectionsInTableView:self];
	}
	else {
		return 1;
	}
}

- (NSString*) _titleForHeaderInSection:(NSInteger)section
{
	if (_dataSource != nil &&
		[_dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)])
	{
		return [_dataSource tableView:self
			  titleForHeaderInSection:section];
	}
	else {
		return nil;
	}
}

- (NSInteger) _numberOfRowsForSection:(NSInteger)section
{
	return [_dataSource tableView:self
			numberOfRowsInSection:section];
}

- (NSIndexPath*) _indexPathForSection:(NSInteger)section
								atRow:(int)row
{
	NSUInteger ind[2] = {section,row};
	return [NSIndexPath indexPathWithIndexes:ind length:2];
}

- (MXTableViewCell*) _getCellInSection:(NSInteger)section
								 atRow:(int)row
{
	NSIndexPath* path = [self _indexPathForSection:section atRow:row];
	
	return [_dataSource tableView:self
			cellForRowAtIndexPath:path];
}

- (void) _loadCellsInSection:(NSUInteger)section
{
	if (_dataSource != nil)
	{
		NSMutableArray* cells = [NSMutableArray new];
		NSInteger rowCount = [self _numberOfRowsForSection:section];
		
		for (int i = 0;i < rowCount; i++)
		{
			/* load one more cell */
			MXTableViewCell* cell = [self _getCellInSection:section
													  atRow:i];
			
			[cell setIndexPath:[self _indexPathForSection:section atRow:i]];
			[cells addObject:cell];
		}
		
		[_sections addObject:cells];
	}
}

- (void) drawSectionHeader:(MXTableSectionHeader*)cell inContext:(CGContextRef)context
{
	CGRect zRect = CGRectBaseOrigin(cell.frame);
	
	if (_style == kMXTableViewStylePlain) {
		[MXUIDrawing drawLinearGradientInContext:context
										  inRect:zRect
										  color1:WHTA(0.4,0.5)
										  color2:WHTA(0.4,0.9)];
	}
	else {
		/* pass */
	}
}

- (void) drawCell:(MXTableViewCell*)cell inContext:(CGContextRef)context
{
	CGRect zRect = CGRectBaseOrigin(cell.frame);
	
	if (_style == kMXTableViewStylePlain) {
		/* Plain style */
		CGContextSetFillColorWithColor(context, WHT(1));
		
		CGContextAddRect(context, zRect);
		CGContextFillPath(context);
		
		
		CGContextSetStrokeColorWithColor(context, WHT(0.7));
		
		CGContextMoveToPoint(context, 0, 0);
		CGContextAddLineToPoint(context, zRect.size.width, 0);
		CGContextStrokePath(context);
	}
	else {
		/* Categorized style */
		CGRect outsetRect;
		
		if ([[cell indexPath] indexAtPosition:1] == 0) {
			outsetRect = CGRectMake(1.5, 0.5, zRect.size.width-2, zRect.size.height+20);
		}
		else if ([[cell indexPath] indexAtPosition:1]+1 == 
				 [self _numberOfRowsForSection:[[cell indexPath] indexAtPosition:0]])
		{
			outsetRect = CGRectMake(1.5, -5.5, zRect.size.width-2, zRect.size.height+5);
		}
		else {
			outsetRect = CGRectMake(1.5, -10.5, zRect.size.width-2, zRect.size.height+20);
		}
		
		CGContextSetFillColorWithColor(context, WHT(1));
		
		CGContextAddRoundedRect(context, outsetRect, 5);
		CGContextFillPath(context);
		
		CGContextSetStrokeColorWithColor(context, WHT(0.5));
		
		CGContextAddRoundedRect(context, outsetRect, 5);
		CGContextStrokePath(context);
	}
}

- (float) cellHorizontalOffset
{
	if (_style == kMXTableViewStylePlain) {
		return 0;
	}
	else {
		return 10;
	}

}

- (void) _clearCells
{
	/* release and remove all cells */
	[_specialCells makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
	for (NSArray* cells in _sections) {
		[cells makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
	}
	
	[_sections removeAllObjects];
	[_specialCells removeAllObjects];	
}

- (void) _layoutCells
{
	int yOffset = 0;
	
	int section = 0;
	for (NSArray* cells in _sections)
	{
		MXTableSectionHeader* header = [[MXTableSectionHeader alloc] init];
		[header setText:[self _titleForHeaderInSection:section]];
		[header setFrame:CGRectMake([self cellHorizontalOffset],
									yOffset,
									self.frame.size.width-([self cellHorizontalOffset]*2),
									[self _headerCellHeight]+1)];
		[self addSublayer:header];
		[_specialCells addObject:header];
		if (_style == kMXTableViewStylePlain)
			[header setVerticalAlign:kMXTextVerticalAlignTop];
		[self setNeedsDisplay];
		
		
		yOffset += [self _headerCellHeight];
		
		int row = 0;
		for (MXTableViewCell* cell in cells)
		{
			if ([cell superlayer] == nil)
			{
				[cell setFrame:CGRectMake([self cellHorizontalOffset],
										  yOffset,
										  self.frame.size.width-([self cellHorizontalOffset]*2),
										  [self _cellHeight]+1)];
				[self addSublayer:cell];
				[cell setNeedsDisplay];
				
				yOffset += [self _cellHeight];
			}
			else 
			{
				MXSLog(@" *** Cell %@ has a superlayer %@!",cell,[cell superlayer]);
			}
			row++;
		}
		
		section++;
	}

	[self setContentSize:CGSizeMake(self.frame.size.width, yOffset)];
}

- (void) drawInContext:(CGContextRef)context
{
	if (_style == kMXTableViewStylePlain) {
		CGContextSetFillColorWithColor(context, WHT(1));
		CGContextFillRect(context, CGRectBaseOrigin(self.frame));
	}
	else {
		/* Shading */
		CGContextSetFillColorWithColor(context, WHT(0.7));
		CGContextFillRect(context, CGRectBaseOrigin(self.frame));
		
		CGContextSetStrokeColorWithColor(context, WHT(0.65));
		CGContextSetLineWidth(context, 3);
		for (int i = 0;i < self.frame.size.width;i+=9)
		{
			CGContextMoveToPoint(context, i+0.5, 0);
			CGContextAddLineToPoint(context, i+0.5, self.frame.size.height);
			CGContextStrokePath(context);
		}
	}
}

- (void) _reloadAllData
{
	for (int i = 0; i < [self _numberOfSections]; i++)
	{
		[self _loadCellsInSection:i];
	}
}

- (void) reloadData
{
	[self _clearCells];
	[self _reloadAllData];
	[self _layoutCells];
}

@end
