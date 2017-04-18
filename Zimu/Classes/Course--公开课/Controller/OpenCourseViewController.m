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

@interface OpenCourseViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) OpenCourseTableView *openCourseTableView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation OpenCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"公开课程";
    self.view.backgroundColor = themeGray;
    
    [self setupOpenCourseTableView];
}

- (void)setupOpenCourseTableView{
    _openCourseTableView = [[OpenCourseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:_openCourseTableView];
    
    NSMutableArray *imageUrlArray = [NSMutableArray array];
    for (int index = 1; index < 9; index++) {
        NSString *url = [NSString stringWithFormat:@"cycle_0%i.jpg",index];
        [imageUrlArray addObject:url];
    }
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, _openCourseTableView.width, 150) imageNamesGroup:imageUrlArray];
    _cycleScrollView.delegate = self;
    _openCourseTableView.tableHeaderView = _cycleScrollView;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"index : %li",index);
}




@end
