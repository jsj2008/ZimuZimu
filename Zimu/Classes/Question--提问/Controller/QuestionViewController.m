//
//  QuestionViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/20.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QuestionViewController.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "UIImage+ZMExtension.h"
#import "QuestionResultTableView.h"
#import "SubmitQuestionViewController.h"
#import "MBProgressHUD+MJ.h"

@interface QuestionViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *editView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) QuestionResultTableView *questionResultTableView;
@property (nonatomic, strong) NSMutableArray *resultArray;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提问";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIColor *naviColor = [UIColor colorWithHexString:@"f5ce13"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:naviColor size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UIBarButtonItem *rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"" title:@"下一步" target:self action:@selector(nextStep)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.view.backgroundColor = themeWhite;
    
    _resultArray = [NSMutableArray array];
    [self setupEditView];
    [self setupQuestionResultTableView];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_textField resignFirstResponder];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_textField becomeFirstResponder];
}
//下一步
- (void)nextStep{
    NSLog(@"下一步");
    if (_textField.text.length == 0) {
        [MBProgressHUD showMessage_WithoutImage:@"请填写你的困惑" toView:self.view];
    }else{
        SubmitQuestionViewController *submitQuestionVC = [[SubmitQuestionViewController alloc]init];
        submitQuestionVC.questionTitle = _textField.text;
        [self.navigationController pushViewController:submitQuestionVC animated:YES];
    }
}

- (void) setupEditView{
    _editView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    [self.view addSubview:_editView];
    
    CALayer *line = [[CALayer alloc]init];
    line.frame = CGRectMake(0, _editView.height - 1, _editView.width, 1);
    line.backgroundColor = themeGray.CGColor;
    [_editView.layer addSublayer:line];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, _editView.width - 20, _editView.height - 1)];
    _textField.placeholder = @"说出你的困惑";
    _textField.textColor = [UIColor colorWithHexString:@"222222"];
    _textField.font = [UIFont systemFontOfSize:17];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _textField.delegate = self;
    [_editView addSubview:_textField];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField{
    if (textField.text.length == 0) {
        [_resultArray removeAllObjects];
    }else{
        [_resultArray addObject:textField.text];
    }
    _questionResultTableView.resultArray = _resultArray;
}

#pragma mark - 搜索结果
- (void)setupQuestionResultTableView{
    _questionResultTableView = [[QuestionResultTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_editView.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(_editView.frame) - 64) style:UITableViewStylePlain];
    [self.view addSubview:_questionResultTableView];
}








@end
