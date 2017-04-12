//
//  BookInfoCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BookInfoCell.h"

@interface BookInfoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIView *seperateLine;

@end

@implementation BookInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _seperateLine.backgroundColor = themeGray;
//    [UIColor colorWithHexString:@"666666"];
    NSString *text = @"价格:￥199";
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"666666"]}];
    [attributeText addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:themeYellow} range:NSMakeRange(3, text.length - 3)];
    _priceLabel.attributedText = attributeText;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
