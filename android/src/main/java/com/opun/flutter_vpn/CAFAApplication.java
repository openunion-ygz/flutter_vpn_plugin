package com.opun.flutter_vpn;

import android.content.Context;
import android.widget.Toast;


import io.flutter.app.FlutterApplication;
import com.sangfor.sdk.SFMobileSecuritySDK;
import com.sangfor.sdk.base.SFSDKFlags;
import com.sangfor.sdk.base.SFSDKMode;

public class CAFAApplication extends FlutterApplication{
    private static final String TAG = "CAFAApplication";
    private static SFSDKMode mSDKMode;

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);

        //只使用VPN功能场景
        SFSDKMode sdkMode = SFSDKMode.MODE_VPN;                 //表明启用VPN安全接入功能,详情参考集成指导文档
//        //只使用安全沙箱功能场景
//        SFSDKMode sdkMode = SFSDKMode.MODE_SANDBOX;             //表明启用安全沙箱功能,详情参考集成指导文档
//        //同时使用VPN功能+安全沙箱功能场景
//        SFSDKMode sdkMode = SFSDKMode.MODE_VPN_SANDBOX;         //表明同时启用VPN功能+安全沙箱功能,详情参考集成指导文档

        switch (sdkMode) {
            case MODE_VPN: {//只使用VPN功能场景
                int sdkFlags =  SFSDKFlags.FLAGS_HOST_APPLICATION;      //表明是单应用或者是主应用
                sdkFlags |= SFSDKFlags.FLAGS_VPN_MODE_TCP;              //表明使用VPN功能中的TCP模式

                SFMobileSecuritySDK.getInstance().initSDK(base, sdkMode, sdkFlags, null);//初始化SDK
                break;
            }
            case MODE_SANDBOX: {//只使用安全沙箱功能场景
                int sdkFlags =  SFSDKFlags.FLAGS_HOST_APPLICATION;      //表明是单应用或者是主应用
                sdkFlags |= SFSDKFlags.FLAGS_ENABLE_FILE_ISOLATION;     //表明启用安全沙箱功能中的文件隔离功能

                SFMobileSecuritySDK.getInstance().initSDK(base, sdkMode, sdkFlags, null);//初始化SDK
                break;
            }
            case MODE_VPN_SANDBOX: { //同时使用VPN功能+安全沙箱功能场景
                int sdkFlags =  SFSDKFlags.FLAGS_HOST_APPLICATION;      //表明是单应用或者是主应用
                sdkFlags |= SFSDKFlags.FLAGS_VPN_MODE_TCP;              //表明使用VPN功能中的TCP模式
                sdkFlags |= SFSDKFlags.FLAGS_ENABLE_FILE_ISOLATION;     //表明启用安全沙箱功能中的文件隔离功能

                SFMobileSecuritySDK.getInstance().initSDK(base, sdkMode, sdkFlags, null);//初始化SDK
                break;
            }
            default: {
                Toast.makeText(base, "SDK模式错误", Toast.LENGTH_LONG).show();
            }
        }

        mSDKMode = sdkMode; //保存使用的sdk模式
    }

    /**
     * @brief 是否使用VPN功能模式
     */
    public boolean isUseVpnMode() {
        if (mSDKMode == SFSDKMode.MODE_SANDBOX) {
            return false;
        }

        return true;
    }

    /**
     * @brief 是否使用安全沙箱功能模式
     */
    public boolean isUseSandboxMode() {
        if (mSDKMode == SFSDKMode.MODE_VPN) {
            return false;
        }

        return true;
    }
}
