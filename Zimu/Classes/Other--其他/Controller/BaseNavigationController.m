//
//  BaseNavigationController.m
//  Demo
//
//  Created by Redpower on 2017/2/15.
//  Copyright © 2017年 Redpower. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIBarButtonItem+ZMExtension.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setShadowImage:[UIImage new]];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
}

//修改返回按钮后，会导致pop手势失效，需重新实现
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count > 1;
}


//push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //判断是否为栈底控制器，若为栈底则不设置
    if (self.childViewControllers.count > 0) {
        //push的时候隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
        //自定义左上角pop返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemWithImageName:@"navigationButtonReturn" title:@"" target:self action:@selector(back)];
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)back{
    [self popViewControllerAnimated:YES];
}



@end
