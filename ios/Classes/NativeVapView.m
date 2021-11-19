//
//  NativeVapView.m
//  flutter_vap_test
//
//  Created by zxy on 2021/11/3.
//

#import "NativeVapView.h"

@implementation NativeVapView
{
    UIView *_view;
    NSObject<FlutterPluginRegistrar> * _registrar;
    QGVAPWrapView *_wrapView;
    FlutterResult _result;
    FlutterEventSink _event;
    //播放中就是ture，其他状态false
    BOOL playStatus;
}

-(instancetype)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args mRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    if (self == [super init]) {
        playStatus = false;
        _view = [[UIView alloc] init];
        _registrar = registrar;
        FlutterMethodChannel* channel = [FlutterMethodChannel
            methodChannelWithName:@"flutter_vap_test"
                  binaryMessenger:registrar.messenger];
        
        [registrar addMethodCallDelegate: self channel:channel];
        
        FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:@"flutter_vap_event_channel" binaryMessenger:registrar.messenger];
        [eventChannel setStreamHandler:self];
    }
    return self;
}

#pragma mark -- native给flutter发送event消息
- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    _event = events;
    NSLog(@"这里是获取的arguments的值%@",arguments);
    if (events) {
        events(@"我是native的onListenWithArguments");
    }
    return  nil;
}

-(FlutterError *)onCancelWithArguments:(id)arguments {
    
    return  nil;
}

#pragma mark --flutter调native回调
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    _result = result;
    NSLog(@"这里是传进来的methord=%@---%@",call.method,call.arguments);
    if ([@"playPath" isEqualToString: call.method]) {
        [self playByPath:call.arguments[@"path"]];
    } else if ([@"playAsset" isEqualToString:call.method]) {
        //播放asset文件
        NSString* assetPath = [_registrar lookupKeyForAsset:call.arguments[@"asset"]];
        NSString* path = [[NSBundle mainBundle] pathForResource:assetPath ofType:nil];
        [self playByPath:path];
    } else if ([@"stop" isEqualToString:call.method]) {
        if (_wrapView) {
            [_wrapView removeFromSuperview];
        }
        playStatus = false;
    }
}

- (void)playByPath:(NSString *)path{
    //限制只能有一个视频在播放
    if (playStatus) {
        return;
    }
    _wrapView = [[QGVAPWrapView alloc] initWithFrame:self.view.bounds];
    _wrapView.center = self.view.center;
    _wrapView.contentMode = QGVAPWrapViewContentModeAspectFit;
    _wrapView.autoDestoryAfterFinish = YES;
    [self.view addSubview:_wrapView];
    [_wrapView vapWrapView_playHWDMP4:path repeatCount:0 delegate:self];
    
    
    
}


#pragma mark VAPWrapViewDelegate--播放回调
- (void) vapWrap_viewDidStartPlayMP4:(VAPView *)container{
    playStatus = true;
    _event(@"开始播放了");
}

- (void) vapWrap_viewDidFailPlayMP4:(NSError *)error{
    NSDictionary *resultDic = @{@"status":@"failure",@"errorMsg":error.description};
    _result(resultDic);
    _event(@"播放失败了");
}

- (void) vapWrap_viewDidStopPlayMP4:(NSInteger)lastFrameIndex view:(VAPView *)container{
    _event(@"停止播放了");
    playStatus = false;
}
    
-(void) vapWrap_viewDidFinishPlayMP4:(NSInteger)totalFrameCount view:(VAPView *)container {
    NSDictionary *resultDic = @{@"status":@"complete"};
    _result(resultDic);
    playStatus = false;
    _event(@"播放完成");
}


- (nonnull UIView *)view {
    return  _view;
}

@end


