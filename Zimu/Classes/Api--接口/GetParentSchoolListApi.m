//
//  GetParentSchoolListModel.m
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetParentSchoolListApi.h"

@implementation GetParentSchoolListApi{
    NSString *_endTime;
}

- (instancetype)initWithEndTime:(NSString *)endTime{
    self = [super init];
    if (self) {
        _endTime = endTime;
    }
    return self;
}

- (NSString *)requestUrl{
    return GetParentSchoolListURL;
}

- (id)requestArgument{
    return @{@"endTime":_endTime};
}

@end
