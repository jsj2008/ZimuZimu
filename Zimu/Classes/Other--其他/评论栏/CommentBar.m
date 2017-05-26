//
//  CommentBar.m
//  Zimu
//
//  Created by Redpower on 2017/5/15.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CommentBar.h"
#import "NewLoginViewController.h"
#import "UIView+ViewController.h"
#import "MBProgressHUD+MJ.h"

@interface CommentBar ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *textBGView;           //textfield背景
@property (nonatomic, strong) UIButton *commentButton;      //评论按钮
@property (nonatomic, strong) UIButton *likeButton;         //收藏按钮
@property (nonatomic, strong) UIButton *shareButton;        //分享按钮
@property (nonatomic, strong) UIButton *submitButton;       //提交按钮

@property (nonatomic, assign) BOOL containNaviHeight;       //是否包含导航栏的高度
@end

@implementation CommentBar

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        self.backgroundColor = themeWhite;
//        self.size = CGSizeMake(kScreenWidth, 49);
//        [self makeUI];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTextFieldFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame containNaviHeight:(BOOL)containNaviHeight{
    self = [super initWithFrame:frame];
    if (self) {
        _containNaviHeight = containNaviHeight;
        self.backgroundColor = themeWhite;
        _hasCollected = NO;
        [self makeUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTextFieldFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}


- (void)makeUI{
    //上边界
    CALayer *topLine = [[CALayer alloc]init];
    topLine.frame = CGRectMake(0, 0, self.width, 0.5);
    topLine.backgroundColor = [UIColor colorWithHexString:@"999999"].CGColor;
    [self.layer addSublayer:topLine];
    
    //分享
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    CGSize size = _shareButton.currentImage.size;
    CGFloat width = size.width + 20;
    _shareButton.frame = CGRectMake(self.width - width, 0, width, 49);
    [_shareButton setImageEdgeInsets:UIEdgeInsetsMake((_shareButton.height - size.height)/2.0, 5, (_shareButton.height - size.height)/2.0, 15)];
    [_shareButton setTitleColor:[UIColor colorWithHexString:@"ececec"] forState:UIControlStateNormal];
    [_shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_shareButton];
    
    //收藏
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeButton setImage:[UIImage imageNamed:@"book_shoucang"] forState:UIControlStateNormal];
    [_likeButton setImage:[UIImage imageNamed:@"book_shoucang_click"] forState:UIControlStateSelected];
    size = _likeButton.currentImage.size;
    width = size.width + 20;
    _likeButton.frame = CGRectMake(CGRectGetMinX(_shareButton.frame) - width, CGRectGetMinY(_shareButton.frame), width, 49);
    [_likeButton setImageEdgeInsets:UIEdgeInsetsMake((_likeButton.height - size.height)/2.0, 10, (_likeButton.height - size.height)/2.0, 10)];
    [_likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_likeButton];
    
    //评论
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentButton setImage:[UIImage imageNamed:@"find_comment"] forState:UIControlStateNormal];
    size = _commentButton.currentImage.size;
    width = size.width + 20;
    _commentButton.frame = CGRectMake(CGRectGetMinX(_likeButton.frame) - width, CGRectGetMinY(_shareButton.frame), width, 49);
    [_commentButton setImageEdgeInsets:UIEdgeInsetsMake((_commentButton.height - size.height)/2.0, 15, (_likeButton.height - size.height)/2.0, 5)];
    [_commentButton addTarget:self action:@selector(commentButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_commentButton];
    
    //textField背景view
    _textBGView = [[UIView alloc]initWithFrame:CGRectMake(10, (self.height - 35)/2.0, CGRectGetMinX(_commentButton.frame) - 10, 35)];
    _textBGView.backgroundColor = [UIColor colorWithHexString:@"ececec"];
    _textBGView.layer.cornerRadius = _textBGView.height/2.0;
    [self addSubview:_textBGView];
    
    //textField
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(_textBGView.height/2.0, 0, _textBGView.width - _textBGView.height, _textBGView.height)];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.font = [UIFont systemFontOfSize:13];
    _textField.placeholder = @"发表评论...";
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    [_textBGView addSubview:_textField];
    
    //提交按钮（默认隐藏）
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitButton.frame = CGRectMake(self.width - 10 - 50, 0, 50, self.height);
    [_submitButton setTitle:@"发送" forState:UIControlStateNormal];
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_submitButton setTitleColor:themeBlue forState:UIControlStateNormal];
    [_submitButton addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _submitButton.hidden = YES;
    _submitButton.alpha = 0;
    [self addSubview:_submitButton];
    
}

//分享
- (void)share{
    
    if ([self.delegate respondsToSelector:@selector(commentBarShare)]) {
        [self.delegate commentBarShare];
    }
}
//收藏
- (void)likeButtonAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(commentBarSelect:)]) {
        [self.delegate commentBarSelect:button];
    }
}
//是否已收藏
- (void)setHasCollected:(BOOL)hasCollected{
    _hasCollected = hasCollected;
    _likeButton.selected = hasCollected;
}

//评论按钮
- (void)commentButtonAction{
    NSLog(@"评论");
    if ([self.delegate respondsToSelector:@selector(commentBarComment)]) {
        [self.delegate commentBarComment];
    }
}
//发表评论
- (void)submitButtonAction:(UIButton *)button{
    NSLog(@"发表 %@",_textField.text);
    if (_textField.text.length == 0) {
        [MBProgressHUD showMessage_WithoutImage:@"请输入评论内容" toView:nil];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(commentBarSubmit:)]) {
        [self.delegate commentBarSubmit:_textField.text];
    }
}


//评论
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //判断是否登录
    if ([userToken isEqualToString:@"logout"] || userToken == nil) {
        [MBProgressHUD showMessage_WithoutImage:@"请先登录" toView:nil];
    }
    return YES;
}

#pragma mark - 监听键盘高度
- (void)changeTextFieldFrame:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //获取键盘rect
    CGFloat duration = [UIKeyboardAnimationDurationUserInfoKey floatValue];
    if (_containNaviHeight) {
        [UIView animateWithDuration:duration animations:^{
            self.y = CGRectGetMinY(rect) - self.height - 64;
        }];
    }else{
        [UIView animateWithDuration:duration animations:^{
            self.y = CGRectGetMinY(rect) - self.height;
        }];
    }
    
    CGFloat y = rect.origin.y;
    //键盘是否弹起
    if (y < kScreenHeight - 100) {
        //键盘弹起
        _submitButton.hidden = NO;
        [UIView animateWithDuration:duration animations:^{
            _commentButton.alpha = 0;
            _likeButton.alpha = 0;
            _shareButton.alpha = 0;
            _submitButton.alpha = 1;
            _textBGView.width = CGRectGetMinX(_submitButton.frame) - 10;
            _textField.frame = CGRectMake(_textBGView.height/2.0, 0, _textBGView.width - _textBGView.height, _textBGView.height);
        } completion:^(BOOL finished) {
            _commentButton.hidden = YES;
            _likeButton.hidden = YES;
            _shareButton.hidden = YES;
        }];
    }else{
        //键盘收回
        _commentButton.hidden = NO;
        _likeButton.hidden = _collectButtonHide;
        _shareButton.hidden = NO;
        [UIView animateWithDuration:duration animations:^{
            _commentButton.alpha = 1;
            _likeButton.alpha = 1;
            _shareButton.alpha = 1;
            _submitButton.alpha = 0;
            _textBGView.width = CGRectGetMinX(_commentButton.frame) - 10;
            _textField.frame = CGRectMake(_textBGView.height/2.0, 0, _textBGView.width - _textBGView.height, _textBGView.height);
        } completion:^(BOOL finished) {
            _submitButton.hidden = YES;
        }];
    }
}

#pragma mark - 是否需要收藏
- (void)setCollectButtonHide:(BOOL)collectButtonHide{
    _collectButtonHide = collectButtonHide;
    if (_collectButtonHide) {
        //隐藏收藏按钮
        _likeButton.hidden = _collectButtonHide;
        _commentButton.frame = _likeButton.frame;
        _textBGView.frame = CGRectMake(10, (self.height - 35)/2.0, CGRectGetMinX(_commentButton.frame) - 10, 35);
        _textField.frame = CGRectMake(_textBGView.height/2.0, 0, _textBGView.width - _textBGView.height, _textBGView.height);
    }
}




#pragma mark - 去登陆
- (void)gotoLogin{
    NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
    [self.viewController presentViewController:newLoginVC animated:YES completion:nil];
}


@end
