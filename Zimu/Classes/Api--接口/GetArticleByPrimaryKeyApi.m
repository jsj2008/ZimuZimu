//
//  GetArticleByPrimaryKeyApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetArticleByPrimaryKeyApi.h"

@implementation GetArticleByPrimaryKeyApi{
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
    return GetArticleByPrimaryKeyURL;
}

- (id)requestArgument{
    return @{@"articleId":_articleId};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

@end
