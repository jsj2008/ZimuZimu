//
//  EditAgeApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/4.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EditAgeApi.h"

@implementation EditAgeApi{
    NSString *_age;
}

- (instancetype)initWithAge:(NSString *)age{
    self = [super init];
    if (self) {
        _age = age;
    }
    return self;
}

- (NSString *)requestUrl{
    return EditMyInfoURL;
}

- (id)requestArgument{
    return @{@"age":_age,@"userToken":userToken};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
