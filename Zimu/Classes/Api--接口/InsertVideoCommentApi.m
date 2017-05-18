//
//  InsertVideoCommentApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "InsertVideoCommentApi.h"

@implementation InsertVideoCommentApi{
    NSString *_commentVal;
    NSString *_videoId;
}

- (instancetype)initWithCommentVal:(NSString *)commentVal videoId:(NSString *)videoId{
    self = [super init];
    if (self) {
        _commentVal = commentVal;
        _videoId = videoId;
    }
    return self;
}

- (id)requestArgument{
    return @{@"commentVal":_commentVal,
             @"videoId":_videoId,
             @"userToken":userToken};
}

- (NSString *)requestUrl{
    return InsertVideoCommentURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
