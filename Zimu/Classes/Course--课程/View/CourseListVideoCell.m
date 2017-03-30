//
//  CourseListVideoCell.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CourseListVideoCell.h"

@implementation CourseListVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTotalTime:(NSString *)totalTime{
    _totalTime = totalTime;
    [_totalTimeBtn setTitle:[NSString stringWithFormat:@"  %@", totalTime] forState:UIControlStateNormal];
}

- (void)setReadCount:(NSInteger)readCount{
    _readCount  = readCount;
    [_totalTimeBtn setTitle:[NSString stringWithFormat:@"  %zd", readCount] forState:UIControlStateNormal];
}
@end
