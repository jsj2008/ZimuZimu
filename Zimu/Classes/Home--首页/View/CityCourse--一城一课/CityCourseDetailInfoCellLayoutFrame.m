//
//  CityCourseDetailInfoCellLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/4/13.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CityCourseDetailInfoCellLayoutFrame.h"
#import "WXLabel.h"

@implementation CityCourseDetailInfoCellLayoutFrame

- (instancetype)init{
    self = [super init];
    if (self) {
        [self layoutFrame];
    }
    return self;
}

- (void)layoutFrame{
    //图片
    _courseImageViewFrame = CGRectMake(10, 10, kScreenWidth - 20, (kScreenWidth - 20)*140/355.0);
    
    //举办时间
    NSString *holdTimeString = @"活动举办时间：2017/03/01";
    CGSize holdTimeSize = [holdTimeString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _holdTimeLabelFrame = CGRectMake(10, CGRectGetMaxY(_courseImageViewFrame) + 10, holdTimeSize.width, holdTimeSize.height);
    
    //截止报名时间
    NSString *overTimeString = @"截止报名时间：2017/02/28";
    CGSize overTimeSize = [overTimeString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _overTimeLabelFrame = CGRectMake(10, CGRectGetMaxY(_holdTimeLabelFrame) + 10, overTimeSize.width, overTimeSize.height);
    
    //售价
    NSString *priceString = @"￥100.00";
    CGSize priceSize = [priceString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    _priceLabelFrame = CGRectMake(kScreenWidth - 10 - priceSize.width, CGRectGetMaxY(_courseImageViewFrame) + 10, priceSize.width, priceSize.height);
    
    //原价
    NSString *oldPriceString = @"￥200.00";
    CGSize oldPriceSize = [oldPriceString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _oldPriceLabelFrame = CGRectMake(kScreenWidth - 10 - oldPriceSize.width - 1.5, CGRectGetMaxY(_priceLabelFrame) + 10, oldPriceSize.width + 3, oldPriceSize.height);
    
    //活动地点
    NSString *addressString = @"活动地点：杭州市庆春路嘉德广场23楼D座";
    CGFloat addressHeight = [WXLabel getTextHeight:13 width:kScreenWidth - 20 text:addressString linespace:2];
    _addressLabelFrame = CGRectMake(10, CGRectGetMaxY(_overTimeLabelFrame) + 10, kScreenWidth - 20, addressHeight);
    
    _cellHeight = CGRectGetMaxY(_addressLabelFrame) + 10;
    
}


@end
