//
//  LoginViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController{
    NSString *_phone;          //登录的电话号码
    NSString *_checkCode;      //验证码
    NSInteger _timeCount;            //倒计时计数
    NSTimer *_timer;            //倒计时定时器
    BOOL _isCountDowning;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTextFieldDelegate];
    _timeCount = 60;
}

//设置两个textfield的代理
- (void)setUpTextFieldDelegate{
    //初始化页面的用户操作
    _loginBtn.userInteractionEnabled = NO;
    _checkNumBtn.userInteractionEnabled = NO;
    _checkNumBtn.layer.cornerRadius = 4;
    
    //设置代理
    _phoneTextField.delegate = self;
    _checkNumTextField.delegate = self;
    //设置输入框的监控方法
    [_phoneTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_checkNumTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}
#pragma mark - 输入框代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldChanged:(UITextField *)textField{
    if (_phoneTextField == textField) {
        if (textField.text.length >= 11) {
            _checkNumBtn.backgroundColor = [UIColor colorWithHexString:@"f0861d"];
            textField.text = [textField.text substringToIndex:11];
            _checkNumBtn.userInteractionEnabled = YES;
        }else{
            _checkNumBtn.backgroundColor = [UIColor colorWithHexString:@"999999"];
        }
    }else{
        if (textField.text.length >= 4) {
            textField.text = [textField.text substringToIndex:4];
        }
    }
    if (_phoneTextField.text.length == 11 && _checkNumTextField.text.length == 4) {
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"f0861d"];
        _loginBtn.userInteractionEnabled = YES;
    }else{
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"999999"];
        _loginBtn.userInteractionEnabled = NO;
    }
}
//点击屏幕收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_checkNumTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 按钮点击事件
//获取验证码，如果手机号不对则不获取
- (IBAction)checkBtnAction:(UIButton *)sender {
    if (_phoneTextField.text.length != 11) {
        
    }else{
        [self getCheckCode];
        _phone = _phoneTextField.text;
        [_checkNumTextField becomeFirstResponder];
    }
}
- (IBAction)loginBtnAction:(UIButton *)sender {
    if (_phone.length == 11 && _checkNumTextField.text.length ==  4) {
        [self login];
        [_checkNumTextField resignFirstResponder];
    }
}
#pragma mark - 三方登录
- (IBAction)qqLogin:(id)sender {

}
- (IBAction)weixinLogin:(id)sender {
    
}
- (IBAction)weiboLogin:(id)sender {
    
}

#pragma mark - 网络请求
- (void)getCheckCode{
    NSLog(@"获取验证码");
    
    [self startTimer];
}

- (void)login{
    NSLog(@"登录");
}

#pragma mark - 定时器
- (void)startTimer{
    [_checkNumBtn setTitle:[NSString stringWithFormat:@"60秒"] forState:UIControlStateNormal];
    _checkNumBtn.layer.cornerRadius = 4;
    _checkNumBtn.layer.borderColor = themeGray.CGColor;
    [_checkNumBtn setTitleColor:themeGray forState:UIControlStateNormal];
    _checkNumBtn.layer.borderWidth = 1;
    _checkNumBtn.userInteractionEnabled = NO;
    
//    [psw becomeFirstResponder];
//    [self getCheckCode];
    [NSTimer scheduledTimerWithTimeInterval:1   //调用时间间隔
                                     target:self   //方法的执行者
                                   selector:@selector(timer:)   //方法选择器
                                   userInfo:@"abnc"     //参数
                                    repeats:YES]; //是否循环调用

}
- (void)timer:(NSTimer *)timer{
    _isCountDowning = YES;
    _timeCount --;
    [_checkNumBtn setTitle:[NSString stringWithFormat:@"%li秒", _timeCount] forState:UIControlStateNormal];
    [_checkNumBtn setTitleColor:themeWhite forState:UIControlStateNormal];
    _checkNumBtn.userInteractionEnabled = NO;
    
    if (_timeCount == 0) {
        _isCountDowning = NO;
        _timeCount = 60;
        [timer invalidate];
        timer = nil;
        
        _checkNumBtn.userInteractionEnabled = YES;
        _checkNumBtn.backgroundColor = [UIColor colorWithHexString:@"f0861d"];
        [_checkNumBtn setTitle:@" 发送验证码 " forState:UIControlStateNormal];
        [_checkNumBtn setTitleColor:themeWhite forState:UIControlStateNormal];
        _checkNumBtn.layer.borderWidth = 1;
        
        if (_phoneTextField.text.length == 11) {
            [_checkNumBtn setTitleColor:themeWhite forState:UIControlStateNormal];
            _checkNumBtn.layer.borderWidth = 1;
            _checkNumBtn.userInteractionEnabled = YES;
        }else{
            _checkNumBtn.userInteractionEnabled = NO;
        }
    }

}
@end
