//
//  SubmitCompleteViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubmitCompleteViewController.h"
#import "UIImage+ZMExtension.h"
#import "SubmitCompleteTableView.h"
#import "SearchQuestionApi.h"
#import "MBProgressHUD+MJ.h"
#import "SearchQuestionModel.h"
#import "BaseNavigationController.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "HomeViewController.h"
#import "ZMBlankView.h"

@interface SubmitCompleteViewController ()

@property (nonatomic, strong) UIView *successView;
@property (nonatomic, strong) SubmitCompleteTableView *submitCompleteTableView;

@end

@implementation SubmitCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布成功";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"F5CD13"] size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupSubmitCompleteTableView];
    [self searchQuestionWithTitle:_questionTitle];
    
    UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationButtonReturn" title:@"" target:self action:@selector(returnBack)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    BaseNavigationController *baseNavi = (BaseNavigationController *)self.navigationController;
    baseNavi.panGestureRec.enabled = NO;
}

- (void)returnBack{
    
    NSArray *vcs = self.navigationController.viewControllers;
    
    NSInteger index = 1;
    for (UIViewController *viewController in vcs) {
        if([viewController isKindOfClass:[HomeViewController class]]){
            index = [vcs indexOfObject:viewController];
            break;
        }
    }
    
    [self.navigationController popToViewController:vcs[index] animated:YES];
    BaseNavigationController *baseNavi = (BaseNavigationController *)self.navigationController;
    baseNavi.panGestureRec.enabled = YES;
}



/**
 *  submitCompleteTableView
 */
- (void)setupSubmitCompleteTableView{
    _submitCompleteTableView = [[SubmitCompleteTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:_submitCompleteTableView];
}


//获取类似问题
- (void)searchQuestionWithTitle:(NSString *)questionTitle{
    SearchQuestionApi *searchQuestionApi = [[SearchQuestionApi alloc]initWithQuestionTitle:questionTitle];
    [searchQuestionApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [self noData];
            return ;
        }
        SearchQuestionModel *searchQuestionModel = [SearchQuestionModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = searchQuestionModel.isTrue;
        if (!isTrue) {
            [self noData];
            return;
        }
        NSArray *dataArray = searchQuestionModel.items;
        if (dataArray.count != 0 && dataArray != nil) {
            NSMutableArray *resultModelArray = [NSMutableArray arrayWithCapacity:dataArray.count];
            for (int i = 0; i < dataArray.count; i++) {
                NSDictionary *modelDic = dataArray[i];
                SearchQuestionResultModel *resultModel = [SearchQuestionResultModel yy_modelWithDictionary:modelDic];
                [resultModelArray addObject:resultModel];
            }
            _submitCompleteTableView.resultArray = resultModelArray;
        }else{
            [self noData];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSError *error = request.error;
        NSInteger errorCode = error.code;
        NSLog(@"errorcode : %li",errorCode);
        if (errorCode == -1009) {
            [self noNet];
            
        }
        //请求超时
        else if (errorCode == -1001) {
            
            
        }
        //其他原因
        else {
            
            
        }
    }];
}

#pragma mark - 空白页
- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoData afterClickDestory:NO btnClick:^(ZMBlankView *blView) {
        [self searchQuestionWithTitle:_questionTitle];
    }];
    [self.view addSubview:blankview];
}

- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self searchQuestionWithTitle:_questionTitle];
    }];
    [self.view addSubview:blankview];
}


@end
