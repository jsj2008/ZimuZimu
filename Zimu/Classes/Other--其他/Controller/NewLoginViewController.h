//
//  NewLoginViewController.h
//  Zimu
//
//  Created by Redpower on 2017/4/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate <NSObject>

/*登录成功*/
- (void)loginSuccess;

/*登录失败*/
- (void)loginFailed;

@end

@interface NewLoginViewController : UIViewController

@property (nonatomic, assign) id<LoginViewControllerDelegate> delegate;

@end
