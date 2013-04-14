//
//  MXQuartzWindowServer.m
//  MobileX
//
//  Created by Nick on 14/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import "MXQuartzWindowServer.h"

#import <QuartzCore/CAWindowServer.h>
#import <QuartzCore/CAWindowServerDisplay.h>

void MXQuartzSetCABlanked(BOOL blanked)
{
	for (CAWindowServerDisplay* disp in [[CAWindowServer serverIfRunning] displays])
	{
		if ([[disp name] isEqualToString:@"LCD"])
		{
			[disp setBlanked:blanked];
		}
	}
}