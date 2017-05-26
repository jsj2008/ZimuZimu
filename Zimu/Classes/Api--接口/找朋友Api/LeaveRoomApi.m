
//
//  LeaveRoomApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "LeaveRoomApi.h"

@implementation LeaveRoomApi
{
    NSString *_roomId;
}
- (instancetype)initWithRoomId:(NSString *)roomId{
    self = [super init];
    if (self) {
        _roomId = roomId;
    }
    return self;
}
- (NSString *)requestUrl{
    return LeaveChatRoomURL;
}

- (id)requestArgument{
    return @{@"userToken":userToken,
             @"roomId":_roomId,
             @"userToken":userToken};
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
@end
