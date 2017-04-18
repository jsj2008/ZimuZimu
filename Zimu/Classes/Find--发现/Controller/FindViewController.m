//
//  FindViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindViewController.h"
#import "UIImage+ZMExtension.h"

@interface FindViewController ()

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeWhite;
    self.title = @"发现更多";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:themeYellow size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}




@end
