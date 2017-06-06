//
//  SubmitQuestionViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/20.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubmitQuestionViewController.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "MBProgressHUD+MJ.h"
#import "AnswerViewController.h"
#import "InsertQuestionApi.h"
#import "UIImage+ZMExtension.h"
#import "QuestionViewController.h"
#import "NewLoginViewController.h"
#import "GetQuestionLabelApi.h"
#import "QuestionTagModel.h"

#import "NewQuestionTitleView.h"
#import "NewTagView.h"
#import "NewConfuseTextView.h"
#import "SubmitCompleteViewController.h"

#import "ZMBlankView.h"

@interface SubmitQuestionViewController ()<NewConfuseTextViewDelegate, NewQuestionTitleViewDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, copy) NSString *questionId;       //提交成功后得到的问题ID

@property (nonatomic, strong) NewQuestionTitleView *titleView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NewConfuseTextView *confuseDetailView;
@property (nonatomic, strong) NewTagView *tagsView;

@property (nonatomic, strong) UIButton *submitButton;       //提交按钮

@end

@implementation SubmitQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"提问";
    self.view.backgroundColor = themeWhite;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"subscribe_back" title:@"" target:self action:@selector(quit)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"question_search" title:@"" target:self action:@selector(searchQuestion)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    [self setupContentScrollView];
    [self setupSubmitButton];
    [self getTagsData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"F5CD13"] size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

//取消
- (void)quit{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出提问？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:cancelAction];
    [alert addAction:sureAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

//搜索
- (void)searchQuestion{
    NSLog(@"搜索");
    QuestionViewController *questionVC = [[QuestionViewController alloc]init];
    [self.navigationController pushViewController:questionVC animated:YES];
}


#pragma mark - 提交数据
- (void)submitDataToSever{
    InsertQuestionApi *insertQuestionApi = [[InsertQuestionApi alloc]initWithQuestionTitle:_titleView.textField.text keyWord:_tagsView.tagText questionVal:_confuseDetailView.confuseString];
//    NSLog(@"title : %@ keyWord : %@ confuseString : %@", _questionTitle, _tagsView.tagText, _confuseDetailView.confuseString);
    [insertQuestionApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
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
            [self performSelector:@selector(gotoLogin) withObject:nil afterDelay:1.0];
            return;
        }
        [MBProgressHUD showMessage_WithoutImage:@"已提交您的困惑,请耐心等待专家回答" toView:self.view];
        NSDictionary *object = dataDic[@"object"];
        _questionId = object[@"questionId"];
        [self performSelector:@selector(jumpToAnswerVC) withObject:nil afterDelay:0.5];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"提交失败，请稍后再试" toView:self.view];
    }];
}

- (void)jumpToAnswerVC{    
    SubmitCompleteViewController *submitCompleteVC = [[SubmitCompleteViewController alloc]init];
    submitCompleteVC.questionTitle = _titleView.textField.text;
    [self.navigationController pushViewController:submitCompleteVC animated:YES];
}

/**
 *  提交按钮
 */
- (void)setupSubmitButton{
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitButton.frame = CGRectMake(40, kScreenHeight - 60 - 45 - 64, kScreenWidth - 80, 45);
    [_submitButton setBackgroundColor:[UIColor colorWithHexString:@"A0E232"]];
    _submitButton.layer.cornerRadius = _submitButton.height/2.0;
    _submitButton.layer.masksToBounds = YES;
    [_submitButton setTitle:@"提交问题" forState:UIControlStateNormal];
    [_submitButton setTitleColor:themeWhite forState:UIControlStateNormal];
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitButton];
}

//提交
- (void)submit{
    if (!_titleView.textField.text.length) {
        [MBProgressHUD showMessage_WithoutImage:@"请填写问题标题" toView:self.view];
        return;
    }
    if (!_confuseDetailView.confuseString.length) {
        [MBProgressHUD showMessage_WithoutImage:@"请填写您的困扰" toView:self.view];
        return;
    }
    if (!_tagsView.tagText.length) {
        [MBProgressHUD showMessage_WithoutImage:@"请选择标签" toView:self.view];
        return;
    }
    
    [self submitDataToSever];
}



/**
 *  contentScrollView
 */
- (void)setupContentScrollView{
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    _contentScrollView.contentSize = CGSizeMake(0, kScreenHeight - 64);
    _contentScrollView.backgroundColor = themeWhite;
    [self.view addSubview:_contentScrollView];
    
    [self setupTitleView];
    [self setupTagsView];
    [self setupConfuseDeatilView];
}



/**
 *  titleView
 */
- (void) setupTitleView{
    //标题
    _titleView = [[NewQuestionTitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
    _titleView.delegate = self;
    [_contentScrollView addSubview:_titleView];
}


/**
 *  tagsView
 */
- (void)setupTagsView{
    _tagsView = [[NewTagView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), kScreenWidth, 140)];
    _tagsView.backgroundColor = themeWhite;
    [_contentScrollView addSubview:_tagsView];
}


/**
 *  confuseDetailView
 */
- (void)setupConfuseDeatilView{
    _confuseDetailView = [[NewConfuseTextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_tagsView.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(_tagsView.frame) - 10 - 64)];
    _confuseDetailView.delegate = self;
    [_contentScrollView addSubview:_confuseDetailView];
}

#pragma mark -  NewQuestionTitleViewDelegate : 监听键盘高度
- (void)newQuestionTitleViewKeyboardWillShow:(CGFloat)keyboardHeight{
    [UIView animateWithDuration:0.25 animations:^{
        _contentScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - keyboardHeight - 70);
        _contentScrollView.contentSize = CGSizeMake(0, kScreenHeight - 64);
    }];
}
- (void)newQuestionTitleViewKeyboardWillhide:(CGFloat)keyboardHeight{
    [UIView animateWithDuration:0.45 animations:^{
        _contentScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);
        _contentScrollView.contentSize = CGSizeMake(0, kScreenHeight - 64);
        [_contentScrollView scrollsToTop];
    }];
}

#pragma mark -  NewConfuseTextViewDelegate : 监听键盘高度
- (void)newConfuseTextViewKeyboardWillShow:(CGFloat)keyboardHeight{
    [UIView animateWithDuration:0.25 animations:^{
        _contentScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - keyboardHeight - 70);
        _contentScrollView.contentSize = CGSizeMake(0, kScreenHeight - 64);
        [_contentScrollView setContentOffset:CGPointMake(0, keyboardHeight - 50) animated:YES];
    }];
}
- (void)newConfuseTextViewKeyboardWillhide:(CGFloat)keyboardHeight{
    [UIView animateWithDuration:0.45 animations:^{
        _contentScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);
        _contentScrollView.contentSize = CGSizeMake(0, kScreenHeight - 64);
        [_contentScrollView scrollsToTop];
    }];
}

#pragma mark - 去登陆
- (void)gotoLogin{
    NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
    [self presentViewController:newLoginVC animated:YES completion:nil];
}


#pragma mark - 获取便签数据
- (void)getTagsData{
    GetQuestionLabelApi *getQuestionLabelApi = [[GetQuestionLabelApi alloc]init];
    [getQuestionLabelApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [self noData];
//            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [self noData];
//            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:self.view];
            return;
        }
        NSArray *dataArray = dataDic[@"items"];
        if (dataArray.count && dataArray) {
            NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:dataArray.count];
            for (NSDictionary *dic in dataArray) {
                QuestionTagModel *tagModel = [QuestionTagModel yy_modelWithDictionary:dic];
                [modelArray addObject:tagModel];
            }
            _tagsView.tagModelArray = modelArray;
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
            [self netTimeOut];
            
        }
        //其他原因
        else {
            [self netLostServer];
            
        }
    }];
}

#pragma mark - 空白页
- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoData afterClickDestory:NO btnClick:^(ZMBlankView *blView) {
        [self getTagsData];
    }];
    [self.view addSubview:blankview];
}

- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getTagsData];
    }];
    [self.view addSubview:blankview];
}

- (void)netTimeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getTagsData];
    }];
    [self.view addSubview:blankview];
}

- (void)netLostServer{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getTagsData];
    }];
    [self.view addSubview:blankview];
}


@end
