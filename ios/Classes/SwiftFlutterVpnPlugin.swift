import Flutter
import UIKit

public class SwiftFlutterVpnPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_vpn", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterVpnPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }


     public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        if(call.method == "getPlatformVersion"){

         result("iOS " + UIDevice.current.systemVersion)
        }else if(call.method == "initSDK"){

        //sdk初始化
        initSDK(call:call,result:result)

        }else if(call.method == "startPrimaryAuth"){
        //vpn登录验证

        startPrimaryAuth(call:call,result:result)

        }  else if(call.method == "vpnLogout"){
       //vpn登出
         vpnLogout(call:call,result:result)

        }else{

           result("notImplemented")
        }

        }


        private func initSDK(call: FlutterMethodCall, result: @escaping FlutterResult){


        }


        private func  startPrimaryAuth(call: FlutterMethodCall, result: @escaping FlutterResult){


        }

        private func vpnLogout(call: FlutterMethodCall, result: @escaping FlutterResult){


        }
}
