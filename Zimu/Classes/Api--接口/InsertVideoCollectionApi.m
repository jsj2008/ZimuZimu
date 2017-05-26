//
//  InsertVideoCollectionApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "InsertVideoCollectionApi.h"

@implementation InsertVideoCollectionApi{
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
    return InsertVideoCollectionURL;
}

- (id)requestArgument{
    return @{@"videoId":_videoId,@"userToken":userToken};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
