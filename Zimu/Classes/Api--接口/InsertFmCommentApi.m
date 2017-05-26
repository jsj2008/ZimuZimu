//
//  InsertFmCommentApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "InsertFmCommentApi.h"

@implementation InsertFmCommentApi{
    NSString *_fmId;
    NSString *_commentVal;
}

- (instancetype)initWithFmId:(NSString *)fmId commentVal:(NSString *)commentVal{
    self = [super init];
    if (self) {
        _fmId = fmId;
        _commentVal = commentVal;
    }
    return self;
}

- (NSString *)requestUrl{
    return InsertFmCommentURL;
}

- (id)requestArgument{
    return @{@"fmId":_fmId,@"userToken":userToken,@"commentVal":_commentVal};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
