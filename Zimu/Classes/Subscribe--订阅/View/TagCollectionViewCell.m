//
//  TagCollectionViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "TagCollectionViewCell.h"
#import "UIImage+ZMExtension.h"

@interface TagCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@end

@implementation TagCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor clearColor];
    _tagLabel.textColor = [UIColor colorWithHexString:@"888888"];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"FFE9A2"] size:_bgImageView.size];
    image = [image imageAddCornerWithRadious:5 size:_bgImageView.size];
    _bgImageView.image = image;
}

- (void)setTagString:(NSString *)tagString{
    if (_tagString != tagString) {
        _tagString = tagString;
        _tagLabel.text = _tagString;
    }
}

@end
