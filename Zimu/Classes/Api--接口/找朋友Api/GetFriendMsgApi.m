//
//  GetFriendMsgApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetFriendMsgApi.h"

@implementation GetFriendMsgApi{
    NSString *_userId;
}

- (instancetype)initWithUserId:(NSString *)userId{
    self = [super init];
    if (self) {
        _userId = userId;
    }
    return self;
}
- (NSString *)requestUrl{
    return GetFriendMsgURL;
}

- (id)requestArgument{
    return @{@"userToken":userToken,
             @"friendId":_userId};
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
@end
