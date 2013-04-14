//
//  MXDashboardController.m
//  MobileX
//
//  Created by Nick on 31/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MXSystemMenu.h"
#import "MXMainLayer.h"
#import "WifiManager.h"
#import "MXHostWindow.h"
#import "MXPaneManager.h"
#import "MXPaneManager+Expose.h"
#import "MXWindow.h"
#import "MXApplicationStateServices.h"

#define ItemSet sysMenu_itemSet
#define Item sysMenu_item
#define StaticItem sysMenu_static_item

static id _shinst = NULL;

/*******************************************/

/* -- ItemSet -- */
@interface ItemSet : NSObject {
	NSString* _title;
	NSMutableArray* _items;
}

@property (readonly, retain) NSMutableArray* items;
@property (retain) NSString* title;

@end

@implementation ItemSet
@synthesize items=_items, title=_title;
- (id) init{
	if (self = [super init]) {
		_items = [[NSMutableArray alloc] init];
		_title = @"Untitled";
	}
	return self;
}
@end

/* -- Item -- */
@interface Item : MXText {
	SEL _sel;
	id _context;
}
@property (assign) id context;

@end

static Item* gSelectedItem = NULL;

@implementation Item

@synthesize context=_context;

- (void) setSelector:(SEL) sel {
	_sel = sel;
}

- (void) performAction {
	if (_sel != NULL) 
		[_shinst performSelector:_sel];
}

- (id) initWithFrame:(CGRect)f {
	if (self = [super initWithFrame:f]) {
		[self setFont:[MXFont regularFontWithFamily:@"Helvetica" size:25]];
		[self setColor:RGB(1, 1, 1)];
		[self setBackgroundColor:RGBA(0, 0, 0, 0)];
	}
	return self;
}

- (boolean_t) selectable {
	return TRUE;
}

- (void) drawInContext:(CGContextRef)ctx {
	if ([self class] == [Item class]){
		CGRect dirtyRect = 
		CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
		
		if (gSelectedItem == self) {
			CGContextSetRGBFillColor(ctx, 0, 0, 1, 0.8);
		}
		else {
			CGContextSetRGBFillColor(ctx, 0, 0, 1, 0.1);
		}
		
		CGContextAddRect(ctx, dirtyRect);
		CGContextFillPath(ctx);
	}
	
	/* draw text on top */
	[super drawInContext:ctx];
}

@end

@interface StaticItem : Item {
}

@end

@implementation StaticItem

- (id) initWithFrame:(CGRect)f {
	if (self = [super initWithFrame:f]) {
		[self setFont:[MXFont boldFontWithFamily:@"Helvetica" size:25]];
	}
	return self;
}

- (void) drawInContext:(CGContextRef)ctx {
	CGRect dirtyRect = 
	CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
	
	CGContextSetRGBFillColor(ctx, 1, 1, 1, 0.1);
	
	CGContextAddRect(ctx, dirtyRect);
	CGContextFillPath(ctx);
	
	/* draw text on top */
	[super drawInContext:ctx];
}

- (boolean_t) selectable {
	return FALSE;
}

@end

/*******************************************/

@implementation MXSystemMenu

+ (id) shared
{
	if (_shinst==NULL)
	{
		_shinst = [[MXSystemMenu alloc] createSystemMenu];
	}
	
	return _shinst;
}

- (BOOL) isFixed {
	return TRUE;
}

- (BOOL) shouldAnimatePropertyForKey:(NSString*)key
{
	/* animate all properties for this menu */
	return TRUE;
}

- (uint32_t) selectableItemsCount {
	uint32_t ret = 0;
	for (Item* item in [_currentSet items]) {
		ret ++;
	}
	return ret;
}

- (void) selectItemAtIndex:(uint32_t)index {
	_index = index;
	uint32_t curSelectableItems = 0;
	uint32_t realIndex = 0;
	boolean_t gotOne = false;
	for (Item* item in [_currentSet items]) {
		if ([item selectable]) {
			if (_index == curSelectableItems) {
				gotOne = true;
				break;
			}
			curSelectableItems ++;
		}
		realIndex++;
	}
	
	if (!gotOne) return;
	
	Item* item = [[_currentSet items] objectAtIndex:realIndex];
	
	Item* oldSel = gSelectedItem;
	gSelectedItem = item;
	
	[oldSel setNeedsDisplay];
	[item setNeedsDisplay];
}

- (void) loadItemSet:(NSString*)name {
	ItemSet* set = [_itemSets objectForKey:name];
	[[_contents sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
	
	_currentItemSetName = name;
	_currentSet = set;
	_index = 0;
	
	Float32 y_offset = 0;
	for (Item* item in set.items) {
		[_contents addSublayer:item];
		
		[item setFrame:CGRectMake(0,
								  y_offset,
								  _contents.frame.size.width,
								  item.frame.size.height)];
		
		y_offset += item.frame.size.height;
	}
	
	if (set.items.count != 0) {
		[self selectItemAtIndex:0];
	}
}

- (void) hide {
	_currentItemSetName = @"___hidden";
	MXMainLayer* mainLayer = [MXMainLayer mainLayer];
	self.position = CGPointMake(mainLayer.frame.size.width, self.position.y);
}

- (void) show {
	_currentItemSetName = @"root";
	MXMainLayer* mainLayer = [MXMainLayer mainLayer];
	self.position = CGPointMake(mainLayer.frame.size.width/2, self.position.y);
}


- (void) sendKey:(uint32_t)page isDown:(boolean_t)down {
	
   
    
    if (!down) {
		if (page == kAtvBtnUp) {
			int32_t newIndex = _index - 1;
			if (newIndex >= 0) {
				[self selectItemAtIndex:newIndex];
			}
		}
		else if (page == kAtvBtnDown) {
			int32_t newIndex = _index + 1;
			if (newIndex < [self selectableItemsCount]) {
				[self selectItemAtIndex:newIndex];
			}
		}
		else if (page == kAtvBtnSelect) {
			if (![_currentItemSetName isEqualToString:@"___hidden"]){
				if (gSelectedItem != NULL) {
					[gSelectedItem performAction];
				}
			}
		}
		else if (page == kAtvBtnMenu) {
            
            
            if ([_currentItemSetName isEqualToString:@"root"]) {
                [self hide];
            }
            else if ([_currentItemSetName isEqualToString:@"___hidden"]) {

               [self show];
                
            }
            else {
                [self loadItemSet:@"root"];
            }
            
        }
		
	}
}

- (BOOL) isOpen {
	return ![_currentItemSetName isEqualToString:@"___hidden"];
}

- (void) handleDigitizerEventAt:(CGPoint)point ofType:(MTTouchType)type forLayer:(CALayer*)layer atGlobalPoint:(CGPoint)globalPoint
{
	if (type != kMXTEnd) 
		return;
	
	ItemSet* set = _currentSet;
	
	uint32_t index = 0;
	for (Item* item in set.items) {
		if ([item selectable]) {
			if (item == layer) {
				[self selectItemAtIndex:index];
				[gSelectedItem performAction];
				
				return;
			}
			index++;
		}
	}
}

- (void) goBack {
	
}

- (void) runSafari {
	MXLaunchApplicationWithIdentifier(@"com.apple.mobilesafari");
}

- (void) joinNetwork {
	[[WifiManager sharedInstance] joinNetwork:gSelectedItem.context password:nil];
}

- (void) _redoWifiItemSet {
	Item* item;
	ItemSet* set;
	
	/*** wifi itemset ***/
	set = 
	[[ItemSet alloc] init];
	
	item =
	[[StaticItem alloc] initWithFrame:CGRectMake(0, 0, 0, 80)];
	[item setText:@"WiFi Settings"];
	
	[set.items addObject:item];
	[item release];
	
	if (_wifiScanning) {
		item =
		[[StaticItem alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
		[item setFont:[MXFont regularFontWithFamily:@"Helvetica" size:20]];
		[item setText:@"Scanning ..."];
		
		[set.items addObject:item];
		[item release];
	}
	
	for (NSDictionary* net in [[WifiManager sharedInstance] networks]) {
		item =
		[[Item alloc] initWithFrame:CGRectMake(0, 0, 0, 80)];
		[item setText:[net objectForKey:@"SSID_STR"]];
		[item setContext:net];
		[item setSelector:@selector(joinNetwork)];
		
		[set.items addObject:item];
		[item release];
	}
	
	[_itemSets setObject:set forKey:@"wifi"];
	
	[set release];
}

- (void) popRecentWindow {
	for (MXPane* pane in [[[MXPaneManager shared] recentPanes] reverseObjectEnumerator])
	{
		if ([pane isKindOfClass:[MXWindow class]] && ![pane isMinimized]) {
			MXWindow* wnd = (MXWindow*)pane;
			if (![wnd isFixed]) {
				MSLog(@"closing %@", wnd);
				[wnd close];
				return;
			}
		}
	}
}

- (void) wifiSettings {
	if (!_wifiScanning) {
		_wifiScanning = TRUE;
		
		[self _redoWifiItemSet];
        
        [[WifiManager sharedInstance] setWifiEnabled:TRUE];
        [[WifiManager sharedInstance] scan];
	}
    
	[self loadItemSet:@"wifi"];
}

- (void) expose {
	[[MXPaneManager shared] toggleExpose];
}

- (void) _scanComplete {
	_wifiScanning = FALSE;
	
	[self _redoWifiItemSet];
	[self loadItemSet:@"wifi"];
}

- (void) _addItemSets {
	Item* item;
	ItemSet* set;
	
	/*** root itemset ***/
	set = 
	[[ItemSet alloc] init];
    
	item =
	[[StaticItem alloc] initWithFrame:CGRectMake(0, 0, 0, 80)];
	[item setText:@"Main Menu"];
	
	[set.items addObject:item];
	[item release];
	
	item =
	[[Item alloc] initWithFrame:CGRectMake(0, 0, 0, 80)];
	[item setSelector:@selector(wifiSettings)];
	[item setText:@"WiFi Settings"];
	
	[set.items addObject:item];
	[item release];
	
	item =
	[[Item alloc] initWithFrame:CGRectMake(0, 0, 0, 80)];
	[item setSelector:@selector(expose)];
	[item setText:@"Toggle Expose"];
	
	[set.items addObject:item];
	[item release];
    
	item =
	[[Item alloc] initWithFrame:CGRectMake(0, 0, 0, 80)];
	[item setText:@"Pop Window"];
	[item setSelector:@selector(popRecentWindow)];
	
	[set.items addObject:item];
	[item release];
	
	item =
	[[Item alloc] initWithFrame:CGRectMake(0, 0, 0, 80)];
	[item setText:@"Run Safari"];
	[item setSelector:@selector(runSafari)];
	
	[set.items addObject:item];
	[item release];
	
	item =
	[[Item alloc] initWithFrame:CGRectMake(0, 0, 0, 80)];
	[item setText:@"Reboot Device"];
	
	[set.items addObject:item];
	[item release];
	
	[_itemSets setObject:set forKey:@"root"];
	[set release];
	
	[self _redoWifiItemSet];
}

- (id) createSystemMenu {
	_wifiScanning = FALSE;
	
	MXMainLayer* mainLayer = [MXMainLayer mainLayer];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(_scanComplete)
												 name:@"WifiManagerScanComplete"
											   object:nil];
	
	/* contents layer */
	_contents = 
	[[MXLayer alloc] initWithFrame:CGRectMake(0,
											  0,
											  mainLayer.frame.size.width/2,
											  mainLayer.frame.size.height)];
	
	/* window */ 
	[self initWithLayer:_contents
			 atPosition:CGPointMake(mainLayer.frame.size.width, 0)];
	
	if (self) {
		[self setBorderStyle:kMXWindowStyleBorderless];
		
		/* since this is a fixed window, we need to manually set zpos */
		[self setZPosition:10000000];
		
		_itemSets = [[NSMutableDictionary alloc] initWithCapacity:10];
        
		[self _addItemSets];
		[self loadItemSet:@"root"];
		_currentItemSetName = @"___hidden";
		
		return self;
	}
	
	return nil;
}


@end
