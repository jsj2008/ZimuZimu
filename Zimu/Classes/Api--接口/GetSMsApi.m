//
//  GetSMsApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/10.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetSMsApi.h"

@implementation GetSMsApi{
    NSString *_phoneNo;
}

- (instancetype)initWithPhoneNo:(NSString *)phoneNo{
    self = [super init];
    if (self) {
        _phoneNo = phoneNo;
    }
    return self;
}

- (NSString *)requestUrl{
    return GetSMS;
}

- (id)requestArgument{
    return @{@"phoneNo":_phoneNo};
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
@end
