//
//  AcceptFriendApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AcceptFriendApi.h"

@implementation AcceptFriendApi{
    NSString *_fromUser;
}
- (instancetype)initWithFromUser:(NSString *)fromUser{
    self = [super init];
    if (self) {
        _fromUser = fromUser;
    }
    return self;
}
- (NSString *)requestUrl{
    return AcceptFriendURL;
}

- (id)requestArgument{
    NSLog(@"%@", userToken);
    return @{@"userToken":userToken,
             @"fromUser":_fromUser};
}
//- (YTKRequestMethod)requestMethod{
//    return YTKRequestMethodPOST;
//}
@end
