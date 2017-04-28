//
//  FMDetailOtherFMCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMDetailOtherFMCell.h"

@interface FMDetailOtherFMCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@end

@implementation FMDetailOtherFMCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
