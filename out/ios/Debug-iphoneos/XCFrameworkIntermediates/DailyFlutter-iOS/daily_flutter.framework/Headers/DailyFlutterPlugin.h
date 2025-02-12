// © 2022 Daily, Co. All Rights Reserved

#import <Flutter/Flutter.h>

@interface DailyFlutterPlugin : NSObject<FlutterPlugin, FlutterStreamHandler>
- (void)onAvailableDevicesUpdated;
@end
