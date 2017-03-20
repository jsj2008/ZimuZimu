//
//  ExamFreeFMCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExamFreeFMCell.h"

@interface ExamFreeFMCell ()

@property (weak, nonatomic) IBOutlet UIImageView *FMImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;


@end
@implementation ExamFreeFMCell

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
    
    _FMImageView.clipsToBounds = YES;
    _FMImageView.layer.cornerRadius = 5;
    _FMImageView.layer.masksToBounds = YES;
    _titleLabel.textColor = themeBlack;
    
    _playTimeLabel.textColor = [UIColor darkGrayColor];
    _authorLabel.textColor = [UIColor darkGrayColor];

}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _FMImageView.image = [UIImage imageNamed:_imageString];
        
    }
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
        
    }
}

@end
