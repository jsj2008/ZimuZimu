//
//  GetMyInfoAPI.m
//  Zimu
//
//  Created by Redpower on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetMyInfoAPI.h"

@implementation GetMyInfoAPI

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl{
    return GetMyInfoURL;
}

- (id)requestArgument{
    return @{@"userToken":userToken};
}

@end
