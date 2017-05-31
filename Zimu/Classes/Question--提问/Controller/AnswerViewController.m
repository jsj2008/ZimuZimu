//
//  AnswerViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/20.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerTableView.h"
#import "ConfuseAnswerDetailTableView.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "QuestionViewController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "NewLoginViewController.h"

#import "SearchQuestionApi.h"
#import "SearchQuestionModel.h"
#import "QuestionDetailApi.h"       //问题详情：标签、标题、问题内容、关注数、评论数
#import "QuestionDetailModel.h"
#import "QuestionExpertAnswerApi.h"
#import "QuestionExpertAnswerModel.h"
#import "QuestionUserCommentApi.h"
#import "QuestionUserCommentModel.h"
#import "QueryWhetherCareApi.h"
#import "CareStateModel.h"
#import "InsertCommentApi.h"
#import "CommentBar.h"
#import "UIView+SnailUse.h"

#import "MBProgressHUD+MJ.h"

@interface AnswerViewController ()<UINavigationControllerDelegate, CommentBarDelegate>

@property (nonatomic, strong) AnswerTableView *answerTableView;     //未解答
@property (nonatomic, strong) ConfuseAnswerDetailTableView *answerDetailTableView;  //已解答
@property (nonatomic, strong) CommentBar *commentBar;       //评论栏

@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"问答详情";
    self.view.backgroundColor = themeWhite;
    
    UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationButtonReturn" title:@"" target:self action:@selector(return)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
//    [self searchQuestionDetail];
    
    //关闭左划返回手势
    if ([_previousVC isEqualToString:@"SubmitQuestionViewController"]) {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
        BaseNavigationController *baseNavi = (BaseNavigationController *)self.navigationController;
        baseNavi.panGestureRec.enabled = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self searchQuestionDetail];
}

- (void)return{
    
    if ([_previousVC isEqualToString:@"SubmitQuestionViewController"]) {
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
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


/**
 *  未解答且无评论 answerTableView
 */
- (void)setupAnswerTableView{
    _answerTableView = [[AnswerTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
    [self.view addSubview:_answerTableView];
}

/**
 *  已解答或已有评论 answerTableView
 */
- (void)setupAnswerDetailTableView{
    _answerDetailTableView = [[ConfuseAnswerDetailTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
    [self.view addSubview:_answerDetailTableView];
}

/**
 *  评论栏
 */
- (void)setupCommentBar{
    _commentBar = [UIView commentBar];
    _commentBar.delegate = self;
    _commentBar.collectButtonHide = YES;
    [self.view addSubview:_commentBar];
}

#pragma mark - CommentBarDelegate
//分享
- (void)commentBarShare{
    
}
//收藏
- (void)commentBarSelect:(UIButton *)button{
}
//评论
- (void)commentBarComment{
    [_answerDetailTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
//发表评论
- (void)commentBarSubmit:(NSString *)text{
    //判断是否登录
    if ([userToken isEqualToString:@"logout"] || userToken == nil) {
        //去登录
        [self login];
    }else{
        //发表评论
        [self insertComment:text];
    }
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
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return ;
        }
        QuestionDetailModel *questionDeatilModel = [QuestionDetailModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = questionDeatilModel.isTrue;
        if (!isTrue) {
            return;
        }
        
        NSLog(@"questionDeatilModel : %@",questionDeatilModel);
        QuestionModel *questionModel = questionDeatilModel.object;
        NSInteger commentCount = [questionModel.count integerValue];
        if (!commentCount) {
            //没评论过
            [self setupAnswerTableView];
            _answerTableView.questionModel = questionModel;
            //获取类似问题
            [self searchQuestionWithTitle:questionModel.questionTitle];
        }else{
            //评论过
            [self setupAnswerDetailTableView];
            _answerDetailTableView.questionModel = questionModel;
            //获取专家评论数据
            [self getExpertAnswerData];
            //获取用户评论数据
            [self getUserCommentData];
        }
        if ([userToken isEqualToString:@"logout"] || userToken == nil) {
            [self login];
        }else{
            //查询用户是否已关注该问题
            [self checkWeatherCareQuestion];
        }
        //评论栏
        [self setupCommentBar];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
    }];
}

//检查用户是否已关注该问题
- (void)checkWeatherCareQuestion{
    QueryWhetherCareApi *queryWhetherCareApi = [[QueryWhetherCareApi alloc]initWithQuestionId:_questionID];
    [queryWhetherCareApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:nil];
            return;
        }
        CareStateModel *careStateModel = [CareStateModel yy_modelWithDictionary:dataDic[@"object"]];
        NSInteger careState = [careStateModel.status integerValue];
        _answerDetailTableView.careState = careState;
        _answerTableView.careState = careState;
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
    }];
}



//获取类似问题
- (void)searchQuestionWithTitle:(NSString *)questionTitle{
    SearchQuestionApi *searchQuestionApi = [[SearchQuestionApi alloc]initWithQuestionTitle:questionTitle];
    [searchQuestionApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return ;
        }
        SearchQuestionModel *searchQuestionModel = [SearchQuestionModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = searchQuestionModel.isTrue;
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
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
            _answerTableView.resultArray = resultModelArray;
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
    }];
}

//获取专家评论
- (void)getExpertAnswerData{
    QuestionExpertAnswerApi *questionExpertAnswerApi = [[QuestionExpertAnswerApi alloc]initWithQuestionId:_questionID];
    [questionExpertAnswerApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return ;
        }
        QuestionExpertAnswerModel *questionExpertAnswerModel = [QuestionExpertAnswerModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = questionExpertAnswerModel.isTrue;
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return;
        }
        NSArray *dataArray = questionExpertAnswerModel.items;
        NSMutableArray *expertAnswerModelArray = [NSMutableArray arrayWithCapacity:dataArray.count];
        for (int i = 0; i < dataArray.count; i++) {
            NSDictionary *dic = dataArray[i];
            ExpertAnswerModel *model = [ExpertAnswerModel yy_modelWithDictionary:dic];
            [expertAnswerModelArray addObject:model];
        }
        _answerDetailTableView.expertAnswerModelArray = expertAnswerModelArray;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
    }];
}

//获取用户评论
- (void)getUserCommentData{
    QuestionUserCommentApi *questionUserCommentApi = [[QuestionUserCommentApi alloc]initWithQuestionId:_questionID];
    [questionUserCommentApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return ;
        }
        QuestionUserCommentModel *questionUserCommentModel = [QuestionUserCommentModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = questionUserCommentModel.isTrue;
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return;
        }
        NSArray *dataArray = questionUserCommentModel.items;
        NSMutableArray *userCommentModelArray = [NSMutableArray arrayWithCapacity:dataArray.count];
        for (int i = 0; i < dataArray.count; i++) {
            NSDictionary *dic = dataArray[i];
            UserCommentModel *model = [UserCommentModel yy_modelWithDictionary:dic];
            [userCommentModelArray addObject:model];
        }
        _answerDetailTableView.userCommentModelArray = userCommentModelArray;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
    }];
}

#pragma mark - 提交评论
- (void)insertComment:(NSString *)text{
    InsertCommentApi *insertCommentApi = [[InsertCommentApi alloc]initWithCommentVal:text questionId:_questionID];
    [insertCommentApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"提交失败，请稍后再试" toView:self.view];
            return ;
        }
        NSLog(@"dataDic : %@",dataDic);
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
            return;
        }
        [MBProgressHUD showMessage_WithoutImage:@"发表成功" toView:self.view];
        _commentBar.textField.text = @"";
        [_commentBar.textField resignFirstResponder];
        [self getUserCommentData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"提交失败，请稍后再试" toView:self.view];
    }];
}

#pragma mark - 重新登录
- (void)login{
    //未登录，跳转至登录页
    NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
    [self presentViewController:newLoginVC animated:YES completion:nil];
}




@end
