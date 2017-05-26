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
}
- (instancetype)initWithType:(NSString *)type users:(NSString *)users roomName:(NSString *)roomName{
    self = [super init];
    if (self) {
        _type = type;
        _users = users;
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
             @"roomName":_roomName,
             @"type":_type};
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
