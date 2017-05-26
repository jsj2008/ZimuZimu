//
//  GetArticleCommentListApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetArticleCommentListApi.h"

@implementation GetArticleCommentListApi{
    NSString *_articleId;
}

- (instancetype)initWithArticleId:(NSString *)articleId{
    self = [super init];
    if (self) {
        _articleId = articleId;
    }
    return self;
}

- (NSString *)requestUrl{
    return GetArticleCommentListURL;
}

- (id)requestArgument{
    return @{@"articleId":_articleId};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}


@end
