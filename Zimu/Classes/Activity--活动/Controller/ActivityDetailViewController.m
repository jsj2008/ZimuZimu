//
//  ActivityDetailViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityDetailTableView.h"
#import <MJRefresh.h>
#import <WebKit/WebKit.h>
#import "ActivityTimeTableViewController.h"
#import "GetAppOfflineCourseByIdApi.h"
#import "MBProgressHUD+MJ.h"
#import "ActivityCategoryInfoModel.h"
#import "UIView+SnailUse.h"
#import "PaymentChannelView.h"
#import "SnailQuickMaskPopups.h"
#import "GetAppOfflineCourseByCourseIdApi.h"
#import "ActivityCourseModel.h"
#import "PaymentInfoModel.h"
#import "NewLoginViewController.h"
#import "ActivityOrderCompleteViewController.h"
#import "NewLoginViewController.h"

@interface ActivityDetailViewController ()<UIWebViewDelegate, ActivityDetailTableViewDelegate, ActivityTimeTableViewControllerDelegate, PaymentChannelViewDelegate, ActivityOrderCompleteViewControllerDelegate>

@property (nonatomic, strong) ActivityDetailTableView *activityDetailTableView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *applyButton;        //立即报名
@property (nonatomic, assign) BOOL hasSelectAddress;        //是否已选择活动地址

@property (nonatomic, strong) SnailQuickMaskPopups *popup;
@property (nonatomic, copy) NSString *addressString;        //课程地址
@property (nonatomic, copy) NSString *timeString;           //课程时间
@property (nonatomic, copy) NSString *courseId;             //课程ID
@property (nonatomic, strong) PaymentChannelView *paymentChannelView;


@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _titleString;
    self.view.backgroundColor = themeGray;
    
    [self setupActivityDetailTableView];
    [self setupWebView];
    [self setupApplyButton];
    
    _hasSelectAddress = NO;
    [self getCategoryActivityData];
    
}
- (void)dealloc{
    //在页面消失时，解除代理，加载空网页，停止加载，清空缓存，释放webview
    //销毁的时候别忘移除监听
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    _webView.delegate = nil;
    [_webView loadHTMLString:@"" baseURL:nil];
    [_webView stopLoading];
    [_webView removeFromSuperview];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    _webView = nil;
    
}


#pragma mark - 创建一键报名按钮
- (void)setupApplyButton{
    _applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _applyButton.frame = CGRectMake(0, kScreenHeight - 64 - 49, kScreenWidth, 49);
    [_applyButton setBackgroundColor:themeYellow];
    [_applyButton setTitle:@"立即报名" forState:UIControlStateNormal];
    [_applyButton setTitleColor:themeWhite forState:UIControlStateNormal];
    _applyButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_applyButton addTarget:self action:@selector(applyActivity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_applyButton];
}
//立即报名
- (void)applyActivity{
    
//    ActivityOrderCompleteViewController *orderCompleteVC = [[ActivityOrderCompleteViewController alloc]init];
//    orderCompleteVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    orderCompleteVC.orderCompleteDelegate = self;
//    orderCompleteVC.result = @"success";
//    orderCompleteVC.courseId = _courseId;
//    [self presentViewController:orderCompleteVC animated:YES completion:nil];
    
    if (_hasSelectAddress) {
        //判断是否已登录
        if ([userToken isEqualToString:@"logout"] || userToken == nil) {
            //去登录
            NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
            [self presentViewController:newLoginVC animated:YES completion:nil];
        }else{
            NSArray *textArray = [_addressString componentsSeparatedByString:@" "];
            NSDictionary *modelDic = @{@"title":_titleString,
                                       @"courseId":_courseId,
                                       @"price":_coursePrice,
                                       @"time":textArray[2],
                                       @"address":textArray[0]};
            PaymentInfoModel *paymentInfoModel = [PaymentInfoModel yy_modelWithDictionary:modelDic];
            _paymentChannelView = [UIView paymentChannelView];
            _paymentChannelView.delegate = self;
            _paymentChannelView.paymentInfoModel = paymentInfoModel;
            _popup = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:_paymentChannelView];
            _popup.isAllowPopupsDrag = YES;
            _popup.dampingRatio = 0.9;
            _popup.presentationStyle = PresentationStyleBottom;
            [_popup presentAnimated:YES completion:nil];
        }
    }else{
        [_activityDetailTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [MBProgressHUD showMessage_WithoutImage:@"请先选择课程" toView:nil];
    }
}

#pragma mark - 创建activityDetailTableView
- (void)setupActivityDetailTableView{
    _activityDetailTableView = [[ActivityDetailTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
    _activityDetailTableView.detailDelegate = self;
    [self.view addSubview:_activityDetailTableView];
}

//ActivityDetailTableViewDelegate
- (void)activityDetailTableViewDidSelect{
    ActivityTimeTableViewController *activityTimeTableVC = [[ActivityTimeTableViewController alloc]init];
    activityTimeTableVC.delegate = self;
    activityTimeTableVC.categoryId = _categoryId;
    [self.navigationController pushViewController:activityTimeTableVC animated:YES];
}
//ActivityTimeTableViewControllerDelegate
- (void)activityTimeTableViewControllerDidSelectAddress:(NSString *)address courseId:(NSString *)courseId{
    _activityDetailTableView.isSelectAddress = YES;
    [self getAppOfflineCourseDetailDataWithCourseId:courseId];       //获取活动具体数据
    
    self.hasSelectAddress = YES;
    _addressString = address;
    _courseId = courseId;
    _activityDetailTableView.addressString = address;
    NSLog(@"address : %@, courseId : %@",address, courseId);
}

#pragma mark - webView图文详情
- (void)setupWebView{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _webView.backgroundColor = themeGray;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    
    int cacheSizeMemory = 1*1024*1024;
    int cacheSizeDisk = 5*1024*1024;
    
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:sharedCache];
    
    _webView.delegate = self;
    NSString *prefixURL = @"http://www.zimu365.com/zimu_portal_demo/html/happiness_onferenct/new_happy.html";
    if ([_titleString isEqualToString:@"亲子共学团"]) {
        prefixURL = @"http://www.zimu365.com/zimu_portal_demo/html/one_city_lesson/group.html";
    }
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:prefixURL]]];
    
    self.activityDetailTableView.tableFooterView = _webView;
    
    //使用kvo为webView添加监听，监听webView的内容高度
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

//实时改变webView的控件高度，使其高度跟内容高度一致
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGRect frame = self.webView.frame;
        frame.size.height = self.webView.scrollView.contentSize.height;
        self.webView.frame = frame;
                
        self.activityDetailTableView.tableFooterView = self.webView;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//图片缓存
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - 获取该类别活动数据详情
- (void)getCategoryActivityData{
    GetAppOfflineCourseByIdApi *getAppOfflineCourseByIdApi = [[GetAppOfflineCourseByIdApi alloc]initWithCategoryId:_categoryId];
    [getAppOfflineCourseByIdApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"暂无数据" toView:self.view];
            return;
        }
        ActivityCategoryInfoModel *activityCategoryInfoModel = [ActivityCategoryInfoModel yy_modelWithDictionary:dataDic[@"object"]];
        _activityDetailTableView.activityCategoryInfoModel = activityCategoryInfoModel;
        _activityDetailTableView.coursePrice = _coursePrice;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"暂无数据" toView:self.view];
    }];
}


#pragma mark - 获取具体活动数据
- (void)getAppOfflineCourseDetailDataWithCourseId:(NSString *)courseId{
    GetAppOfflineCourseByCourseIdApi *getAppOfflineCourseByCourseIdApi = [[GetAppOfflineCourseByCourseIdApi alloc]initWithCourseId:courseId];
    [getAppOfflineCourseByCourseIdApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"暂无数据" toView:self.view];
            return;
        }
        ActivityCourseModel *model = [ActivityCourseModel yy_modelWithDictionary:dataDic[@"object"]];
        _activityDetailTableView.activityCourseModel = model;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"获取该活动数据失败" toView:self.view];
    }];
}


#pragma mark - PaymentChannelViewDelegate
- (void)paymentViewFinishPayWithResult:(NSString *)result payOrderModel:(PayOrderModel *)payOrderModel{
//    if ([result isEqualToString:@"fail"]) {
//        result = @"支付失败";
//    }else if ([result isEqualToString:@"success"]){
//        result = @"支付成功";
//    }else if ([result isEqualToString:@"cancel"]){
//        result = @"取消支付";
//    }
    
    [_popup dismissAnimated:YES completion:^(SnailQuickMaskPopups * _Nonnull popups) {
        ActivityOrderCompleteViewController *orderCompleteVC = [[ActivityOrderCompleteViewController alloc]init];
        orderCompleteVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        orderCompleteVC.orderCompleteDelegate = self;
        orderCompleteVC.result = result;
        orderCompleteVC.courseId = _courseId;
        orderCompleteVC.payOrderModel = payOrderModel;
        
        [self presentViewController:orderCompleteVC animated:YES completion:nil];
    }];
}

- (void)loginFailed{
    [_popup dismissAnimated:YES completion:^(SnailQuickMaskPopups * _Nonnull popups) {
        [self login];
    }];
}

- (void)login{
    NewLoginViewController *loginVC = [[NewLoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

#pragma mark - ActivityOrderCompleteViewControllerDelegate 重新支付
- (void)payAgainWithPayOrderModel:(PayOrderModel *)payOrderModel{
    [self applyActivityWithPayOrderModel:payOrderModel];
}

//重新报名
- (void)applyActivityWithPayOrderModel:(PayOrderModel *)payOrderModel{

    if (_hasSelectAddress) {
        //判断是否已登录
        if ([userToken isEqualToString:@"logout"] || userToken == nil) {
            //去登录
            NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
            [self presentViewController:newLoginVC animated:YES completion:nil];
        }else{
            NSArray *textArray = [_addressString componentsSeparatedByString:@" "];
            NSDictionary *modelDic = @{@"title":_titleString,
                                       @"courseId":_courseId,
                                       @"price":_coursePrice,
                                       @"time":textArray[2],
                                       @"address":textArray[0]};
            PaymentInfoModel *paymentInfoModel = [PaymentInfoModel yy_modelWithDictionary:modelDic];
            _paymentChannelView = [UIView paymentChannelView];
            _paymentChannelView.delegate = self;
            _paymentChannelView.paymentInfoModel = paymentInfoModel;
            _paymentChannelView.payOrderModel = payOrderModel;              //区别在于这里，重新提交才会有
            _popup = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:_paymentChannelView];
            _popup.isAllowPopupsDrag = YES;
            _popup.dampingRatio = 0.9;
            _popup.presentationStyle = PresentationStyleBottom;
            [_popup presentAnimated:YES completion:nil];
        }
    }else{
        [_activityDetailTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [MBProgressHUD showMessage_WithoutImage:@"请先选择课程" toView:nil];
    }
}



@end
