//
//  FMCollectionViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "AlignmentLabel.h"

@interface FMCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *FMImageView;
@property (weak, nonatomic) IBOutlet AlignmentLabel *titleLabel;

@end
@implementation FMCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _titleLabel.textColor = themeBlack;
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
