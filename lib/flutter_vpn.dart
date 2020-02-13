import 'dart:async';

import 'package:flutter/services.dart';

import 'constants.dart';

class FlutterVpn {
  static const MethodChannel _channel =
      const MethodChannel('${Constants.NAMESPACE}/methods');
  final StreamController<MethodCall> _methodStreamController =
      new StreamController.broadcast(); // ignore: close_sinks
  Stream<MethodCall> get _methodStream => _methodStreamController.stream; // U

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  FlutterVpn._() {
    _channel.setMethodCallHandler((MethodCall call) {
      _methodStreamController.add(call);
    });
  }

  static FlutterVpn _instance = new FlutterVpn._();

  static FlutterVpn get instance => _instance;

  ///SDK初始化
  Future<bool> initSDK() async {
    return await _channel
        .invokeMethod('initSDK')
        .then<bool>((isInit) => isInit);
  }

  ///vpn验证
  Future<bool> startPrimaryAuth(
      String vpnPathStr, String servicePathStr, String tokenStr) async {
    Map<String, dynamic> authMap = new Map();
    authMap[Constants.VPN_PATH_PARAM_KEY] = vpnPathStr;
    authMap[Constants.SERVICE_PATH_PARAM_KEY] = servicePathStr;
    authMap[Constants.TOKEN_PARAM_KEY] = tokenStr;
    return await _channel
        .invokeMethod('startPrimaryAuth', authMap)
        .then<bool>((isAuth) => isAuth);
  }

  ///vpn注销
  Future<bool> vpnLogout() async {
    return await _channel
        .invokeMethod('vpnLogout')
        .then((isLogout) => isLogout);
  }
}
