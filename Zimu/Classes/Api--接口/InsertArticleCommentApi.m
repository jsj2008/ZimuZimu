//
//  InsertArticleCommentApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "InsertArticleCommentApi.h"

@implementation InsertArticleCommentApi{
    NSString *_articleId;
    NSString *_commentVal;
}

- (instancetype)initWithArticleId:(NSString *)articleId commentVal:(NSString *)commentVal{
    self = [super init];
    if (self) {
        _articleId = articleId;
        _commentVal = commentVal;
    }
    return self;
}

- (NSString *)requestUrl{
    return InsertArticleCommentURL;
}

- (id)requestArgument{
    return @{@"articleId":_articleId,@"userToken":userToken,@"commentVal":_commentVal};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}


@end
