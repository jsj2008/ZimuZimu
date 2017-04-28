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

@end
