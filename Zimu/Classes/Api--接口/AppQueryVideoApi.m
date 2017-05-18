//
//  AppQueryVideoApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AppQueryVideoApi.h"

@implementation AppQueryVideoApi{
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
    return AppQueryVideoURL;
}

- (id)requestArgument{
    return @{@"videoId":_videoId};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}


@end
