//
//  FMCollectionViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface FMCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *FMImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation FMCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    _FMImageView.clipsToBounds = YES;
//    _FMImageView.layer.cornerRadius = 5;
//    _FMImageView.layer.masksToBounds = YES;
    _titleLabel.textColor = themeBlack;
    [_titleLabel sizeToFit];
}


- (void)setHomeFMItem:(HomeFMItems *)homeFMItem{
    if (_homeFMItem != homeFMItem) {
        _homeFMItem = homeFMItem;
        _titleLabel.text = homeFMItem.fmTitle;
        NSURL *url = [NSURL URLWithString:@"http://on9fin031.bkt.clouddn.com/image/20170323174423228187"];
        [_FMImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"home_FM"]];
    }
}

@end
