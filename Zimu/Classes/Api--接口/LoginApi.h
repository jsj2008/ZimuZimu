//
//  LoginApi.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/10.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface LoginApi : YTKRequest
- (instancetype)initWithPhoneNo:(NSString *)phoneNo checkCode:(NSString *)checkCode;
@end
