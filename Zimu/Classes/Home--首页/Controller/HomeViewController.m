//
//  HomeViewController.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "TestViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.hidesBottomBarWhenPushed = YES;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    self.hidesBottomBarWhenPushed = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TestViewController *vc = [[TestViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
