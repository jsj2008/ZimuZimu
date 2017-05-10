//
//  EditSexApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/4.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EditSexApi.h"

@implementation EditSexApi{
    NSInteger _userSex;
}

- (instancetype)initWithUserSex:(NSInteger)userSex{
    self = [super init];
    if (self) {
        _userSex = userSex;
    }
    return self;
}

- (NSString *)requestUrl{
    return EditMyInfoURL;
}

- (id)requestArgument{
    return @{@"userSex":[NSString stringWithFormat:@"%li",_userSex],@"userToken":userToken};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}


@end
