//
//  ZMFriendSearchResultCell.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/4.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZMFriendSearchResultCell.h"

@interface ZMFriendSearchResultCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@end

@implementation ZMFriendSearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{
//    _nameLabel.frame = CGRectMake(105, 14.5, 200, 17);
//    _nameLabel.textColor = themeBlack;
//    
//    _idLabel.frame = CGRectMake(105, 39.5, 200, 17);
//    _idLabel.textColor = [UIColor colorWithHexString:@"999999"];
    
    self.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
}

#pragma mark - setter
- (void)setNameString:(NSString *)nameString{
    if (nameString) {
        _nameString = nameString;
        _nameLabel.text = nameString;
    }
}
- (void)setIdString:(NSString *)idString{
    if (idString) {
        _idString = idString;
        _idLabel.text = [NSString stringWithFormat:@"ID: %@", idString];
    }
}
@end
