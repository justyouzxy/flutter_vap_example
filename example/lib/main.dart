import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vap_test/flutter_vap_test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      initPlatformState();
    });
  }

  Future<void> initPlatformState() async {
    FlutterVapTest.onListenStreamData((event) {
      log("eventChannel返回的正确信息=${event}");
    }, (error) {
      log("eventChannel返回的错误信息=${error}");
    });
  }

  final Map<String, dynamic> creationParams = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                TextButton(onPressed: () => _playPath("assets/demo.mp4"), child: Text("播放路径")),
                SizedBox(
                  height: 50,
                ),
                TextButton(onPressed: () => _playStop(), child: Text("结束")),
              ],
            ),
            IgnorePointer(
              child: UiKitView(
                viewType: "flutter_vap_view",
                layoutDirection: TextDirection.ltr,
                creationParams: creationParams,
                creationParamsCodec: StandardMessageCodec(),
              ),
            )
          ],
        ),
      ),
    );
  }

  _playPath(String path) async {
    var res = await FlutterVapTest.playAsset(path);
    log("flutter端===播放结果=${res}");
  }

  _playStop() async {
    FlutterVapTest.stop();
  }
}
