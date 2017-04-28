//
//  ConfuseContentCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ConfuseContentCell.h"
#import "AlignmentLabel.h"

@interface ConfuseContentCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet AlignmentLabel *contentLabel;

@end

@implementation ConfuseContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _contentLabel.text = @"暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLayoutFrame:(ConfuseContentCellLayoutFrame *)layoutFrame {
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        
        _titleLabel.frame = layoutFrame.titleLabelFrame;
        
        _contentLabel.frame = layoutFrame.contentLabelFrame;
    }
}

@end
