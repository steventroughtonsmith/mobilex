
#import "MXIconController.h"
#import "MXApplicationController.h"
#import "MXApplicationIcon.h"
#import "MXController.h"
#import "MXColors.h"
#import "MXSettingsController.h"
#import "MXFolderIcon.h"

@implementation MXIconController
@synthesize currentIconListIndex=_currentIconListIndex;

- (id)init {
    if ((self = [super init])) {
        _scrollLayer = [[MXIconScrollLayer alloc] initWithFrame:CGRectZero];
		[_scrollLayer setScrollHorizontally:TRUE];
		[_scrollLayer setIndicatorStyle:kMXScrollLayerIndicatorStyleWhite];
		[_scrollLayer setPagingEnabled:TRUE];
		
        _iconLists = [[NSMutableArray alloc] init];
        _currentIconListIndex = 0;
		
		if ([MXSettingsController boolForKey:@"MXUseIconStateFile"]) {
			[self loadFromIconState];
		}
		else {
			[self loadFromRepresentation:nil];
		}

    }

    return self;
}

- (NSDictionary*) iconState
{
	return [NSDictionary dictionaryWithContentsOfFile:@"/User/Library/SpringBoard/IconState.plist"];
}

- (MXIconScrollLayer *)iconLayer {
    return _scrollLayer;
}

- (MXIconListLayer *)currentIconList {
    return [_iconLists objectAtIndex:_currentIconListIndex];
}

- (void) loadFromIconState
{
	[_iconLists removeAllObjects];
	NSDictionary* iconState = [self iconState];
	NSDictionary* state = [iconState objectForKey:@"iconLists"];
	
	for (NSDictionary* icons in state)
	{
		MXIconListLayer *iconList = [[MXIconListLayer alloc] initWithFrame:CGRectZero];
		NSMutableArray *iconArray = [NSMutableArray array];
		
		for (id icon in icons)
		{
			if ([icon isKindOfClass:[NSString class]])
			{
				MXApplication* app = [[MXApplicationController sharedInstance] applicationForIdentifier:icon];
				
				if (app != nil && ![app isHidden])
				{
					[iconArray addObject:[[MXApplicationIcon alloc] initWithApplication:app]];
				}
			}
			else {
				NSArray* subicons = [[icon objectForKey:@"iconLists"] objectAtIndex:0];
				NSMutableArray* folderIcons = [NSMutableArray new];
	
				for (id subicon in subicons) {
					MXApplication* app = [[MXApplicationController sharedInstance] applicationForIdentifier:subicon];
					
					if (app != nil && ![app isHidden])
					{
						[folderIcons addObject:[[MXApplicationIcon alloc] initWithApplication:app]];
					}
				}
				
				MXFolderIcon* folder = [[MXFolderIcon alloc] init];
				[folder setIcons:folderIcons];
				[iconArray addObject:folder];
			}

		}
		
		[iconList setIcons:iconArray];
		[_iconLists addObject:iconList];
        [iconList release];
	}
}

- (void)loadFromRepresentation:(NSDictionary *)representation {
    // XXX: completely temporary, needs a rewrite

    [_iconLists removeAllObjects];

    NSDictionary *applicationDictionary = [[MXApplicationController sharedInstance] allApplications];
    NSArray *unfilteredApplications = [applicationDictionary allKeys];
    NSMutableArray *applications = [NSMutableArray array];
    for (NSString *app in unfilteredApplications) {
        MXApplication *application = [applicationDictionary objectForKey:app];
        if ([application isHidden]) continue;
        [applications addObject:app];
    }
    
    int iconsPerPage = [MXIconListLayer maxIconRows] * [MXIconListLayer maxIconColumns];
    int pages = [applications count] / iconsPerPage;
    if ([applications count] % iconsPerPage) pages += 1;

    for (int i = 0; i < pages; i++) {
        MXIconListLayer *iconList = [[MXIconListLayer alloc] initWithFrame:CGRectZero];
		
        NSRange range;
        range.location = i * iconsPerPage;
        range.length = iconsPerPage;
        if (range.location + range.length >= [applications count])
            range.length = [applications count] - range.location;
        NSArray *page = [applications subarrayWithRange:range];
		
        NSMutableArray *icons = [NSMutableArray array];
        for (NSString *identifier in page) {
	        MXApplication *application = [[[MXApplicationController sharedInstance] allApplications] objectForKey:identifier];
	        MXIcon *icon = [[MXApplicationIcon alloc] initWithApplication:application];
	        [icon addTarget:[MXController shared] action:@selector(launchApplicationForIdentfier:) withObject:identifier];
            [icons addObject:icon];
            [icon release];
        }
        [iconList setIcons:icons];
		
        [_iconLists addObject:iconList];
        [iconList release];
    }

    [self relayout];
}

- (void)relayout {
	[_scrollLayer setIconListCount:[_iconLists count]];
	
    CGFloat offset = 0.0f;
    for (MXIconListLayer *iconList in _iconLists) {
        CGRect frame;
        frame.origin.x = offset;
        frame.origin.y = 0.0f;
        frame.size.height = [_scrollLayer bounds].size.height;
        frame.size.width = [_scrollLayer bounds].size.width;
        [iconList setFrame:frame];
        [iconList relayout];
        [_scrollLayer addSublayer:iconList];
		
        offset += frame.size.width;
    }
}

@end



