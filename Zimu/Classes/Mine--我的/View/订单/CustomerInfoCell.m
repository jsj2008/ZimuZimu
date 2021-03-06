//
//  CustomerInfoCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CustomerInfoCell.h"

@interface CustomerInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


@end

@implementation CustomerInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setOrderUserModel:(OrderUserModel *)orderUserModel{
    _orderUserModel = orderUserModel;
    
    //姓名
    _nameLabel.text = [NSString stringWithFormat:@"联系人：%@",orderUserModel.userName];
    
    //电话
    _phoneLabel.text = [NSString stringWithFormat:@"联系方式：%@",orderUserModel.userPhone];
}


@end
