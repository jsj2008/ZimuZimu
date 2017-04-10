//
//  FMListHeaderCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMListHeaderCell.h"

@interface FMListHeaderCell ()

@property (weak, nonatomic) IBOutlet UIView *markView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moreImageView;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;
@property (weak, nonatomic) IBOutlet UIView *seperateLine;


@end

@implementation FMListHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _seperateLine.backgroundColor = themeGray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        
        _titleLabel.text = titleString;
    }
}

@end
