//
//  SearchFriendsFriendCell.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SearchFriendsFriendCell.h"

@interface SearchFriendsFriendCell ()

@property (nonatomic, copy) NSString *idStr;
@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, assign) NSInteger age;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@end

@implementation SearchFriendsFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{
    _ageLabel.layer.cornerRadius = 6;
    _ageLabel.layer.borderColor = [UIColor colorWithHexString:@"f5ce13"].CGColor;
    _ageLabel.layer.borderWidth = 0.5;
    _ageLabel.layer.masksToBounds = YES;
    
    _idLabel.textColor = [UIColor colorWithHexString:@"999999"];
    
    _nameLabel.text = _nameStr;
    _idLabel.text = [NSString stringWithFormat:@"ID:%@", _idStr];
    _ageLabel.text = [NSString stringWithFormat:@"  %zd岁  ", _age];
}
- (void)setName:(NSString *)name idStr:(NSString *)idString age:(NSInteger)age imgUrlString:(NSString *)urlStr{
    _idStr = idString;
    _nameStr = name;
    _imgUrl = urlStr;
    _age = age;
}
- (IBAction)addFriendBtnAction:(id)sender {
    
}

@end
