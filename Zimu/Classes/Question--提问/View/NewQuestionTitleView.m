//
//  NewQuestionTitleView.m
//  Zimu
//
//  Created by Redpower on 2017/5/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "NewQuestionTitleView.h"

@interface NewQuestionTitleView ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UITextField *textField;

@end


@implementation NewQuestionTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"F5CD13"];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, self.width - 80, 15)];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    titleLabel.text = @"您的问题是？";
    [self addSubview:titleLabel];
    
    //输入框
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(titleLabel.frame) + 15, self.width - 80, 30)];
    _textField.clearsOnBeginEditing = YES;
    _textField.textColor = themeWhite;
    _textField.font = [UIFont systemFontOfSize:25];
    NSString *holderText = @"请输入您的问题";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                       value:themeWhite
                       range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                       value:[UIFont boldSystemFontOfSize:20]
                       range:NSMakeRange(0, holderText.length)];
    _textField.attributedPlaceholder = placeholder;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    [self addSubview:_textField];
    CALayer *textLine = [[CALayer alloc]init];
    textLine.frame = CGRectMake(0, _textField.height + 3, _textField.width, 1);
    textLine.backgroundColor = themeWhite.CGColor;
    [_textField.layer addSublayer:textLine];
}


//UITextViewDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //键盘升起，改变_addPointTableView的frame
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //键盘收起，改变_addPointTableView的frame
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - 监听键盘高度
- (void)keyboardWillShown:(NSNotification *)notif{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyboardWasShown:%f", keyboardSize.height);  //216
    
    [self.delegate newQuestionTitleViewKeyboardWillShow:keyboardSize.height];
    
}
- (void)keyboardWillHidden:(NSNotification *)notif{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height);
    
    [self.delegate newQuestionTitleViewKeyboardWillhide:keyboardSize.height];
    
}


@end
