//
//  GetWhetherFavoriteArticleApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetWhetherFavoriteArticleApi.h"

@implementation GetWhetherFavoriteArticleApi{
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
    return GetWhetherFavoriteArticleURL;
}

- (id)requestArgument{
    return @{@"articleId":_articleId,@"userToken":userToken};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

@end
