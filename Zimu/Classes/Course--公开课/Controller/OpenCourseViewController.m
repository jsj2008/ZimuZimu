//
//  OpenCourseViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "OpenCourseViewController.h"
#import "OpenCourseTableView.h"
#import "SDCycleScrollView.h"
#import "UIImage+ZMExtension.h"

@interface OpenCourseViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) OpenCourseTableView *openCourseTableView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation OpenCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"公开课程";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIColor *naviColor = [UIColor colorWithHexString:@"f5ce13"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:naviColor size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.view.backgroundColor = themeWhite;
    
    [self setupOpenCourseTableView];
}

- (void)setupOpenCourseTableView{
    _openCourseTableView = [[OpenCourseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:_openCourseTableView];
    
    NSMutableArray *imageUrlArray = [NSMutableArray array];
    for (int index = 1; index < 5; index++) {
        NSString *url = [NSString stringWithFormat:@"cycle_0%i.jpg",index];
        [imageUrlArray addObject:url];
    }
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, _openCourseTableView.width, 150) imageNamesGroup:imageUrlArray];
    _cycleScrollView.delegate = self;
    _cycleScrollView.titlesGroup = @[@"免费 | 怎样的沟通方式，不会伤害到孩子孩子孩子",@"最新 | 怎样的沟通方式，不会伤害到孩子孩子孩子",@"免费 | 怎样的沟通方式，不会伤害到孩子孩子孩子",@"最新 | 怎样的沟通方式，不会伤害到孩子孩子孩子"];
//    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
//    _cycleScrollView.pageControlRightOffset = 10; 
//    _cycleScrollView.pageControlBottomOffset = 20;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    _cycleScrollView.pageControlDotSize = CGSizeMake(2, 2);
    _openCourseTableView.tableHeaderView = _cycleScrollView;
    
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"index : %li",index);
}




@end
