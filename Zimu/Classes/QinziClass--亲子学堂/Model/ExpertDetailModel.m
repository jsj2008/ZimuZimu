//
//  ExpertDetailModel.m
//  Zimu
//
//  Created by Redpower on 2017/5/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExpertDetailModel.h"

@implementation ExpertDetailModel

@end
@implementation ExpertInfo
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
