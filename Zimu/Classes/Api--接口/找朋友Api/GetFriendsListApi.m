//
//  GetFriendsListApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetFriendsListApi.h"

@implementation GetFriendsListApi

- (NSString *)requestUrl{
    return GetFriendsListURL;
}

- (id)requestArgument{
    NSLog(@"%@", userToken);
    return @{@"userToken":userToken};
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}
@end
