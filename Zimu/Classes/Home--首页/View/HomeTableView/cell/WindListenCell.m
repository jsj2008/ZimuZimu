//
//  WindListenCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "WindListenCell.h"

@interface WindListenCell ()

@property (weak, nonatomic) IBOutlet UIButton *listenButton;


@end

@implementation WindListenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _listenButton.layer.cornerRadius = 5;
    _listenButton.layer.masksToBounds = YES;
    _listenButton.enabled = NO;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
