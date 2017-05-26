//
//  GetPsyTestApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetPsyTestApi.h"

@implementation GetPsyTestApi
- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (NSString *)requestUrl{
    return GetHeartTestList;
}


- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}


@end
