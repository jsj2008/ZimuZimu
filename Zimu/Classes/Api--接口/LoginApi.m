//
//  LoginApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/10.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "LoginApi.h"

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
             @"phoneNo":_phoneNo,
             @"smsCaptcha":_checkCode
             };
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
