//
//  HeaderTitleCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HeaderTitleCell.h"

@interface HeaderTitleCell ()

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
- (IBAction)moreButton:(id)sender;


@end

@implementation HeaderTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _titleLabel.textColor = [UIColor blackColor];
    _lineView.backgroundColor = themeGray;
    [_moreButton setTitleColor:themeYellow forState:UIControlStateNormal];
    [_moreButton setTitle:@"查看全部" forState:UIControlStateNormal];
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
    }
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _markImageView.image = [UIImage imageNamed:_imageString];;
    }
}

- (IBAction)moreButton:(id)sender {
    NSLog(@"点击查看更多");
}
@end
