//
//  GetMyFriendListApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetMyFriendListApi.h"

@implementation GetMyFriendListApi{
    NSString *_userName;
}
- (instancetype)initWithUserName:(NSString *)userName{
    self = [super init];
    if (self) {
        _userName = userName;
    }
    return self;
}
- (NSString *)requestUrl{
    return SearchMyFriendListURL;
}

- (id)requestArgument{
    return @{@"userToken":userToken,
             @"userName":_userName
             };
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
