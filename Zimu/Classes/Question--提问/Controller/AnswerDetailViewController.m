//
//  AnswerDetailViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AnswerDetailViewController.h"
#import "ConfuseAnswerDetailTableView.h"

@interface AnswerDetailViewController ()

@property (nonatomic, strong) ConfuseAnswerDetailTableView *answerDetailTableView;

@end

@implementation AnswerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"问答详情";
    self.view.backgroundColor = themeWhite;
    
    [self setupAnswerDetailTableView];
}


/**
 *  answerTableView
 */
- (void)setupAnswerDetailTableView{
    _answerDetailTableView = [[ConfuseAnswerDetailTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:_answerDetailTableView];
}

@end
