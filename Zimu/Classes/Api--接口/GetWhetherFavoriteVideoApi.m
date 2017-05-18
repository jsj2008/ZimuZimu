//
//  GetWhetherFavoriteVideoApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetWhetherFavoriteVideoApi.h"

@implementation GetWhetherFavoriteVideoApi{
    NSString *_videoId;
}

- (instancetype)initWithVideoId:(NSString *)videoId{
    self = [super init];
    if (self) {
        _videoId = videoId;
    }
    return self;
}

- (NSString *)requestUrl{
    return GetWhetherFavoriteVideoURL;
}

- (YTKRequestMethod)requestMethod{
    return  YTKRequestMethodGET;
}

- (id)requestArgument{
    return @{@"videoId":_videoId,@"userToken":userToken};
}

@end
