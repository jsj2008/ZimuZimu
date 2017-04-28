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

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@end

@implementation TagCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = themeWhite;
    _tagLabel.textColor = themeYellow;
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.cornerRadius = self.height/2.0;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor colorWithHexString:@"FFE9A2"].CGColor;
    self.layer.borderWidth = 1;
    
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"FFE9A2"] size:_bgImageView.size];
    image = [image imageAddCornerWithRadious:self.height/2.0 size:_bgImageView.size];
    _bgImageView.image = image;
}

- (void)setTagString:(NSString *)tagString{
    if (_tagString != tagString) {
        _tagString = tagString;
        _tagLabel.text = _tagString;
    }
}

@end
