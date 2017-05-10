//
//  EditHeadImageApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/4.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EditHeadImageApi.h"

@implementation EditHeadImageApi{
    NSString *_userImg;
}

- (instancetype)initWithUserImg:(NSString *)userImg{
    self = [super init];
    if (self) {
        _userImg = userImg;
    }
    return self;
}

- (NSString *)requestUrl{
    return EditMyInfoURL;
}

- (id)requestArgument{
    return @{@"userImg":_userImg,@"userToken":userToken};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}


@end
