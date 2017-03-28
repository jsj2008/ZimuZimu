//
//  SLDTextCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SLDTextCell.h"

@interface SLDTextCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end

@implementation SLDTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    _titleLabel.text = @"相关资质";
    _contentLabel.text = @"清华大学心理学博士\n国家二级心理咨询师\n国家心理中心认证咨询师\n清华大学心理学博士\n国家二级心理咨询师\n国家心理中心认证咨询师";
}

- (void)setLayoutFrame:(SLDTextCellLayoutFrame *)layoutFrame{
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        
        _titleLabel.frame = _layoutFrame.titleLabelFrame;
        _contentLabel.frame = _layoutFrame.contentLabelFrame;
        
    }
}

@end
