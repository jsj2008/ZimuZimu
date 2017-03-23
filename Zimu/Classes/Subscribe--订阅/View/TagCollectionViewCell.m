//
//  TagCollectionViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "TagCollectionViewCell.h"

@interface TagCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@end

@implementation TagCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = themeYellow;
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    _tagLabel.textColor = [UIColor lightGrayColor];
}

- (void)setTagString:(NSString *)tagString{
    if (_tagString != tagString) {
        _tagString = tagString;
        _tagLabel.text = _tagString;
    }
}

@end
