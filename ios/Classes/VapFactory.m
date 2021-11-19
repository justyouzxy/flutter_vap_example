//
//  VapFactory.m
//  flutter_vap_test
//
//  Created by zxy on 2021/11/3.
//

#import "VapFactory.h"
#import "NativeVapView.h"

@implementation VapFactory
{
    NSObject<FlutterPluginRegistrar> * _registrar;
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    self = [super init];
    if (self) {
        _registrar = registrar;
    }
    return self;
}

- (NSObject<FlutterPlatformView> *)createWithFrame: (CGRect) frame
                                    viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    return [[NativeVapView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args mRegistrar:_registrar];
}
@end
