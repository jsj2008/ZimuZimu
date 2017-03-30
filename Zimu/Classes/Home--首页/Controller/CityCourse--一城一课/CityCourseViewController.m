//
//  CityCourseViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/29.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CityCourseViewController.h"
#import "CityCourseTableView.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "SegmentView.h"

@interface CityCourseViewController ()

@property (nonatomic, strong) SegmentView *segmentView;
@property (nonatomic, strong) CityCourseTableView *cityCourseTableView;

@end

@implementation CityCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"一城一课";
    self.view.backgroundColor = themeGray;
    
    //搜索按钮
    UIBarButtonItem *searchBarButton = [UIBarButtonItem barButtonItemWithImageName:@"course_searchicon" title:@"" target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem = searchBarButton;
    
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.cityCourseTableView];
    
}

//搜索
- (void)searchAction{
    NSLog(@"搜索");
}

/**
 *  segmentView
 */
- (UIView *)segmentView{
    if (!_segmentView) {
        _segmentView = [[SegmentView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 42)];
        _segmentView.backgroundColor = themeWhite;
    }
    return _segmentView;
}


/**
 *  cityCourseTableView
 */
- (CityCourseTableView *)cityCourseTableView{
    if (!_cityCourseTableView) {
        _cityCourseTableView = [[CityCourseTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentView.frame), kScreenWidth, kScreenHeight - 42 - 64) style:UITableViewStylePlain];
        
    }
    return _cityCourseTableView;
}



@end
