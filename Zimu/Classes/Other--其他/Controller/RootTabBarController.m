//
//  RootTabBarController.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "RootTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "ConsultViewController.h"
#import "CourseViewController.h"
#import "FindViewController.h"
#import "MineViewController.h"
#import "UIImage+ZMExtension.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self addChildVCs];
    
    //设置tabbar背景图
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    
}

/*
 *  添加子控制器
 *
 *  title : 控制器tabbar标题
 *  imageName  :  taabbr图片
 */
- (void)setupChildViewController:(UIViewController *)viewController Title:(NSString *)title imageName:(NSString *)imageName{
    
    BaseNavigationController *navi = [[BaseNavigationController alloc]initWithRootViewController:viewController];
    viewController.title = title;
    
    NSString *selectImageName = [imageName stringByAppendingString:@"_click"];
    [viewController.tabBarItem setImage:[UIImage imageNamed:imageName]];
    UIImage *selectImage = [UIImage originalImageWithImageName:selectImageName];
    [viewController.tabBarItem setSelectedImage:selectImage];
    
    [self addChildViewController:navi];
}

- (void)addChildVCs{
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    [self setupChildViewController:homeVC Title:@"首页" imageName:@"tabBar_essence_icon"];
    
    ConsultViewController *consultVC = [[ConsultViewController alloc]init];
    [self setupChildViewController:consultVC Title:@"咨询" imageName:@"tabBar_new_icon"];
    
    CourseViewController *courseVC = [[CourseViewController alloc]init];
    [self setupChildViewController:courseVC Title:@"课程" imageName:@"tabBar_me_icon"];
    
    FindViewController *findVC = [[FindViewController alloc]init];
    [self setupChildViewController:findVC Title:@"发现" imageName:@"tabBar_find_icon"];
    
    MineViewController *mineVC = [[MineViewController alloc]init];
    [self setupChildViewController:mineVC Title:@"我的" imageName:@"tabBar_friendTrends_icon"];
}



@end
