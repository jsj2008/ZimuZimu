//
//  EditSignatrueApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/4.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EditSignatrueApi.h"

@implementation EditSignatrueApi

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl{
    return EditMyInfoURL;
}

- (id)requestArgument{
    return @{@"":@"",@"userToken":@""};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}


@end
