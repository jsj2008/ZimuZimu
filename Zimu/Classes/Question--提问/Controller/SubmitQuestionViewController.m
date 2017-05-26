//
//  SubmitQuestionViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/20.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubmitQuestionViewController.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "ConfuseDetailView.h"
#import "TagView.h"
#import "MBProgressHUD+MJ.h"
#import "AnswerViewController.h"
#import "InsertQuestionApi.h"
#import "UIImage+ZMExtension.h"
#import "QuestionTitleView.h"
#import "QuestionViewController.h"
#import "NewLoginViewController.h"

@interface SubmitQuestionViewController ()<ConfuseDetailViewDelegate, QuestionTitleViewDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) QuestionTitleView *titleView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) ConfuseDetailView *confuseDetailView;
@property (nonatomic, strong) TagView *tagsView;
@property (nonatomic, copy) NSString *questionId;       //提交成功后得到的问题ID

@end

@implementation SubmitQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提问";
    self.view.backgroundColor = themeWhite;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIColor *naviColor = [UIColor colorWithHexString:@"f5ce13"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:naviColor size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"" title:@"取消" target:self action:@selector(quit)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"" title:@"搜索" target:self action:@selector(searchQuestion)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    [self setupContentScrollView];
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
    InsertQuestionApi *insertQuestionApi = [[InsertQuestionApi alloc]initWithQuestionTitle:_questionTitle keyWord:_tagsView.tagText questionVal:_confuseDetailView.confuseString];
    NSLog(@"title : %@ keyWord : %@ confuseString : %@", _questionTitle, _tagsView.tagText, _confuseDetailView.confuseString);
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
    AnswerViewController *answerVC = [[AnswerViewController alloc]init];
    answerVC.previousVC = NSStringFromClass([self class]);
    answerVC.questionID = _questionId;
    [self.navigationController pushViewController:answerVC animated:YES];
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
    _titleView = [[QuestionTitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    _titleView.backgroundColor = themeWhite;
    _titleView.delegate = self;
    [_contentScrollView addSubview:_titleView];
}
#pragma mark - QuestionTitleViewDelegate
- (void)submitQuestion{
    _questionTitle = _titleView.textField.text;
    if (!_questionTitle.length) {
        [MBProgressHUD showMessage_WithoutImage:@"请填写标题" toView:self.view];
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
 *  tagsView
 */
- (void)setupTagsView{
    _tagsView = [[TagView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), kScreenWidth, 100)];
    _tagsView.backgroundColor = themeWhite;
    [_contentScrollView addSubview:_tagsView];
}


/**
 *  confuseDetailView
 */
- (void)setupConfuseDeatilView{
    _confuseDetailView = [[ConfuseDetailView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_tagsView.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(_tagsView.frame) - 10 - 64)];
    _confuseDetailView.delegate = self;
    [_contentScrollView addSubview:_confuseDetailView];
}


#pragma mark -  ConfuseDetailViewDelegate : 监听键盘高度
- (void)keyboardWillShow:(CGFloat)keyboardHeight{
    [UIView animateWithDuration:0.25 animations:^{
        _contentScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - keyboardHeight - 70);
    }];
}
- (void)keyboardWillhide:(CGFloat)keyboardHeight{
    [UIView animateWithDuration:0.45 animations:^{
        _contentScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);
    }];
}

#pragma mark - 去登陆
- (void)gotoLogin{
    NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
    [self presentViewController:newLoginVC animated:YES completion:nil];
}






@end
