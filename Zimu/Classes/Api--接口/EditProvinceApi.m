//
//  EditProvinceApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EditProvinceApi.h"

@implementation EditProvinceApi

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl{
    return GetProvinceURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
