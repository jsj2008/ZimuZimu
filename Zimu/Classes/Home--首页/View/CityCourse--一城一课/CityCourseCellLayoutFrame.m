//
//  CityCourseCellLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/4/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CityCourseCellLayoutFrame.h"
#import "WXLabel.h"

@implementation CityCourseCellLayoutFrame

- (instancetype)init{
    self = [super init];
    if (self) {
        [self layoutFrame];
    }
    return self;
}

- (void)layoutFrame{
    //活动图片
    _courseImageViewFrame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * 0.4);
    
    //蒙版
    _maskViewFrame = CGRectMake(0, CGRectGetMaxY(_courseImageViewFrame) - 25, CGRectGetWidth(_courseImageViewFrame), 25);
    
    //简介
    _titleLabelFrame = CGRectMake(10, 0, CGRectGetWidth(_maskViewFrame) - 20, CGRectGetHeight(_maskViewFrame));
    
    //时间
    NSString *timeString = @"时间";
    CGSize timeSize = [timeString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _timeLabelFrame = CGRectMake(10, CGRectGetMaxY(_courseImageViewFrame) + 10, kScreenWidth - 20, timeSize.height);
    
    //地点
    NSString *addressString = @"活动地点：杭州市下城区庆春路118号嘉德广场23楼D座";
    CGFloat addressHeight = [WXLabel getTextHeight:14 width:kScreenWidth - 20 text:addressString linespace:2];
    _detailAddressLabelFrame = CGRectMake(10, CGRectGetMaxY(_timeLabelFrame) + 10, kScreenWidth - 20, addressHeight);
    
    _cellHeight = CGRectGetMaxY(_detailAddressLabelFrame) + 10;

//    //标签地址
//    NSString *tagAddress = @"杭州";
//    CGSize tagAddressSize = [tagAddress sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
//    _addressLabelFrame = CGRectMake(kScreenWidth - 10 - tagAddressSize.width, 0, tagAddressSize.width, tagAddressSize.height);
//    
//    //标签
//    CGFloat tagWidth = tagAddressSize.width + 30;
//    _tagIamgeViewFrame = CGRectMake(kScreenWidth - tagWidth, 10, tagWidth, 40);
    
}

@end
