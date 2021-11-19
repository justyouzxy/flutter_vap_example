#import "FlutterVapTestPlugin.h"
#import "VapFactory.h"

@implementation FlutterVapTestPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
//  FlutterMethodChannel* channel = [FlutterMethodChannel
//      methodChannelWithName:@"flutter_vap_test"
//            binaryMessenger:[registrar messenger]];
//  FlutterVapTestPlugin* instance = [[FlutterVapTestPlugin alloc] init];
//  [registrar addMethodCallDelegate:instance channel:channel];
    
    VapFactory *factory = [[VapFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:factory withId:@"flutter_vap_view"];
    
}

//- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
//  if ([@"getPlatformVersion" isEqualToString:call.method]) {
//    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
//  } else {
//    result(FlutterMethodNotImplemented);
//  }
//}

@end
