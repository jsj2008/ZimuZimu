//
//  FeedBackViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FeedBackViewController.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "MBProgressHUD+MJ.h"
#import "UIImage+ZMExtension.h"
#import "AddFeedbackApi.h"
#import "DeviceMessageModel.h"

@interface FeedBackViewController ()<UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UITextField *textFiled;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeGray;
    self.title = @"意见反馈";
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    
    [self setupTextView];
    [self setupTextField];
    
    //提交按钮
    UIBarButtonItem *rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"" title:@"提交" target:self action:@selector(submitFeedBack)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//提交反馈
- (void)submitFeedBack{
    if (_textView.text.length == 0) {
        [MBProgressHUD showMessage_WithoutImage:@"请填写您的反馈意见" toView:self.view];
    }else{
        if (_textFiled.text.length == 0) {
            [MBProgressHUD showMessage_WithoutImage:@"请留下您的联系方式" toView:self.view];
        }else{
            [self addFeedbackNetWorkApply];
            NSLog(@"%@  %@",_textView.text, _textFiled.text);
        }
    }
}


/**
 *  textView
 */
- (void)setupTextView{
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 180)];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:13];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.textColor = [UIColor colorWithHexString:@"333333"];
    _textView.backgroundColor = themeWhite;
    [self.view addSubview:_textView];
    
    //用一个label来代替placeholder
    _placeholderLabel = [[UILabel alloc]init];
    _placeholderLabel.textColor = [UIColor lightGrayColor];
    _placeholderLabel.numberOfLines = 0;
    NSString *holderString = @"告诉我们你的不满之处，有机会获得我们的小礼品哦！";
    UIFont *holderFont = [UIFont systemFontOfSize:13];
    _placeholderLabel.text = holderString;
    _placeholderLabel.font = holderFont;
    CGSize holderSize = [holderString sizeWithAttributes:@{NSFontAttributeName:holderFont}];
    _placeholderLabel.frame = CGRectMake(5, 7, _textView.frame.size.width - 10, holderSize.height);
    [_textView addSubview:_placeholderLabel];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length != 0) {
        _placeholderLabel.hidden = YES;
    }else{
        _placeholderLabel.hidden = NO;
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


/**
 *  textField
 */
- (void)setupTextField{
    _textFiled = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_textView.frame) + 10, kScreenWidth - 20, 40)];
    _textFiled.backgroundColor = themeWhite;
    _textFiled.delegate = self;
    _textFiled.placeholder = @"手机号或邮箱，以便发放反馈奖励";
    _textFiled.font = [UIFont systemFontOfSize:14];
    _textFiled.textColor = [UIColor colorWithHexString:@"333333"];
    _textFiled.returnKeyType = UIReturnKeyDone;
    _textFiled.clearsOnBeginEditing = YES;
    
    [self.view addSubview:_textFiled];
    //设置textField左边距
    CGRect frame = _textView.frame;
    frame.size.width = 5;
    UIView *leftView = [[UIView alloc]initWithFrame:frame];
    leftView.backgroundColor = [UIColor clearColor];
    _textFiled.leftViewMode = UITextFieldViewModeAlways;
    _textFiled.leftView = leftView;

}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - 提交反馈意见
- (void)addFeedbackNetWorkApply{
    AddFeedbackApi *addfeedBackApi = [[AddFeedbackApi alloc]initWithPhone:_textFiled.text feedbackVal:_textView.text systemName:[DeviceMessageModel GetSystemName] systemVersion:[DeviceMessageModel GetSystemVersion] deviceModel:[DeviceMessageModel GetCurrentDeviceModel] appVersion:[DeviceMessageModel GetAPPVersion]];
    
    [addfeedBackApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"数据提交失败" toView:self.view];
            return;
        }
        [MBProgressHUD showSuccess:@"反馈提交成功" toView:nil];
        [self performSelector:@selector(back) withObject:nil afterDelay:0.5];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"网络错误，请稍后再试" toView:self.view];
    }];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
