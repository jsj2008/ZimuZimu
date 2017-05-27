//
//  PushNotiToUsersApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "PushNotiToUsersApi.h"

@implementation PushNotiToUsersApi{
    NSString *_type;
    NSString *_users;
    NSString *_roomName;
    NSString *_num;
}
- (instancetype)initWithType:(NSString *)type users:(NSString *)users roomName:(NSString *)roomName num:(NSString *)num{
    self = [super init];
    if (self) {
        _type = type;
        _users = users;
        _num = num;
        _roomName = roomName;
    }
    return self;
}
- (NSString *)requestUrl{
    return PushNotiToUsersURL;
}

- (id)requestArgument{
    return @{@"userToken":userToken,
             @"users":_users,
             @"num":_num,
             @"type":_type,     //1是加好友   2是发送聊天
             @"roomName":_roomName
             };
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
