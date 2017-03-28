//
//  FindArticleCell.m
//  Zimu
//
//  Created by apple on 2017/3/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindArticleCell.h"

@implementation FindArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.priceLabel.layer.borderColor = [UIColor colorWithHexString:@"FEBD18"].CGColor;
    self.priceLabel.layer.borderWidth = 0.5;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
