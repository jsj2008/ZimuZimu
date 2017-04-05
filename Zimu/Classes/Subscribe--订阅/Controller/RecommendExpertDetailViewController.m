//
//  RecommendExpertDetailViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "RecommendExpertDetailViewController.h"
#import "SubscribeLecturerDetailTableView.h"
#import "SLDBarView.h"
#import "SLDTextCellLayoutFrame.h"
#import "SubscribeFreeReadViewController.h"

@interface RecommendExpertDetailViewController ()<UITableViewDelegate>

@property (nonatomic, strong) UIView *navigationView;       //自定义导航栏
@property (nonatomic, strong) UIButton *backButton;         //返回按钮
@property (nonatomic, strong) UILabel *titleLabel;          //标题

@property (nonatomic, strong) UIView *headerView;       //头部视图(头部图片+标题栏的底部view)
@property (nonatomic, strong) UIImageView *headImageview;  //头部图片view
@property (nonatomic, strong) SLDBarView *detailBarView;        //点击展开详情

@property (nonatomic, strong) SubscribeLecturerDetailTableView *SLDTableView;

@property (nonatomic, assign) CGFloat headerHeight;     //headerView高度

@property (nonatomic, strong) UIView *bottomView;       //底部订阅按钮的底层view

@end

@implementation RecommendExpertDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeWhite;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _headerHeight = 245;
    
    //添加导航栏
    [self setupNavigationView];
    
    //添加tableView
    [self setupSLDTableView];
    
    [self setupBottomView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

/**
 *  添加导航栏
 */
- (void)setupNavigationView{
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _navigationView.alpha = 0;
    _navigationView.backgroundColor = themeWhite;
    [self.view addSubview:_navigationView];
    
    //分割线
    CALayer *line = [[CALayer alloc]init];
    line.frame = CGRectMake(0, _navigationView.height - 1, _navigationView.width, 1);
    line.backgroundColor = themeGray.CGColor;
    [_navigationView.layer addSublayer:line];
    
    //标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 200)/2.0, 20, 200, 44)];
    _titleLabel.text = @"吴东辉";
    _titleLabel.textColor = themeBlack;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.hidden = YES;
    [self.view addSubview:_titleLabel];
    
    //返回按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(0, 20, 64, 44);
    [_backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 30)];
    [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
}
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 *  设置头部图片_headView
 */
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _headerHeight)];
        _headerView.backgroundColor = themeGray;
        
        _headImageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _headerView.width, _headerHeight - 45)];
        _headImageview.image = [UIImage imageNamed:@"yiding_banner"];
        _headImageview.contentMode = UIViewContentModeScaleAspectFill;
        _headImageview.clipsToBounds = YES;
        [_headerView addSubview:self.headImageview];
        
        //导师姓名栏,点击展开导师详情
        _detailBarView = [[SLDBarView alloc]initWithFrame:CGRectMake(15, _headerView.height - 85, kScreenWidth - 30, 85)];
        _detailBarView.backgroundColor = themeWhite;
        [_detailBarView LSDBarTransformWithSLDBarState:SLDBarStateShadow];
        [_headerView addSubview:_detailBarView];
    }
    
    return _headerView;
}


/**
 *  添加导师信息tableView
 */
- (void)setupSLDTableView{
    _SLDTableView = [[SubscribeLecturerDetailTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50) style:UITableViewStylePlain];
    _SLDTableView.delegate = self;
    _SLDTableView.tableHeaderView = self.headerView;
    [self.view insertSubview:_SLDTableView belowSubview:_navigationView];

}

//UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SLDTextCellLayoutFrame *layout = [[SLDTextCellLayoutFrame alloc]init];
    return layout.cellHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        _titleLabel.hidden = NO;
    }else{
        _titleLabel.hidden = YES;
    }
    CGFloat alpha = MIN(_headerHeight - 64, offsetY) / (_headerHeight - 64);
    _navigationView.alpha = alpha;
    
    if (offsetY < 0) {
        //计算图片放大倍数：scale = 拉动后的高度 / 原始高度
        CGFloat scale = (_headerHeight - 45 - offsetY) / (_headerHeight - 45);
        //设置图片变换的transform
        CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
        //对图片视图进行缩放变换
        _headImageview.transform = transform;
        //缩放完毕后，对图片的位置进行调整
        //水平位置
        _headImageview.center = CGPointMake(kScreenWidth / 2.0, 0);
        //竖直位置
        _headImageview.top = offsetY;
    }else{
        //松手后还原
        _headImageview.transform = CGAffineTransformIdentity;
    }
    
}


/**
 *  免费试读、订阅按钮底部的bottomView
 */
- (void)setupBottomView{
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    _bottomView.backgroundColor = themeGray;
    [self.view addSubview:_bottomView];
    
    //免费试读按钮
    UIButton *freeReadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    freeReadButton.frame = CGRectMake(15, 5, (kScreenWidth - 45)/2.0, 40);
    [freeReadButton setTitle:@"免费试读" forState:UIControlStateNormal];
    [freeReadButton setBackgroundColor:themeWhite];
    [freeReadButton setTitleColor:themeBlack forState:UIControlStateNormal];
    freeReadButton.titleLabel.font = [UIFont systemFontOfSize:14];
    freeReadButton.layer.cornerRadius = 5;
    freeReadButton.layer.masksToBounds = YES;
    [freeReadButton addTarget:self action:@selector(freeReadAction) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:freeReadButton];
    
    //订阅按钮
    UIButton *subscribeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    subscribeButton.frame = CGRectMake(CGRectGetMaxX(freeReadButton.frame) + 15, 5, (kScreenWidth - 45)/2.0, 40);
    [subscribeButton setTitle:@"订阅：￥1.00" forState:UIControlStateNormal];
    [subscribeButton setBackgroundColor:themeYellow];
    [subscribeButton setTitleColor:themeWhite forState:UIControlStateNormal];
    subscribeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    subscribeButton.layer.cornerRadius = 5;
    subscribeButton.layer.masksToBounds = YES;
    [subscribeButton addTarget:self action:@selector(subscribeAction) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:subscribeButton];
}
//免费试读
- (void)freeReadAction{
    SubscribeFreeReadViewController *subsFreeVC = [[SubscribeFreeReadViewController alloc] init];
    [self.navigationController pushViewController:subsFreeVC animated:YES];
    NSLog(@"免费试读");
}
//订阅
- (void)subscribeAction{
    NSLog(@"订阅：￥1.00");
}


@end
