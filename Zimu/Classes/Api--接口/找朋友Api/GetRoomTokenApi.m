//
//  GetRoomTokenApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetRoomTokenApi.h"

@implementation GetRoomTokenApi{
    NSString *_userId;
    NSString *_role; //role = user
    NSString *_roomName;
}

- (instancetype)initWithUserId:(NSString *)userId role:(NSString *)role roomName:(NSString *)roomName{
    self = [super init];
    if (self) {
        _userId = userId;
        _role = role;
        _roomName = roomName;
    }
    return self;
}
- (NSString *)requestUrl{
    return GenerateToomTokenURL;
}

- (id)requestArgument{
    return @{@"userId":_userId,
             @"role":@"user",
             @"roomName":_roomName,
             @"userToken":userToken};
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
