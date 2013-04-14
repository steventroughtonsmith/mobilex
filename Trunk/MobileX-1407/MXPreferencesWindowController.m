//
//  MXPreferencesWindowController.m
//  MobileX
//
//  Created by Nick on 14/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXPreferencesWindowController.h"

static id _shinst = NULL;

@implementation MXPreferencesWindowController

+ (id) shared
{
	if (_shinst==NULL)
	{
		_shinst = [MXPreferencesWindowController alloc];
		[_shinst init];
	}
	
	return _shinst;
}

- (id) init
{
	[super init];
	
	_tableView = [[MXTableView alloc] initWithFrame:CGRectMake(0, 0, 500, 600)
											  style:kMXTableViewStyleSegmented];
	
	NSString* path = [[[NSBundle mainBundle] bundlePath]
					  stringByAppendingPathComponent:@"Preferences.plist"];
	
	_specifiers = [NSArray arrayWithContentsOfFile:path];
	[_specifiers retain];
	
	_window = [MXWindow windowForLayer:_tableView];
	[_window setText:@"Preferences"];
	[_window hide];
	
	[_tableView setDataSource:self];
	[_tableView reloadData];
	
	return self;
}

- (void) show
{
	[_window show];
}

- (NSInteger)numberOfSectionsInTableView:(MXTableView *)tableView
{
	return [_specifiers count];
}

- (NSString*)tableView:(MXTableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [[_specifiers objectAtIndex:section] objectForKey:@"Title"];
}

- (NSInteger)tableView:(MXTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[[_specifiers objectAtIndex:section] objectForKey:@"Specifiers"] count];
}

- (MXTableViewCell *)tableView:(MXTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	MXTableViewCell* cell = [[MXTableViewCell alloc] init];
	int row = [indexPath indexAtPosition:1];
	
	NSDictionary* specifier = [[[_specifiers objectAtIndex:[indexPath indexAtPosition:0]] objectForKey:@"Specifiers"] objectAtIndex:row];
	[[cell label] setText:[specifier objectForKey:@"Title"]];
	
	return cell;
}

@end
