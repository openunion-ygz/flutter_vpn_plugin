# flutter_vpn

version: vpn_plugin 0.0.1

A vpn Flutter plugin.

## Getting Started

## Android

一、概述

    该插件基于android原生集成深信服的vpn SDK、flutter通过插件的形式调用SDK方法。

二、api说明

    1.初始化

  ///SDK初始化
  Future<bool> initSDK() async {
    return await _channel
        .invokeMethod('initSDK')
        .then<bool>((isInit) => isInit);
  }


    2.vpn验证

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

    3.vpn注销

      ///vpn注销
      Future<bool> vpnLogout() async {
        return await _channel
            .invokeMethod('vpnLogout')
            .then((isLogout) => isLogout);
      }