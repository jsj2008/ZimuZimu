//
//  FindTestListCell.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindTestListCell.h"

@implementation FindTestListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCount:(NSInteger)count{
    if (_count != count) {
        _count = count;
        [_countCount setTitle:[NSString stringWithFormat:@" %zd", count] forState:UIControlStateNormal];
    }
}

@end
