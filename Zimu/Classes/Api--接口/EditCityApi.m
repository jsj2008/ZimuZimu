//
//  EditCityApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EditCityApi.h"

@implementation EditCityApi{
    NSString *_provinceId;
}

- (instancetype)initWithProvinceID:(NSString *)provinceId{
    self = [super init];
    if (self) {
        _provinceId = provinceId;
    }
    return self;
}

- (NSString *)requestUrl{
    return GetCityURL;
}

- (id)requestArgument{
    return @{@"prevId":_provinceId};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
