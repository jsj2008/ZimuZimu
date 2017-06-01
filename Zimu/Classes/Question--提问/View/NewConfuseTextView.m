//
//  NewConfuseTextView.m
//  Zimu
//
//  Created by Redpower on 2017/5/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "NewConfuseTextView.h"

@interface NewConfuseTextView ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UILabel *wordCountLabel;
@property (nonatomic, assign) NSInteger maxWordCount;       //限制字数

@end

@implementation NewConfuseTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _maxWordCount = 500;
        _confuseString = @"";
        self.backgroundColor = themeWhite;
        [self setupHeaderView];
        [self setupTextView];
    }
    return self;
}

- (void)setupHeaderView{
    //标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, self.width - 80, 15)];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = [UIColor colorWithHexString:@"222222"];
    _titleLabel.text = @"问题描述";
    [self addSubview:_titleLabel];
    
}

- (void)setupTextView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(_titleLabel.frame) + 20, self.width - 80, 185)];
    view.layer.borderColor = [UIColor colorWithHexString:@"EEEEEE"].CGColor;
    view.layer.borderWidth = 0.8;
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    [self addSubview:view];
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, view.width, view.height - 20)];
    [view addSubview:_textView];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.delegate = self;
    _textView.backgroundColor = themeWhite;
    //用一个label来代替placeholder
    _placeholderLabel = [[UILabel alloc]init];
    _placeholderLabel.textColor = [UIColor lightGrayColor];
    _placeholderLabel.numberOfLines = 0;
    NSString *holderString = @"描述你的困惑";
    UIFont *holderFont = [UIFont systemFontOfSize:14];
    _placeholderLabel.text = holderString;
    _placeholderLabel.font = holderFont;
    CGSize holderSize = [holderString sizeWithAttributes:@{NSFontAttributeName:holderFont}];
    _placeholderLabel.frame = CGRectMake(5, 7, _textView.frame.size.width - 10, holderSize.height);
    [_textView addSubview:_placeholderLabel];
    //显示字数label
    UIView *wordCountView = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_textView.frame), view.width - 10, 20)];
    wordCountView.backgroundColor = themeWhite;
    [view addSubview:wordCountView];
    _wordCountLabel = [[UILabel alloc]initWithFrame:wordCountView.bounds];
    _wordCountLabel.width = wordCountView.width - 5;
    _wordCountLabel.backgroundColor = themeWhite;
    _wordCountLabel.textColor = [UIColor lightGrayColor];
    _wordCountLabel.font = [UIFont systemFontOfSize:14];
    _wordCountLabel.text = [NSString stringWithFormat:@"0/%li",_maxWordCount];
    _wordCountLabel.textAlignment = NSTextAlignmentRight;
    [wordCountView addSubview:_wordCountLabel];
}

//UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    //键盘升起，改变_addPointTableView的frame
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    //键盘收起，改变_addPointTableView的frame
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length != 0) {
        _placeholderLabel.hidden = YES;
        _confuseString = textView.text;
    }else{
        _placeholderLabel.hidden = NO;
        _confuseString = @"";
    }
    
    NSInteger number = [textView.text length];
    if (number > _maxWordCount) {
        textView.text = [textView.text substringToIndex:_maxWordCount];
        number = _maxWordCount;
    }
    _wordCountLabel.text = [NSString stringWithFormat:@"%li/%li",(long)number, _maxWordCount];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark - 监听键盘高度
- (void)keyboardWillShown:(NSNotification *)notif{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyboardWasShown:%f", keyboardSize.height);  //216
    
    [self.delegate newConfuseTextViewKeyboardWillShow:keyboardSize.height];
    
}
- (void)keyboardWillHidden:(NSNotification *)notif{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height);
    
    [self.delegate newConfuseTextViewKeyboardWillhide:keyboardSize.height];
    
}


@end
