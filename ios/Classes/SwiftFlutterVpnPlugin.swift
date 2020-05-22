import Flutter
import UIKit

public class SwiftFlutterVpnPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_vpn", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterVpnPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    /**
         一般场景SDK的模式为SFSDKModeSupporVpnSandbox，即同时支持VPN和沙箱功能。
         需要设置主应用flags，如果需要外部设置沙箱策略需要设置SFSDKFlagsSupportManagePolicy。
         多应用场景，即一个主应用，多个子应用，所有应用需要开启AppGroup功能且保证groupid一致，同时设置groupid包括sfshare后缀，例如group.com.***.sfshare
         */
        [[SFMobileSecuritySDK sharedInstance] initSDK:SFSDKModeSupportVpn
                                                flags:SFSDKFlagsHostApplication|SFSDKFlagsSupportManagePolicy
                                                extra:nil];

        [[SFMobileSecuritySDK sharedInstance] setAuthResultDelegate:self];

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
         NSString * vpn_server_url = call.arguments[@"vpn_path_key"];
         NSString * token_str = call.arguments[@"token_key"];
         [[SFMobileSecuritySDK sharedInstance] startPasswordAuth:vpn_server_url userName:token_str password:@""];
        }

        private func vpnLogout(call: FlutterMethodCall, result: @escaping FlutterResult){
        [[SFMobileSecuritySDK sharedInstance] cancelAuth];
        }

        /**
         认证成功
         */
        - (void)onAuthSuccess:(BaseMessage *)msg
        {
             NSLog(@"AuthViewController onLoginSuccess");
            _loginBtn.hidden = FALSE;
            _cancelLoginBtn.hidden = YES;

            [MBProgressHUD hideHUDForView:self.loginView animated:YES];

            [self showAlertView:@"" message:@"认证成功"];
            [self showTestList];
        }

        #pragma mark - SFAuthResultDelegate
        /**
         认证失败

         @param msg 错误信息
         */
        - (void)onAuthFailed:(BaseMessage *)msg
        {
            NSLog(@"AuthViewController onLoginFailed:%@", msg);
            _loginBtn.hidden = FALSE;
            _cancelLoginBtn.hidden = YES;

            [MBProgressHUD hideHUDForView:self.loginView animated:YES];

            if(msg.errCode == SF_ERROR_CONNECT_VPN_FAILED && _authType == SFAuthTypeTicket) {
                [self showTicketAlertView:@"认证失败" message:msg.errStr];

            } else {
                [self showAlertView:@"认证失败" message:[NSString stringWithFormat:@"%@,code=%ld",msg.errStr,(long)msg.errCode]];
            }
        }
}
