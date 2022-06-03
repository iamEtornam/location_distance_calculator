#import "LocationDistanceCalculatorPlugin.h"
#if __has_include(<location_distance_calculator/location_distance_calculator-Swift.h>)
#import <location_distance_calculator/location_distance_calculator-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "location_distance_calculator-Swift.h"
#endif

@implementation LocationDistanceCalculatorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLocationDistanceCalculatorPlugin registerWithRegistrar:registrar];
}
@end
