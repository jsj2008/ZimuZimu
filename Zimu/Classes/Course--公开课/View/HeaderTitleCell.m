//
//  HeaderTitleCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HeaderTitleCell.h"

@interface HeaderTitleCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *markView;


@end

@implementation HeaderTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _titleLabel.textColor = [UIColor blackColor];
    _lineView.backgroundColor = themeGray;
    _markView.backgroundColor = themeYellow;

}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
    }
}


@end
