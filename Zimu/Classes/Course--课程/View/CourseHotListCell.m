//
//  CourseHotListCell.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CourseHotListCell.h"

@implementation CourseHotListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setListenCount:(NSInteger)listenCount{
    _listenCount = listenCount;
    [_listenCounBtn setTitle:[NSString stringWithFormat:@"  %zd", listenCount] forState:UIControlStateNormal];
}

@end
