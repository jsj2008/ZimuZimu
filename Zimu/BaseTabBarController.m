//
//  BaseTabBarController.m
//  Zimu
//
//  Created by Redpower on 2017/2/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BaseTabBarController.h"
#import "UMMobClick/MobClick.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildVCs];
    
}

- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne123"];//("PageOne"为页面名称，可自定义)
}

- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne123"];
}
/*
*  添加子控制器
*
*  title : 控制器tabbar标题
*  imageName  :  taabbr图片
 */
- (void)addChildViewController:(UIViewController *)viewController Title:(NSString *)title imageName:(NSString *)imageName{
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:viewController];
    viewController.title = title;
//    NSString *selectImageName = [imageName stringByAppendingString:@"_click"];
//    [viewController.tabBarItem setImage:[UIImage imageNamed:imageName]];
//    [viewController.tabBarItem setSelectedImage:[UIImage imageNamed:selectImageName]];
    
    [self addChildViewController:navi];
}

- (void)addChildVCs{
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.view.backgroundColor = [UIColor orangeColor];
    [self addChildViewController:vc1 Title:@"艾克" imageName:@""];
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:vc2 Title:@"维克托" imageName:@""];
    
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.view.backgroundColor = [UIColor orangeColor];
    [self addChildViewController:vc3 Title:@"莫甘娜" imageName:@""];
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc4.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:vc4 Title:@"维克兹" imageName:@""];
}


@end
