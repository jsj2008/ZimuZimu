//
//  PouroutCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "PouroutCell.h"
#import "DynamicTextTableView.h"

@interface PouroutCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet DynamicTextTableView *dynamicTextTableView;

@end
@implementation PouroutCell

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
    
    _titleLabel.textColor = themeBlack;
    _lineView.backgroundColor = themeGray;
    
}


- (void)setTextArray:(NSArray *)textArray{
    if (_textArray != textArray) {
        _textArray = textArray;
        _dynamicTextTableView.textArray = _textArray;
    }
}


@end
