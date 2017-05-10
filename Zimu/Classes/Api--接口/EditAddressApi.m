//
//  EditAddressApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/4.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EditAddressApi.h"

@implementation EditAddressApi{
    NSString *_provinceId;
    NSString *_cityId;
}

- (instancetype)initWithProvinceId:(NSString *)provinceId cityId:(NSString *)cityId{
    self = [super init];
    if (self) {
        _provinceId = provinceId;
        _cityId = cityId;
    }
    return self;
}

- (NSString *)requestUrl{
    return EditMyInfoURL;
}

- (id)requestArgument{
    return @{@"provinceId":_provinceId, @"cityId":_cityId, @"userToken":userToken};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}


@end
