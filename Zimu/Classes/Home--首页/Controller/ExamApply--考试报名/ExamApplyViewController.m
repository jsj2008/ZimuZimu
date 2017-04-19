//
//  ExamApplyViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExamApplyViewController.h"
#import "ExamApplyTableView.h"

@interface ExamApplyViewController ()

@property (nonatomic, strong) ExamApplyTableView *examApplyTableView;

@end

@implementation ExamApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"考试报名";
    self.view.backgroundColor = themeGray;
    
    [self setupExamApplyTableView];
}


/**
 *  examApplyTableView
 */
- (void)setupExamApplyTableView{
    _examApplyTableView = [[ExamApplyTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:_examApplyTableView];
}


@end
