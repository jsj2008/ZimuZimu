//
//  GetMyFavouriteVideoListApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetMyFavouriteVideoListApi.h"

@implementation GetMyFavouriteVideoListApi{
    NSInteger _endTime;
}

- (instancetype)initWithEndTime:(NSInteger)endTime{
    self = [super init];
    if (self) {
        _endTime = endTime;
    }
    return self;
}

- (NSString *)requestUrl{
    return GetMyFavouriteVideoListURL;
}

- (id)requestArgument{
    return @{
             @"endTime"        :       [NSString stringWithFormat:@"%li",_endTime],
             @"userToken" : userToken

                          };
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
