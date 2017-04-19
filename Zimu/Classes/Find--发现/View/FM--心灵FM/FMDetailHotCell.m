//
//  FMDetailHotCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMDetailHotCell.h"

@interface FMDetailHotCell ()

@property (weak, nonatomic) IBOutlet UILabel *hotLabel;
@property (weak, nonatomic) IBOutlet UIButton *conmmentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;


@end

@implementation FMDetailHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
