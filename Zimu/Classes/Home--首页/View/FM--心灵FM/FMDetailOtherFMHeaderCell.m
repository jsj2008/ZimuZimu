//
//  FMDetailOtherFMHeaderCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMDetailOtherFMHeaderCell.h"

@interface FMDetailOtherFMHeaderCell ()

@property (weak, nonatomic) IBOutlet UIView *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIView *seperateLine;


@end

@implementation FMDetailOtherFMHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _seperateLine.backgroundColor = themeGray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
