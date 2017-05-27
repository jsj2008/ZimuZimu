//
//  GetMyVideoChatRequestApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetMyVideoChatRequestApi.h"

@implementation GetMyVideoChatRequestApi
- (NSString *)requestUrl{
    return GetVideoChatRequestURL;
}

- (id)requestArgument{
    return @{
             @"userToken":userToken
             };
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
@end
