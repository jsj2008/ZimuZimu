//
//  CityCourseDetailInfoCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/13.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CityCourseDetailInfoCell.h"

@interface CityCourseDetailInfoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;
@property (weak, nonatomic) IBOutlet UILabel     *holdTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel     *overTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel     *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel     *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel     *oldPriceLabel;


@end

@implementation CityCourseDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    NSAttributedString *oldPrice = [[NSAttributedString alloc]initWithString:@"￥200.00" attributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
//    _oldPriceLabel.attributedText = oldPrice;
    _oldPriceLabel.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLayoutFrame:(CityCourseDetailInfoCellLayoutFrame *)layoutFrame{
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        
        //图片
        _courseImageView.frame = layoutFrame.courseImageViewFrame;
        
        //举办时间
        _holdTimeLabel.frame = layoutFrame.holdTimeLabelFrame;
        
        //截止报名时间
        _overTimeLabel.frame = layoutFrame.overTimeLabelFrame;
        
        //地址
        _addressLabel.frame = layoutFrame.addressLabelFrame;
        
        //售价
        _priceLabel.frame = layoutFrame.priceLabelFrame;
        
        //原价
        _oldPriceLabel.frame = layoutFrame.oldPriceLabelFrame;
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSStrikethroughColorAttributeName:[UIColor colorWithHexString:@"999999"]};
         NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"¥200.00" attributes:attribtDic];
        _oldPriceLabel.attributedText = attribtStr;
    }
}

@end
