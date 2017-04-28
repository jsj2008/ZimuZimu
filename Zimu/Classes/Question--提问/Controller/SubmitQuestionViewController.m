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

@interface SubmitQuestionViewController ()<ConfuseDetailViewDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) ConfuseDetailView *confuseDetailView;
@property (nonatomic, strong) TagView *tagsView;

@end

@implementation SubmitQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeWhite;
    
    UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"" title:@"取消" target:self action:@selector(quit)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"" title:@"提交" target:self action:@selector(submit)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    [self setupContentScrollView];
}

//取消
- (void)quit{
    [self.navigationController popViewControllerAnimated:YES];
}
//提交
- (void)submit{
    if (!_confuseDetailView.confuseString.length) {
        [MBProgressHUD showMessage_WithoutImage:@"请填写您的困扰" toView:self.view];
        return;
    }
    if (!_tagsView.tagTextArray.count) {
        [MBProgressHUD showMessage_WithoutImage:@"请选择标签" toView:self.view];
        return;
    }
    NSLog(@"提交 %@ \n %@",_confuseDetailView.confuseString, _tagsView.tagTextArray);
    [MBProgressHUD showMessage_WithoutImage:@"已提交您的困惑,请耐心等待专家回答" toView:self.view];
    [self performSelector:@selector(jumpToAnswerVC) withObject:nil afterDelay:0.5];
}
- (void)jumpToAnswerVC{    
    AnswerViewController *answerVC = [[AnswerViewController alloc]init];
    [self.navigationController pushViewController:answerVC animated:YES];
}


/**
 *  contentScrollView
 */
- (void)setupContentScrollView{
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    _contentScrollView.contentSize = CGSizeMake(0, kScreenHeight - 64);
    _contentScrollView.backgroundColor = themeGray;
    [self.view addSubview:_contentScrollView];
    
    [self setupTitleView];
    [self setupTagsView];
    [self setupConfuseDeatilView];
}



/**
 *  titleView
 */
- (void) setupTitleView{
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    _titleView.backgroundColor = themeWhite;
    [_contentScrollView addSubview:_titleView];
    
    CALayer *line = [[CALayer alloc]init];
    line.frame = CGRectMake(0, _titleView.height - 1, _titleView.width, 1);
    line.backgroundColor = themeGray.CGColor;
    [_titleView.layer addSublayer:line];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, _titleView.width - 20, _titleView.height - 1)];
    _textField.text = [NSString stringWithFormat:@"标题：%@",_questionTitle];
    _textField.textColor = [UIColor colorWithHexString:@"222222"];
    _textField.font = [UIFont systemFontOfSize:16];
    _textField.userInteractionEnabled = NO;
    [_titleView addSubview:_textField];
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
    _confuseDetailView = [[ConfuseDetailView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_tagsView.frame) + 10, kScreenWidth, kScreenHeight - CGRectGetMaxY(_tagsView.frame) - 10 - 64)];
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




@end
