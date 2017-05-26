//
//  QuestionTitleView.m
//  Zimu
//
//  Created by Redpower on 2017/5/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QuestionTitleView.h"

@interface QuestionTitleView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *submitButton;       //提交

@end

@implementation QuestionTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, self.width, 35)];
    [self addSubview:_headerView];
    
    //竖线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 5, 20)];
    lineView.centerY = _headerView.centerY;
    lineView.backgroundColor = themeYellow;
    [_headerView addSubview:lineView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame) + 5, 10, self.width/2.0, 20)];
    titleLabel.centerY = _headerView.centerY;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.text = @"标题";
    [_headerView addSubview:titleLabel];
    
    //提交
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(_headerView.width - 50, 0, 50, 35);
    [nextButton setImage:[UIImage imageNamed:@"question_next"] forState:UIControlStateNormal];
    CGSize size = nextButton.currentImage.size;
    [nextButton setImageEdgeInsets:UIEdgeInsetsMake(nextButton.height - size.height, nextButton.width - 10 - size.width, 0, 10)];
    [nextButton addTarget:self action:@selector(submitQuestion) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:nextButton];
    
    //输入框
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_headerView.frame), self.width - 20, 30)];
    _textField.clearsOnBeginEditing = YES;
    _textField.textColor = [UIColor colorWithHexString:@"666666"];
    _textField.font = [UIFont systemFontOfSize:14];
    _textField.placeholder = @"请输入问题标题...";
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    [self addSubview:_textField];
    CALayer *textLine = [[CALayer alloc]init];
    textLine.frame = CGRectMake(0, _textField.height - 1, _textField.width, 1);
    textLine.backgroundColor = themeGray.CGColor;
    [_textField.layer addSublayer:textLine];
}

- (void)submitQuestion{

    if ([self.delegate respondsToSelector:@selector(submitQuestion)]) {
        [self.delegate submitQuestion];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

@end
