//
//  PaymentChannelCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "PaymentChannelCell.h"

@interface PaymentChannelCell ()

@property (weak, nonatomic) IBOutlet UIButton *channelButton;       //支付方式



@end

@implementation PaymentChannelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    _selectButton.layer.cornerRadius = 10;
//    _selectButton.layer.masksToBounds = YES;
//    _selectButton.layer.borderColor = themeGray.CGColor;
//    _selectButton.layer.borderWidth = 1;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        [_channelButton setImage:[UIImage imageNamed:_imageString] forState:UIControlStateNormal];
    }
}

- (void)setChannelString:(NSString *)channelString{
    if (_channelString != channelString) {
        _channelString = channelString;
        [_channelButton setTitle:_channelString forState:UIControlStateNormal];
    }
}

@end
