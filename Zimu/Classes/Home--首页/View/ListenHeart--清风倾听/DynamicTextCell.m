//
//  DynamicTextCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "DynamicTextCell.h"

@interface DynamicTextCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
@implementation DynamicTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _titleLabel.textColor = themeBlack;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
        
    }
}


@end
