//
//  HeaderTitleCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HeaderTitleCell.h"

@interface HeaderTitleCell ()

@property (weak, nonatomic) IBOutlet UIView *markView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
- (IBAction)moreButton:(id)sender;


@end

@implementation HeaderTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _markView.backgroundColor = [UIColor lightGrayColor];
    _titleLabel.textColor = [UIColor darkGrayColor];
    _lineView.backgroundColor = themeGray;
    [_moreButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_moreButton setTitle:@"点击查看更多" forState:UIControlStateNormal];
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
    }
}

- (IBAction)moreButton:(id)sender {
    NSLog(@"点击查看更多");
}
@end
