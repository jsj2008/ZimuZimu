//
//  ConfuseDetailView.m
//  Zimu
//
//  Created by Redpower on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ConfuseDetailView.h"

@interface ConfuseDetailView ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UILabel *wordCountLabel;
@property (nonatomic, assign) NSInteger maxWordCount;       //限制字数

@end

@implementation ConfuseDetailView

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
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 35)];
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
    titleLabel.textColor = [UIColor colorWithHexString:@"222222"];
    titleLabel.text = @"详情";
    [_headerView addSubview:titleLabel];
    
}

- (void)setupTextView{
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_headerView.frame), self.width - 20, kScreenHeight * 0.4)];
    [self addSubview:_textView];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.delegate = self;
    _textView.backgroundColor = themeGray;
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
    UIView *wordCountView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_textView.frame), self.width - 20, 20)];
    wordCountView.backgroundColor = themeGray;
    [self addSubview:wordCountView];
    _wordCountLabel = [[UILabel alloc]initWithFrame:wordCountView.bounds];
    _wordCountLabel.width = wordCountView.width - 5;
    _wordCountLabel.backgroundColor = themeGray;
    _wordCountLabel.textColor = [UIColor lightGrayColor];
    _wordCountLabel.font = [UIFont systemFontOfSize:14];
    _wordCountLabel.text = [NSString stringWithFormat:@"%li",_maxWordCount];
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
    
    [self.delegate keyboardWillShow:keyboardSize.height];

}
- (void)keyboardWillHidden:(NSNotification *)notif{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height);
    
    [self.delegate keyboardWillhide:keyboardSize.height];

}

@end
