//
//  OrderInfoCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "OrderInfoCell.h"

@interface OrderInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payTimeLabel;


@end

@implementation OrderInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
