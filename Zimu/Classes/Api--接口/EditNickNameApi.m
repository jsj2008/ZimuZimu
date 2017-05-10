//
//  EditNickNameApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/4.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EditNickNameApi.h"

@implementation EditNickNameApi{
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
    return EditMyInfoURL;
}

- (id)requestArgument{
    return @{@"userName":_userName,@"userToken":userToken};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}


@end
