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
#import "BaseNavigationController.h"

#import "QuestionDetailApi.h"       //问题详情：标签、标题、问题内容、关注数、评论数
#import "QuestionDetailModel.h"

#import "MBProgressHUD+MJ.h"

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
    
    [self searchQuestionDetail];
    [self setupAnswerTableView];
    
    //关闭左划返回手势
    if ([_previousVC isEqualToString:@"SubmitQuestionViewController"]) {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
        BaseNavigationController *baseNavi = (BaseNavigationController *)self.navigationController;
        baseNavi.panGestureRec.enabled = NO;
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
    BaseNavigationController *baseNavi = (BaseNavigationController *)self.navigationController;
    baseNavi.panGestureRec.enabled = YES;
}


/**
 *  answerTableView
 */
- (void)setupAnswerTableView{
    _answerTableView = [[AnswerTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:_answerTableView];
}


#pragma mark - 网络请求
//获取问题详情：标签、标题、问题内容、关注数、评论数
- (void)searchQuestionDetail{
    QuestionDetailApi *questionDetailApi = [[QuestionDetailApi alloc]initWithQuestionId:_questionID];
    [questionDetailApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            return ;
        }
        QuestionDetailModel *questionDeatilModel = [QuestionDetailModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = questionDeatilModel.isTrue;
        if (!isTrue) {
            return;
        }
        NSLog(@"questionDeatilModel : %@",questionDeatilModel);
        _answerTableView.questionModel = questionDeatilModel.object;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
    }];
}




@end
