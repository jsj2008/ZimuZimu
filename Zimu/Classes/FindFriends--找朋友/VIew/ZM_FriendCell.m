//
//  ZM_FriendCell.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZM_FriendCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ZM_FriendCell ()
//用户头像
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
//用户名字
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//选中图标
@property (weak, nonatomic) IBOutlet UIImageView *selectedImg;
//蒙版
@property (weak, nonatomic) IBOutlet UIView *canVansView;

@end

@implementation ZM_FriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImgUrlString:(NSString *)imgUrlString{
    _imgUrlString = [imagePrefixURL stringByAppendingString:imgUrlString];
    
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:_imgUrlString] placeholderImage:[UIImage imageNamed:@"mine_head_placeholder"]];
}

- (void)setNameString:(NSString *)nameString{
    _nameLabel.text = nameString;
}

- (void)setState:(friendViewState)state{
    _state = state;
    
    switch (_state) {
        case friendViewStateNormal:
            _selectedImg.hidden = YES;
            _canVansView.hidden = YES;
            break;
        case friendViewStateChoosingSelected:
            _canVansView.hidden = YES;
            _selectedImg.hidden = NO;
            break;
        case friendViewStateChoosingDisSelected:
            _canVansView.hidden = NO;
            _selectedImg.hidden = YES;
            break;
        default:
            _selectedImg.hidden = YES;
            _canVansView.hidden = NO;
            break;
    }
}
@end
