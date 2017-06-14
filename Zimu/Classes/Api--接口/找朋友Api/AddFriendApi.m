//
//  AddFriendApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AddFriendApi.h"

@implementation AddFriendApi{
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
    return AddFriendURL;
}

- (id)requestArgument{
    NSLog(@"%@", userToken);
    return @{@"userToken":userToken,
             @"userId":_userId,
             @"type":@"1"};
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
@end
