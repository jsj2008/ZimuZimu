//
//  CominRoomApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CominRoomApi.h"

@implementation CominRoomApi{
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
    return ComeinRoomURL;
}

- (id)requestArgument{
    return @{@"userToken":userToken,
             @"roomId":_roomId,    //这个roomID就是roomName
             @"userToken":userToken};
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
@end
