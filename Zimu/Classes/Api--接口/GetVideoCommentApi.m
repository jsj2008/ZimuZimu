//
//  GetVideoCommentApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetVideoCommentApi.h"

@implementation GetVideoCommentApi{
    NSString *_videoId;
}

- (instancetype)initWithVideoId:(NSString *)videoId{
    self = [super init];
    if (self) {
        _videoId = videoId;
    }
    return self;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (NSString *)requestUrl{
    return GetVideoCommentListURL;
}

- (id)requestArgument{
    return @{@"videoId":_videoId};
}

@end
