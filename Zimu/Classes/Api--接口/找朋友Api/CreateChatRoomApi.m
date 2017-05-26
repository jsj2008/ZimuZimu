//
//  CreateChatRoomApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CreateChatRoomApi.h"

@implementation CreateChatRoomApi{
    NSString *_userId;
    NSInteger _num;
}
- (instancetype)initWithUserId:(NSString *)userId num:(NSInteger)num{
    self = [super init];
    if (self) {
        _userId = userId;
        _num = num;
    }
    return self;
}
- (NSString *)requestUrl{
    return CreateChatRoomURL;
}

- (id)requestArgument{
    return @{@"userToken":userToken,
             @"userId":_userId,
             @"num":[NSString stringWithFormat:@"%zd", _num]};
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
