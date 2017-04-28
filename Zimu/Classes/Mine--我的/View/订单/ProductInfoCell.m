//
//  ProductInfoCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ProductInfoCell.h"

@interface ProductInfoCell ()

@property (weak, nonatomic) IBOutlet UIButton *orderTypeButton;
@property (weak, nonatomic) IBOutlet UIView *contentBGView;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;


@end



@implementation ProductInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    NSString *titleString = @"合计：￥300.00";
    NSMutableAttributedString *titleAttributedString = [[NSMutableAttributedString alloc]initWithString:titleString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"333333"]}];
    [titleAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, 4)];
    _totalPriceLabel.attributedText = titleAttributedString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end


