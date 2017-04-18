//
//  CityCourseDetailThemeCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/13.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CityCourseDetailThemeCell.h"

@interface CityCourseDetailThemeCell ()

@property (weak, nonatomic) IBOutlet UILabel *themeLabel;


@end

@implementation CityCourseDetailThemeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
}

- (void)layoutSubviews{
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLayoutFrame:(CityCourseDetailThemeCellLayoutFrame *)layoutFrame{
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        
        _themeLabel.frame = layoutFrame.themeLabelFrame;
        _themeLabel.text = layoutFrame.themeString;
    }
}

@end
