//
//  FindListHeaderCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindListHeaderCell.h"

@interface FindListHeaderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;


@end

@implementation FindListHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setBgImageString:(NSString *)bgImageString{
    if (_bgImageString != bgImageString) {
        _bgImageString = bgImageString;
        _bgImageView.image = [UIImage imageNamed:bgImageString];
    }
}

@end
