import 'dart:async';

import 'package:flutter/services.dart';

class FlutterVapTest {
  static const MethodChannel _channel = const MethodChannel('flutter_vap_test');

  static Future<Map<dynamic, dynamic>?> playPath(String path) async {
    return _channel.invokeMethod('playPath', {"path": path});
  }

  static Future<Map<dynamic, dynamic>?> playAsset(String asset) {
    return _channel.invokeMethod('playAsset', {"asset": asset});
  }

  static stop() {
    _channel.invokeMethod('stop');
  }

  static const EventChannel _eventChannel = const EventChannel('flutter_vap_event_channel');

  static void onListenStreamData(onEvent, onError) {
    _eventChannel.receiveBroadcastStream().listen(onEvent, onError: onError);
  }
}
