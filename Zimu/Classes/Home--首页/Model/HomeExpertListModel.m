//
//  HomeExpertListModel.m
//  Zimu
//
//  Created by Redpower on 2017/3/29.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeExpertListModel.h"

@implementation HomeExpertListModel

@end
@implementation LatestSubscription
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

@implementation ExpertPrice
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

@implementation Expert
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

@implementation HomeExpertItems

@end
