//
//  InsertFmCollectionApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "InsertFmCollectionApi.h"

@implementation InsertFmCollectionApi{
    NSString *_fmId;
}

- (instancetype)initWithFMId:(NSString *)fmId{
    self = [super init];
    if (self) {
        _fmId = fmId;
    }
    return self;
}

- (id)requestArgument{
    return @{@"fmId":_fmId,@"userToken":userToken};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl{
    return InsertFmCollectionURL;
}

@end
