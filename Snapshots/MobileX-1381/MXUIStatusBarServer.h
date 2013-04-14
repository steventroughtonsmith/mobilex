//
//  MXUIStatusBarServer.h
//  MobileX
//
//  Created by Nick on 22/05/1999.
//  Copyright 1999 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
	BOOL itemIsEnabled[22];
	BOOL timeString[64];
	int gsmSignalStrengthRaw;
	int gsmSignalStrengthBars;
	char serviceString[100];
	BOOL serviceImageBlack[100];
	BOOL serviceImageSilver[100];
	BOOL operatorDirectory[1024];
	unsigned serviceContentType;
	int wifiSignalStrengthRaw;
	int wifiSignalStrengthBars;
	unsigned dataNetworkType;
	int batteryCapacity;
	unsigned batteryState;
	BOOL notChargingString[150];
	int bluetoothBatteryCapacity;
	int thermalColor;
	unsigned thermalSunlightMode : 1;
	unsigned slowActivity : 1;
	BOOL activityDisplayId[256];
	unsigned bluetoothConnected : 1;
	unsigned displayRawGSMSignal : 1;
	unsigned displayRawWifiSignal : 1;
} UIStatusBarData;

void
MXUISBSStart();