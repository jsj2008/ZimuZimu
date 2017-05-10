//
//  FriendMsgCell.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FriendMsgCell.h"

@interface FriendMsgCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation FriendMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setImgUrl:(NSString *)imgUrl{
    if (imgUrl) {
        _imgUrl = imgUrl;
        
        
    }
}
- (void)setNameString:(NSString *)nameString{
    if (nameString) {
        _nameString = nameString;
        _nameLabel.text = _nameString;
    }
}


- (void)setIsFriend:(BOOL)isFriend{
    if (isFriend != _isFriend) {
        _isFriend = isFriend;
        if (_isFriend == YES) {
            _detailLabel.text = @"你的好友请求已通过";
            
            _sureBtn.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
            [_sureBtn setTitle:@"已通过" forState:UIControlStateNormal];
            _sureBtn.layer.cornerRadius = 0;
            _sureBtn.layer.masksToBounds = NO;
            [_sureBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
            _sureBtn.userInteractionEnabled = NO;
        }else{
            _detailLabel.text = @"请求添加你为好友!";
            
            _sureBtn.backgroundColor = [UIColor colorWithHexString:@"F5CE13"];
            [_sureBtn setTitle:@"同意" forState:UIControlStateNormal];
            [_sureBtn setTitleColor:themeBlack forState:UIControlStateNormal];
            _sureBtn.layer.cornerRadius = 5;
            _sureBtn.layer.masksToBounds = YES;
            _sureBtn.userInteractionEnabled = YES;
        }
        
    }
}


- (IBAction)acceptBtnActio:(id)sender {
    NSLog(@"同意");
    [self.clickBtnDelegate didClickAccceptBtn:self];
    
    if (_isFriend == NO) {
        self.isFriend = YES;
    }
}


@end
