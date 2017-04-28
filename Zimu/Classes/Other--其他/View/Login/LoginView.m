//
//  LoginView.m
//  Zimu
//
//  Created by Redpower on 2017/4/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "LoginView.h"
#import "Masonry.h"
#import "UIImage+ZMExtension.h"
#import "MBProgressHUD+MJ.h"

@interface LoginView ()<UITextFieldDelegate>

@property (nonatomic, assign) CGFloat widthScale;
@property (nonatomic, assign) CGFloat heightScale;

@property (nonatomic, strong) UIImageView *headLineImageView;
@property (nonatomic, strong) UIView *whiteBGView;
@property (nonatomic, strong) UIImageView *logoImageview;
@property (nonatomic, strong) UITextField *checkCodeTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *protocolButton;
@property (nonatomic, strong) UIImageView *coverImageView1;
@property (nonatomic, strong) UIImageView *coverImageView2;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    _widthScale = kScreenWidth/375.0;
    _heightScale = kScreenHeight/667.0;
    
    /*headline*/
    _headLineImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_headline"]];
    _headLineImageView.frame = CGRectMake(0, 120 * _heightScale, 315 * _widthScale, 10);
    _headLineImageView.centerX = self.centerX;
    [self addSubview:_headLineImageView];
    
    /*whiteBGView*/
    _whiteBGView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(_headLineImageView.frame) + 5, 295 * _widthScale, 400 * _heightScale)];
    _whiteBGView.centerX = self.centerX;
    _whiteBGView.backgroundColor = themeWhite;
    [self addSubview:_whiteBGView];
    
    /*logoView*/
    UIImage *logoImage = [UIImage imageNamed:@"login_icon"];
    _logoImageview = [[UIImageView alloc]initWithImage:logoImage];
    _logoImageview.frame = CGRectMake((_whiteBGView.width - logoImage.size.width)/2.0, 30 * _heightScale, logoImage.size.width, logoImage.size.height);
    [_whiteBGView addSubview:_logoImageview];
    
    /*phoneTextField*/
    UIFont *font = [UIFont systemFontOfSize:16];
    if (kScreenWidth == 320) {
        font = [UIFont systemFontOfSize:14];
    }
    _phoneTextField = [[UITextField alloc]init];
    _phoneTextField.frame = CGRectMake(25 * _widthScale, 130 * _heightScale, _whiteBGView.width - 50 * _widthScale, 40);
    _phoneTextField.layer.cornerRadius = 20;
    _phoneTextField.layer.masksToBounds = YES;
    _phoneTextField.delegate = self;
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_phone"]];
    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    _phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.font = font;
    _phoneTextField.backgroundColor = [UIColor colorWithHexString:@"FEDA81"];
    //设置输入框的监控方法
    [_phoneTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_whiteBGView addSubview:_phoneTextField];
    
    /*checkCodeTextField*/
    _checkCodeTextField = [[UITextField alloc]init];
    _checkCodeTextField.frame = CGRectMake(CGRectGetMinX(_phoneTextField.frame), CGRectGetMaxY(_phoneTextField.frame) + 20, 135 * _widthScale, 40);
    _checkCodeTextField.layer.cornerRadius = 20;
    _checkCodeTextField.layer.masksToBounds = YES;
    _checkCodeTextField.delegate = self;
    _checkCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _checkCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _checkCodeTextField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_lock"]];
    _checkCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    _checkCodeTextField.placeholder = @"输入验证码";
    _checkCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _checkCodeTextField.font = font;
    _checkCodeTextField.backgroundColor = [UIColor colorWithHexString:@"FEDA81"];
    [_checkCodeTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_whiteBGView addSubview:_checkCodeTextField];
    
    /*sendCodeButton*/
    _sendCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendCodeButton.frame = CGRectMake(CGRectGetMaxX(_phoneTextField.frame) - 100 * _widthScale, CGRectGetMinY(_checkCodeTextField.frame), 100 * _widthScale, 40);
    _sendCodeButton.layer.cornerRadius = 20;
    _sendCodeButton.layer.masksToBounds = YES;
    _sendCodeButton.titleLabel.font = font;
    _sendCodeButton.enabled = NO;
    [_sendCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_sendCodeButton setTitleColor:themeWhite forState:UIControlStateNormal];
    [_sendCodeButton setBackgroundColor:[UIColor colorWithHexString:@"c5c5c5"]];
    [_sendCodeButton addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
    [_whiteBGView addSubview:_sendCodeButton];
    
    /*loginButton*/
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake(CGRectGetMinX(_phoneTextField.frame), CGRectGetMaxY(_checkCodeTextField.frame) + 35 * _heightScale, CGRectGetWidth(_phoneTextField.frame), 40);
    _loginButton.layer.cornerRadius = 20;
    _loginButton.layer.masksToBounds = YES;
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:themeWhite forState:UIControlStateNormal];
    [_loginButton setBackgroundColor:[UIColor colorWithHexString:@"c5c5c5"]];
    _loginButton.enabled = NO;
    [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_whiteBGView addSubview:_loginButton];

    /*protocolLabel*/
    _protocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _protocolButton.frame = CGRectMake(CGRectGetMinX(_loginButton.frame), CGRectGetMaxY(_loginButton.frame) + 13, CGRectGetWidth(_loginButton.frame), 15);
    _protocolButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_protocolButton setTitle:@"登录即同意子慕《使用协议》" forState:UIControlStateNormal];
    [_protocolButton setTitleColor:[UIColor colorWithHexString:@"c5c5c5"] forState:UIControlStateNormal];
    [_protocolButton addTarget:self action:@selector(protocolButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_whiteBGView addSubview:_protocolButton];

    /*coverImageView1*/
    UIImage *cover1 = [UIImage imageNamed:@"login_cover1"];
    _coverImageView1 = [[UIImageView alloc]initWithImage:cover1];
//    CGFloat scale1 = cover1.size.width / cover1.size.height;
    _coverImageView1.frame = CGRectMake(100 * _widthScale, CGRectGetMinY(_headLineImageView.frame) - cover1.size.height + 23, cover1.size.width, cover1.size.height);
    [self addSubview:_coverImageView1];

    /*coverImageView2*/
    UIImage *cover2 = [UIImage imageNamed:@"login_cover2"];
    _coverImageView2 = [[UIImageView alloc]initWithImage:cover2];
//    CGFloat scale2 = cover2.size.width / cover2.size.height;
    _coverImageView2.frame = CGRectMake(kScreenWidth - cover2.size.width, kScreenHeight - cover2.size.height, cover2.size.width, cover2.size.height);
    [self addSubview:_coverImageView2];
}

/**
 *  发送验证码
 */
- (void)sendCode{
    [self.delegate sendCodeWithPhone:_phoneTextField.text];
}

/**
 *  登录
 */
- (void)login{
    [self.delegate loginWithPhone:_phoneTextField.text code:_checkCodeTextField.text];
}

/**
 *  查看使用协议
 */
- (void)protocolButtonAction{
    [self.delegate checkProtocol];
}


#pragma mark - UITextFieldDelegate
- (void)textFieldChanged:(UITextField *)textField{
    if (_phoneTextField == textField) {
        if (textField.text.length >= 11) {
            textField.text = [textField.text substringToIndex:11];
            _sendCodeButton.backgroundColor = [UIColor colorWithHexString:@"FEDA81"];
            [_sendCodeButton setTitleColor:themeBlack forState:UIControlStateNormal];
            _sendCodeButton.enabled = YES;
        }else{
            _sendCodeButton.enabled = NO;
            _sendCodeButton.backgroundColor = [UIColor colorWithHexString:@"c5c5c5"];
            [_sendCodeButton setTitleColor:themeWhite forState:UIControlStateNormal];
        }
    }else{
        if (textField.text.length >= 4) {
            textField.text = [textField.text substringToIndex:4];
        }
    }
    if (_phoneTextField.text.length == 11 && _checkCodeTextField.text.length == 4) {
        _loginButton.backgroundColor = [UIColor colorWithHexString:@"94C93A"];
        _loginButton.enabled = YES;
    }else{
        _loginButton.backgroundColor = [UIColor colorWithHexString:@"c5c5c5"];
        _loginButton.enabled = NO;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}


//点击屏幕收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_checkCodeTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
}







@end
