//
//  NativeVapView.h
//  flutter_vap_test
//
//  Created by zxy on 2021/11/3.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "QGVAPWrapView.h"
#import "UIView+VAP.h"
#import "VapFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface NativeVapView : NSObject<FlutterPlatformView,VAPWrapViewDelegate,FlutterStreamHandler,FlutterPlugin>


- (instancetype)initWithFrame: (CGRect) frame
               viewIdentifier: (int64_t) viewId
                    arguments: (id _Nullable) args
                    mRegistrar: (NSObject<FlutterPluginRegistrar> *) registrar;

- (UIView*) view;

@end

NS_ASSUME_NONNULL_END
