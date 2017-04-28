//
//  AnswerViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/20.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerTableView.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "QuestionViewController.h"

@interface AnswerViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) AnswerTableView *answerTableView;

@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"问答详情";
    self.view.backgroundColor = themeWhite;
    
    UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationButtonReturn" title:@"" target:self action:@selector(return)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    [self setupAnswerTableView];
    
    //关闭左划返回手势
    if ([_previousVC isEqualToString:NSStringFromClass([QuestionViewController class])]) {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    
}

- (void)return{
    
    
    NSArray *vcs = self.navigationController.viewControllers;
    
    NSInteger index = 1;
    for (UIViewController *viewController in vcs) {
        if([viewController isKindOfClass:[QuestionViewController class]]){
            index = [vcs indexOfObject:viewController];
            break;
        }
    }
    
    [self.navigationController popToViewController:vcs[index] animated:YES];
}


/**
 *  answerTableView
 */
- (void)setupAnswerTableView{
    _answerTableView = [[AnswerTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:_answerTableView];
}







@end
