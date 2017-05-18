//
//  SearchFriendMyMsgCell.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SearchFriendMyMsgCell.h"

@interface SearchFriendMyMsgCell ()

@property (nonatomic, copy) NSString *idStr;
@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *imgUrl;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@end

@implementation SearchFriendMyMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{
    
    _nameLabel.text = _nameStr;
    _idLabel.text = [NSString stringWithFormat:@"ID:%@", _idStr];
}
- (void)setName:(NSString *)name idStr:(NSString *)idString age:(NSInteger)age imgUrlString:(NSString *)urlStr{
    _idStr = idString;
    _nameStr = name;
    _imgUrl = urlStr;
}

@end
