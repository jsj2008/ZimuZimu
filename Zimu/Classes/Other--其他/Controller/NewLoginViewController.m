//
//  NewLoginViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "NewLoginViewController.h"
#import "LoginView.h"
#import "GetSMsApi.h"
#import "LoginApi.h"
#import "MBProgressHUD+MJ.h"
#import "UserModel.h"

@interface NewLoginViewController ()<LoginViewDelegate>{
    NSInteger _timeCount;            //倒计时计数
    NSTimer *_timer;            //倒计时定时器
    BOOL _isCountDowning;
    
}

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) LoginView *loginView;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation NewLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBGImageView];
    [self setupLoginView];
    [self setupBackButton];
    _timeCount = 60;
}

/**
 *  backButton
 */
- (void)setupBackButton{
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(0, 0, 60, 60);
    [_backButton setImage:[UIImage imageNamed:@"setting_back"] forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(30, 20, 10, 20)];
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
}


/**
 *  bgImageView
 */
- (void)setupBGImageView{
    _bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_bg"]];
    _bgImageView.frame = self.view.bounds;
    [self.view addSubview:_bgImageView];
}

/**
 *  loginView
 */
- (void)setupLoginView{
    _loginView = [[LoginView alloc]initWithFrame:self.view.bounds];
    _loginView.delegate = self;
    [self.view addSubview:_loginView];
}

#pragma mark - LoginViewDelegate
/*登录*/
- (void)loginWithPhone:(NSString *)phone code:(NSString *)code{
    NSLog(@"登录  手机号 %@  验证码 %@",phone, code);
    
    LoginApi *login = [[LoginApi alloc] initWithPhoneNo:phone checkCode:code];
    
    [login startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSData *data = request.responseData;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", dic);
        NSInteger isTure = [dic[@"isTrue"] integerValue];
        if (isTure) {
            [MBProgressHUD showMessage_WithoutImage:@"登录成功" toView:self.view];
            UserModel *userModel = [UserModel yy_modelWithDictionary:dic[@"object"]];
            //存储用户userToken
            [[NSUserDefaults standardUserDefaults] setObject:userModel.token forKey:@"userToken"];
            
            if ([self.delegate respondsToSelector:@selector(loginSuccess)]) {
                [self.delegate loginSuccess];
            }
            
            [self performSelector:@selector(back) withObject:nil afterDelay:1.0f];
        }else{
            [MBProgressHUD showMessage_WithoutImage:@"登录失败，请检查您的网络" toView:self.view];
            if ([self.delegate respondsToSelector:@selector(loginFailed)]) {
                [self.delegate loginFailed];
            }
        }
        
    } failure:^(YTKBaseRequest *request) {
        [MBProgressHUD showMessage_WithoutImage:@"登录失败，请检查您的网络" toView:self.view];
        if ([self.delegate respondsToSelector:@selector(loginFailed)]) {
            [self.delegate loginFailed];
        }
    }];
    
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*发送验证码*/
- (void)sendCodeWithPhone:(NSString *)phone{
    NSLog(@"发送验证码 %@",phone);
    
    GetSMsApi *getSMS = [[GetSMsApi alloc] initWithPhoneNo:phone];
    
    [getSMS startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSData *data = request.responseData;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", dic);
        NSInteger isTure = [dic[@"isTrue"] integerValue];
        if (isTure) {
            [MBProgressHUD showMessage_WithoutImage:@"验证码发送成功" toView:self.view];
        }else{
            [MBProgressHUD showMessage_WithoutImage:@"验证码发送失败，请检查您的网络" toView:self.view];
        }
        
    } failure:^(YTKBaseRequest *request) {
        NSLog(@"网络出错，请稍后再试");
        [MBProgressHUD showMessage_WithoutImage:@"验证码发送失败，请检查您的网络" toView:self.view];
    }];
    
    
    [self startTimer];
}

/*查看协议*/
- (void)checkProtocol{
    NSLog(@"查看协议");
}


#pragma mark - 定时器
- (void)startTimer{
    [_loginView.sendCodeButton setTitle:[NSString stringWithFormat:@"60秒"] forState:UIControlStateNormal];
    _loginView.sendCodeButton.enabled = NO;

    [NSTimer scheduledTimerWithTimeInterval:1   //调用时间间隔
                                     target:self   //方法的执行者
                                   selector:@selector(timer:)   //方法选择器
                                   userInfo:@"abnc"     //参数
                                    repeats:YES]; //是否循环调用
    
}
- (void)timer:(NSTimer *)timer{
    _isCountDowning = YES;
    _timeCount --;
    [_loginView.sendCodeButton setTitle:[NSString stringWithFormat:@"%li秒", _timeCount] forState:UIControlStateNormal];
    _loginView.sendCodeButton.enabled = NO;
    
    if (_timeCount == 0) {
        _isCountDowning = NO;
        _timeCount = 60;
        [timer invalidate];
        timer = nil;
        
        _loginView.sendCodeButton.enabled = YES;
        [_loginView.sendCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];

    }
    
}


@end
