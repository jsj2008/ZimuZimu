//
//  EditNickNameCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/2.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EditNickNameCell.h"
#import <Masonry.h>

@interface EditNickNameCell ()<UITextFieldDelegate>

@end

@implementation EditNickNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _textField = [[UITextField alloc]init];
    _textField.delegate = self;
    [self.contentView addSubview:_textField];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(10);
        make.top.mas_equalTo(self.mas_top);
        make.centerY.equalTo(self);
        make.right.mas_equalTo(self.mas_right).with.offset(-10);
    }];
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.textColor = [UIColor blackColor];
    _textField.textAlignment = NSTextAlignmentLeft;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}


@end
