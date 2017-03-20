//
//  TrySeeEndView.m
//  Zimu
//
//  Created by apple on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "TrySeeEndView.h"

@implementation TrySeeEndView


+ (TrySeeEndView *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    //正常实现是新创建对象，作为复制的副本对象
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        TrySeeEndView *tryView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
        self = tryView;
    }
    return self;
}



@end
