//
//  CourseViewController.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CourseViewController.h"
#import "HomeVideoViewController.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "SDCycleScrollView.h"


#define TITLE_HEIGHT 45
@interface CourseViewController ()



@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeNavRightBtn];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    HomeVideoViewController *dVC = [[HomeVideoViewController alloc] init];
//    [self.navigationController pushViewController:dVC animated:YES];
    
}
- (void)makeNavRightBtn{
    UIBarButtonItem *searchBtn = [UIBarButtonItem barButtonItemWithImageName:@"course_search" title:@"" target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = searchBtn;
}
- (void)search{
    NSLog(@"234");
    
}

@end
