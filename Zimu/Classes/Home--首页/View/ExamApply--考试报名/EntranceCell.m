//
//  EntranceCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EntranceCell.h"

@interface EntranceCell ()

@property (weak, nonatomic) IBOutlet UIButton *psychologyButton;            //心理咨询师报名
@property (weak, nonatomic) IBOutlet UIButton *marriageutton;               //婚姻咨询师报名

- (IBAction)psychologyButton:(UIButton *)sender;
- (IBAction)marriageButton:(UIButton *)sender;

@end

@implementation EntranceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _psychologyButton.layer.cornerRadius = 5;
    _psychologyButton.layer.masksToBounds = YES;
    [_psychologyButton setTitle:@"心理咨询师报名入口" forState:UIControlStateNormal];
    [_psychologyButton setTitleColor:themeBlack forState:UIControlStateNormal];
    [_psychologyButton setBackgroundColor:[UIColor colorWithHexString:@"fedb18"]];
    
    _marriageutton.layer.cornerRadius = 5;
    _marriageutton.layer.masksToBounds = YES;
    [_marriageutton setTitle:@"婚姻咨询师报名入口" forState:UIControlStateNormal];
    [_marriageutton setTitleColor:themeBlack forState:UIControlStateNormal];
    [_marriageutton setBackgroundColor:[UIColor colorWithHexString:@"fedb18"]];
    
}

- (IBAction)psychologyButton:(UIButton *)sender {
    NSLog(@"心理咨询师");
}

- (IBAction)marriageButton:(UIButton *)sender {
    NSLog(@"婚姻咨询师");
}
@end
