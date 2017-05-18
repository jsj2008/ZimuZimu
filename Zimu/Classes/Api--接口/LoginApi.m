//
//  LoginApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/10.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "LoginApi.h"
#import "DeviceMessageModel.h"

@implementation LoginApi{
    NSString *_phoneNo;
    NSString *_checkCode;
    
}

- (instancetype)initWithPhoneNo:(NSString *)phoneNo checkCode:(NSString *)checkCode{
    self = [super init];
    if (self) {
        _phoneNo = phoneNo;
        _checkCode = checkCode;
    }
    return self;
}

- (NSString *)requestUrl{
    return UserLogin;
}

- (id)requestArgument{
    return @{
             @"phoneNo"        :       _phoneNo,                                           //手机号
             @"smsCaptcha"     :       _checkCode,                                         //验证码
             @"deviceModel"    :       [DeviceMessageModel GetCurrentDeviceModel],         //设备型号
             @"deviceName"     :       [DeviceMessageModel GetName],                       //设备名称
             @"systemName"     :       [DeviceMessageModel GetSystemName],                 //系统名称
             @"systemVersion"  :       [DeviceMessageModel GetSystemVersion],              //系统版本
             @"publicIp"       :       [DeviceMessageModel GetHostIP],                     //公网ip
             @"deviceUuid"     :       [DeviceMessageModel GetUUID],                       //设备UUID
             @"appVersion"     :       [DeviceMessageModel GetAPPVersion]                  //APP版本
             };
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
