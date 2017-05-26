//
//  MyPsyTestListApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MyPsyTestListApi.h"

@implementation MyPsyTestListApi
- (NSString *)requestUrl{
    return GetMyHeartTestList;
}
- (id)requestArgument{
    return  @{@"userToken":userToken};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
@end
