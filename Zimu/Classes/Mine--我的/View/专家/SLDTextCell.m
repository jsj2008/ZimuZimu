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
    
    _titleLabel.text = _layoutFrame.titleString;
    _contentLabel.text = _layoutFrame.textString;
}

- (void)setLayoutFrame:(SLDTextCellLayoutFrame *)layoutFrame{
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        
        _titleLabel.frame = _layoutFrame.titleLabelFrame;
        _contentLabel.frame = _layoutFrame.contentLabelFrame;
        
    }
}


@end
