//
//  SearchQuestionModel.m
//  Zimu
//
//  Created by Redpower on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SearchQuestionModel.h"

@implementation SearchQuestionModel

@end

@implementation SearchQuestionResultModel

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [self whc_Decode:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [self whc_Encode:encoder];
}

- (id)copyWithZone:(NSZone *)zone {
    return [self whc_Copy];
}

@end
