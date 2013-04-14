/*
 MXTableView:Header
 
 My terrible implementation of UITableView.
 Works in a similar fashion to it (but doesn't support editing).
 */

#import <Foundation/Foundation.h>
#import "MXTableViewCell.h"
#import "MXScrollLayer.h"
#import "MXTableSectionHeader.h"

typedef enum {
	kMXTableViewStylePlain = 0,
	kMXTableViewStyleSegmented
} MXTableViewStyle;

@interface MXTableView : MXScrollLayer {
	id _dataSource;
	NSMutableArray* _sections;
	NSMutableArray* _specialCells;
	
	MXTableViewStyle _style;
}

@property (retain) id dataSource;

- (id) initWithFrame:(CGRect)rect style:(MXTableViewStyle)style;

- (void) reloadData;

- (void) drawCell:(MXTableViewCell*)cell inContext:(CGContextRef)context;
- (void) drawSectionHeader:(MXTableSectionHeader*)cell inContext:(CGContextRef)context;

@end

@interface NSObject (MXTableViewDataSource)

- (NSString *)tableView:(MXTableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (MXTableViewCell *)tableView:(MXTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSectionsInTableView:(MXTableView *)tableView;
- (NSInteger)tableView:(MXTableView *)tableView numberOfRowsInSection:(NSInteger)section;

@end
