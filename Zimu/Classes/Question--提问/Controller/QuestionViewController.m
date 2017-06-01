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
#import "SearchQuestionApi.h"
#import "SearchQuestionModel.h"

@interface QuestionViewController ()<UITextFieldDelegate, QuestionResultTableViewDelegate>

@property (nonatomic, strong) UIView *editView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) QuestionResultTableView *questionResultTableView;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提问";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIColor *naviColor = [UIColor colorWithHexString:@"f5ce13"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:naviColor size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
//    UIBarButtonItem *rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"" title:@"搜索" target:self action:@selector(searchQuestion)];
//    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.view.backgroundColor = themeWhite;
    
    
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_textField != nil && _textField.text.length > 0) {
        [self searchQuestionWithTitle:_textField.text];
    }
}

//- (void)searchQuestion{
//    NSLog(@"搜索");
//}

- (void)setupEditView{
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
        _questionResultTableView.hidden = YES;
    }else{
        [self searchQuestionWithTitle:textField.text];
    }
}


#pragma mark - 搜索结果
- (void)setupQuestionResultTableView{
    _questionResultTableView = [[QuestionResultTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_editView.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(_editView.frame) - 64) style:UITableViewStylePlain];
    _questionResultTableView.scrollDelegate = self;
    _questionResultTableView.hidden = YES;
    [self.view addSubview:_questionResultTableView];
}
//QuestionResultTableViewDelegate    滚动时收起键盘
- (void)questionResultTableViewDidScroll{
    [_textField resignFirstResponder];
}


#pragma mark - 网络请求
- (void)searchQuestionWithTitle:(NSString *)questionTitle{
    SearchQuestionApi *searchQuestionApi = [[SearchQuestionApi alloc]initWithQuestionTitle:questionTitle];
    [searchQuestionApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            return ;
        }
        SearchQuestionModel *searchQuestionModel = [SearchQuestionModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = searchQuestionModel.isTrue;
        if (!isTrue) {
            return;
        }
        NSArray *questionResultModelArray = searchQuestionModel.items;
        if (!questionResultModelArray.count) {
            //数据库没数据
            _questionResultTableView.hidden = YES;
            return;
        }
        _questionResultTableView.hidden = NO;
        NSMutableArray *resultModelArray = [NSMutableArray arrayWithCapacity:questionResultModelArray.count];
        for (int i = 0; i < questionResultModelArray.count; i++) {
            NSDictionary *modelDic = questionResultModelArray[i];
            SearchQuestionResultModel *resultModel = [SearchQuestionResultModel yy_modelWithDictionary:modelDic];
            [resultModelArray addObject:resultModel];
        }
        _questionResultTableView.resultArray = resultModelArray;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
    }];
}






@end
