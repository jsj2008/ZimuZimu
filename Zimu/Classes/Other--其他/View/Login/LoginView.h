//
//  LoginView.h
//  Zimu
//
//  Created by Redpower on 2017/4/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

/*登录：手机号 + 验证码*/
- (void)loginWithPhone:(NSString *)phone code:(NSString *)code;

/*查看协议*/
- (void)checkProtocol;

/*发送验证码*/
- (void)sendCodeWithPhone:(NSString *)phone;


@end

@interface LoginView : UIView

@property (nonatomic, assign) id<LoginViewDelegate> delegate;


@property (nonatomic, strong) UIButton *sendCodeButton;
@property (nonatomic, strong) UITextField *phoneTextField;


@end
