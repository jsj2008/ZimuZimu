//
//  HomeRecommendTodayModel.m
//  Zimu
//
//  Created by Redpower on 2017/3/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeRecommendTodayModel.h"

@implementation HomeRecommendTodayModel

@end
@implementation Article
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

@implementation Fm
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

@implementation Video
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

@implementation Item
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

