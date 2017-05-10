//
//  AnswerDetailViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AnswerDetailViewController.h"
#import "ConfuseAnswerDetailTableView.h"
#import "QuestionDetailApi.h"
#import "QuestionDetailModel.h"
#import "QuestionExpertAnswerApi.h"
#import "QuestionExpertAnswerModel.h"
#import "QuestionUserCommentApi.h"
#import "QuestionUserCommentModel.h"
#import "MBProgressHUD+MJ.h"

@interface AnswerDetailViewController ()

@property (nonatomic, strong) ConfuseAnswerDetailTableView *answerDetailTableView;

@end

@implementation AnswerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"问答详情";
    self.view.backgroundColor = themeWhite;
    
    [self searchQuestionDetail];
    [self getExpertAnswerData];
    [self getUserCommentData];
    
    [self setupAnswerDetailTableView];
    
    //接收通知，刷新评论列表数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserCommentData) name:@"updateCommentList" object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateCommentList" object:nil];
}


/**
 *  answerTableView
 */
- (void)setupAnswerDetailTableView{
    _answerDetailTableView = [[ConfuseAnswerDetailTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:_answerDetailTableView];
}

#pragma mark - 网络请求
//获取问题详情：标签、标题、问题内容、关注数、评论数
- (void)searchQuestionDetail{
    QuestionDetailApi *questionDetailApi = [[QuestionDetailApi alloc]initWithQuestionId:_questionId];
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
        _answerDetailTableView.questionModel = questionDeatilModel.object;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
    }];
}

- (void)getExpertAnswerData{
    QuestionExpertAnswerApi *questionExpertAnswerApi = [[QuestionExpertAnswerApi alloc]initWithQuestionId:_questionId];
    [questionExpertAnswerApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            return ;
        }
        QuestionExpertAnswerModel *questionExpertAnswerModel = [QuestionExpertAnswerModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = questionExpertAnswerModel.isTrue;
        if (!isTrue) {
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
        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
    }];
}

//获取用户评论
- (void)getUserCommentData{
    QuestionUserCommentApi *questionUserCommentApi = [[QuestionUserCommentApi alloc]initWithQuestionId:_questionId];
    [questionUserCommentApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            return ;
        }
        QuestionUserCommentModel *questionUserCommentModel = [QuestionUserCommentModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = questionUserCommentModel.isTrue;
        if (!isTrue) {
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
        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
    }];
}



@end
