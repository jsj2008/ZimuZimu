//
//  CreateTokenApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CreateTokenApi.h"

@implementation CreateTokenApi

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl{
    return CreateTokenURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (id)requestArgument{
    return @{@"userToken":userToken};
}

@end
