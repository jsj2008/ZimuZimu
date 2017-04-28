//
//  EvaluationListCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EvaluationListCell.h"

@interface EvaluationListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation EvaluationListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
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


- (void)setBgImageString:(NSString *)bgImageString{
    if (_bgImageString != bgImageString) {
        _bgImageString = bgImageString;
        _bgImageView.image = [UIImage imageNamed:bgImageString];
    }
}

@end
