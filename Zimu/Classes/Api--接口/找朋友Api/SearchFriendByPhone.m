//
//  SearchFriendByPhone.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SearchFriendByPhone.h"

@implementation SearchFriendByPhone{
    NSString *_phone;
}


- (instancetype)initWithPhone:(NSString *)phone{
    self = [super init];
    if (self) {
        _phone = phone;
    }
    return self;
}

- (NSString *)requestUrl{
    return SearchFriendByPhoneURL;
}

- (id)requestArgument{
    NSLog(@"%@", userToken);
    return @{@"userToken":userToken,
             @"userPhone":_phone};
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}
@end
