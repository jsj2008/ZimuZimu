//
//  ChatRoomMemberCell.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/4.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ChatRoomMemberCell.h"

@interface ChatRoomMemberCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgeView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ChatRoomMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.headImgeView.layer.cornerRadius = (kScreenWidth - 90) / 6;
    self.headImgeView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setImgUrlString:(NSString *)imgUrlString{
    if (imgUrlString) {
        _imgUrlString = imgUrlString;
        
    }
}

- (void)setName:(NSString *)name{
    if (name) {
        _name = name;
        _nameLabel.text = _name;
    }
}

@end
