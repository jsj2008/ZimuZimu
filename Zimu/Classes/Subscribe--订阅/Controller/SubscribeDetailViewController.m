//
//  SubscribeDetailViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribeDetailViewController.h"
#import "SubscribeDetailLeftViewController.h"
#import "SubscribeDetailMidViewController.h"
#import "SubscribeDetailRightViewController.h"
#import "SubscribeDetailContentHeadView.h"
#import "SubscribeDetailContentScrollView.h"
#import "SubscribeLecturerDetailTableView.h"
#import "SLDBarView.h"
#import "SLDTextCellLayoutFrame.h"

#import "HomeVideoDetailViewController.h"
#import "FMViewController.h"
#import "ArticleViewController.h"

@interface SubscribeDetailViewController ()<UIScrollViewDelegate, UITableViewDelegate, SLDBarViewDelegate>

@property (nonatomic, strong) UIView *navigationView;       //自定义导航栏
@property (nonatomic, strong) UIButton *backButton;         //返回按钮
@property (nonatomic, strong) UILabel *titleLabel;          //标题

@property (nonatomic, assign) NSInteger headerImageHeight;  //头部图片高度
@property (nonatomic, assign) NSInteger titleHeight;        //标题栏高度

@property (nonatomic, strong) UIView *headerView;       //头部视图(头部图片+标题栏的底部view)
@property (nonatomic, strong) UIImageView *headImageview;  //头部图片view
@property (nonatomic, strong) SLDBarView *detailBarView;        //点击展开详情
@property (nonatomic, strong) UIView *titleView;        //标题栏
@property (nonatomic, strong) UIView *indicatorView;    //指示器
@property (nonatomic, strong) UIButton *selectButton;   //选中的标题

@property (nonatomic, assign) CGPoint contentOffset;

@property (nonatomic, strong) SubscribeDetailContentScrollView *contentScrollView;  //内容底部的scrollView
@property (nonatomic, strong) SubscribeLecturerDetailTableView *SLDTableView;   //导师信息
@property (nonatomic, strong) UIButton *restoreButton;      //还原按钮

@property (nonatomic, assign) BOOL stopDecelerating;    //停止滚动


@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *contents;

@end

@implementation SubscribeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _titleHeight = 45;
    _headerImageHeight = 200;
    _contentOffset = CGPointMake(0, 0);
    _stopDecelerating = NO;
    
    self.view.backgroundColor = themeWhite;
    
    //添加子控制器
    [self setupChildViewController];
    
    //添加头部底层view
    [self setupHeaderView];
    
    //添加导师信息tableView
    [self setupSLDTableView];
    
    //添加底部contentScrollView
    [self setupScrollView];
    
    //添加导航栏
    [self setupNavigationView];
    
    
    _titles = @[@"相关资质",@"从业背景与经验",@"适宜人群",@"最近更新"];
    _contents = @[@"清华大学心理学博士\n国家二级心理咨询师\n国家心理中心认证咨询师\n清华大学心理学博士\n国家二级心理咨询师\n国家心理中心认证咨询师",
                  @"从业经验：2011年参加亲密之旅培训并成为带领者，6年来带领婚恋情商训练20余场，时长超过500小时；2012年参加爱家《无悔今生》培训员训练成为青少年讲师，带领青少年课程、营会超过60场，受益者超过3000人；1013年参加杭州温莎教育心理咨询师系统训练，考取心理咨询师二级；之后陆续参加《绽放孩子的天赋才华》、《行为认知疗法法》、《萨提亚家庭治疗模式》、《P.E.T.父母效能训练》、《NLP心灵成长》、《完形格式塔》、《TA交互式沟通》等培训；整合应用心理学各流派知识技能\n\n培训思路：以全人成长为目标；结合中医“阴平阳秘，精神乃治”、“虚则补之，实则泻之”、“通则不痛，通则不痛”、辨证治疗等理念，综合人本主义、EFT、行为认知疗法、萨提亚家庭式治疗等技巧；帮助人不仅仅关注解决当下产生的问题，更能深入追溯疗愈原生家庭及成长经历中的未完成事件的影响，立足于当下，着眼于未来的全人成长；致力于成为无条件接纳每一个学员、愿意用心倾听和陪伴并用智慧和学员一起成长的心灵导师！",
                  @"1、教育系统（大中学生、教师）\n2、家庭教育（普通家长、孩子）\n3、企业员工训练\n4、心理咨询师、婚姻家庭咨询师",
                  @"塑造孩子的自信"];
    
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
    [_backButton setImage:[UIImage imageNamed:@"subscribe_back"] forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 30)];
    [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
}
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  添加子控制器
 */
- (void)setupChildViewController{
    //预制一个空白view做为tableView的headerView
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _titleHeight + _headerImageHeight)];
    view.backgroundColor = [UIColor clearColor];
    
    SubscribeDetailLeftViewController *leftVC = [[SubscribeDetailLeftViewController alloc]init];
    leftVC.title = @"每日看";
//    leftVC.view.backgroundColor = themeGreen;
    leftVC.tableView.tableHeaderView = view;
    leftVC.tableView.delegate = self;
    [self addChildViewController:leftVC];
    
    SubscribeDetailMidViewController *midVC = [[SubscribeDetailMidViewController alloc]init];
    midVC.title = @"连续听";
//    midVC.view.backgroundColor = themeRed;
    midVC.tableView.tableHeaderView = view;
    midVC.tableView.delegate = self;
    [self addChildViewController:midVC];
    
    SubscribeDetailRightViewController *rightVC = [[SubscribeDetailRightViewController alloc]init];
    rightVC.title = @"天天学";
//    rightVC.view.backgroundColor = themeYellow;
    rightVC.tableView.tableHeaderView = view;
    rightVC.tableView.delegate = self;
    [self addChildViewController:rightVC];
}

/**
 *  添加头部底层view
 */
- (void)setupHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _headerImageHeight + _titleHeight)];
    _headerView.backgroundColor = themeGray;
    [self.view addSubview:_headerView];
    
    //添加头部图片view
    [self setupHeadImageview];
    
    //添加标题栏
    [self setupTitleView];
}

/**
 *  设置头部图片_headImageView
 */
- (void)setupHeadImageview{
    _headImageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _headerView.width, _headerImageHeight)];
    _headImageview.image = [UIImage imageNamed:@"yiding_banner"];
    _headImageview.contentMode = UIViewContentModeScaleAspectFill;
    _headImageview.clipsToBounds = YES;
    [_headerView addSubview:self.headImageview];
    
    //导师姓名栏,点击展开导师详情
    _detailBarView = [[SLDBarView alloc]initWithFrame:CGRectMake(0, _headImageview.height - 35 - _titleView.height, kScreenWidth, 35)];
    _detailBarView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    _detailBarView.delegate = self;
    [_headerView addSubview:_detailBarView];

}
//SLDBarViewDelegate
- (void)openSLDTableView{
    [self openButtonAction];
}

/**
 *  设置标题栏
 */
- (void)setupTitleView{
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, _headerImageHeight, _headerView.width, _titleHeight)];
    _titleView.backgroundColor = themeWhite;
    [self.headerView addSubview:_titleView];
    //底部分割线
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, _titleView.height - 1, _titleView.width, 1);
    lineLayer.backgroundColor = themeGray.CGColor;
    [_titleView.layer addSublayer:lineLayer];
    
    //添加指示器
    _indicatorView = [[UIView alloc]init];
    _indicatorView.backgroundColor = themeYellow;
    _indicatorView.height = 2;
    _indicatorView.y = _titleView.height - _indicatorView.height - 2;
    
    //添加button
    NSArray *childVCs = self.childViewControllers;
    CGFloat width = _titleView.width * 0.8 / childVCs.count;
    CGFloat height = 25;
    for (int index = 0; index < childVCs.count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(width * index + _titleView.width * 0.1, (_titleView.height - height)/2.0, width, height);
        button.tag = 30 + index;
        [_titleView addSubview:button];
        
        UIViewController *vc = self.childViewControllers[index];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:themeBlack forState:UIControlStateNormal];
        [button setTitleColor:themeYellow forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置指示器,默认选中第一个标题 推荐
        if (index == 0) {
            button.enabled = NO;
            self.selectButton = button;
            [button layoutIfNeeded];
            
            _indicatorView.width = _selectButton.titleLabel.width;
            _indicatorView.centerX = _selectButton.centerX;
        }
        
    }
    [_titleView addSubview:_indicatorView];
}

/*
 选择标题，指示器匹配按钮
 */
- (void)selectTitle:(UIButton *)button{
    //先把上次的按钮设置为普通状态
    self.selectButton.enabled = YES;
    //再把当前按钮设置为不可选状态
    button.enabled = NO;
    self.selectButton = button;
    [button layoutIfNeeded];
    
    //移动指示器
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:0.3 options:
     UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
         _indicatorView.width = _selectButton.titleLabel.width;
         _indicatorView.centerX = _selectButton.centerX;
     } completion:^(BOOL finished) {
         
     }];
    
    //滑动scrollView
    NSInteger index = button.tag - 30;
    [_contentScrollView setContentOffset:CGPointMake(index * _contentScrollView.width, 0) animated:YES];
}

/**
 *  设置ScrollView
 */
- (void)setupScrollView{
    _contentScrollView = [[SubscribeDetailContentScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _contentScrollView.backgroundColor = themeWhite;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    _contentScrollView.contentSize = CGSizeMake(kScreenWidth * self.childViewControllers.count, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加子控制器的tableView    
    for (int i = 0; i < self.childViewControllers.count; i ++) {
        //将子控制器的tableView（view）添加到scrollView中
        UITableViewController *tableVC = self.childViewControllers[i];
        tableVC.view.y = 0;
        tableVC.view.height = _contentScrollView.height;
        tableVC.tableView.x = _contentScrollView.width * i;
        [_contentScrollView addSubview:tableVC.tableView];
    }
    
    [self.view insertSubview:_contentScrollView atIndex:0];

}

#pragma mark - UIScrollViewDelegate
//结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _contentScrollView){
        
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        UIButton *button = [_titleView viewWithTag:30 + index];
        [self selectTitle:button];
        [self scrollViewDidEndScrollingAnimation:scrollView];
    }else if (scrollView == _SLDTableView){
        if (_stopDecelerating) {
            [_SLDTableView setContentOffset:_SLDTableView.contentOffset animated:NO];
        }
    }
}
//结束滑动
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView == _contentScrollView){
        //计算出当前索引
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        NSLog(@"index : %li",index);
        //将子控制器的tableView（view）添加到scrollView中
        UITableViewController *tableVC = self.childViewControllers[index];
        tableVC.view.y = 0;
        tableVC.view.height = scrollView.height;
        tableVC.tableView.x = scrollView.contentOffset.x;
        [scrollView addSubview:tableVC.tableView];
    }
}
//正在滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _contentScrollView || !scrollView.window){
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat originY = 0;
    CGFloat otherOffsetY = 0;
    
    //留出64的距离预留给导航栏
    CGFloat headHeight = _headerImageHeight - 64;
    if (scrollView == _SLDTableView) {
        headHeight = _headerImageHeight + _titleHeight - 64;
    }
    if (offsetY <= headHeight){
        originY = -offsetY;
        if (offsetY <= 0){
            originY = 0;
        }
        otherOffsetY = offsetY;
    }else{
        originY = -headHeight;
        otherOffsetY = headHeight;
    }

    CGPoint offset = CGPointMake(0, otherOffsetY);
    _headerView.frame = CGRectMake(0, originY, kScreenWidth, _headerImageHeight + _titleHeight);
    if (scrollView == _SLDTableView) {
        if (_SLDTableView.contentOffset.y < _headerImageHeight + _titleHeight - 64){
            _SLDTableView.contentOffset = offset;
        }
    }else{
        for ( int i = 0; i < self.childViewControllers.count; i++ ){
            UITableView *tableView = _contentScrollView.subviews[i];
            if ([tableView isKindOfClass:[UITableView class]]){
                if (tableView.contentOffset.y < _headerImageHeight - 64 || offset.y < _headerImageHeight - 64){
                    tableView.contentOffset = offset;
                }
            }
        }
    }
    //修改导航栏透明度
    [self changeNavigationViewAlphaWithOffsetY:offset.y];
}

#pragma mark - UITableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewController *leftVC = self.childViewControllers[0];
    UITableViewController *midVC = self.childViewControllers[1];
    UITableViewController *rightVC = self.childViewControllers[2];
    if (tableView == leftVC.tableView) {
        NSLog(@"每日看 %@",indexPath);
        HomeVideoDetailViewController *videoVC = [[HomeVideoDetailViewController alloc]init];
        [self.navigationController pushViewController:videoVC animated:YES];
    }else if (tableView == midVC.tableView){
        NSLog(@"连续听 %@",indexPath);
        FMViewController *fmVC = [[FMViewController alloc]init];
        [self.navigationController pushViewController:fmVC animated:YES];
    }else if (tableView == rightVC.tableView){
        NSLog(@"天天学 %@",indexPath);
        ArticleViewController *articleVC = [[ArticleViewController alloc]init];
        articleVC.articleTitle = @"文章";
        [self.navigationController pushViewController:articleVC animated:YES];
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewController *leftVC = self.childViewControllers[0];
    UITableViewController *midVC = self.childViewControllers[1];
    UITableViewController *rightVC = self.childViewControllers[2];
    if (tableView == leftVC.tableView) {
        //左边  每日看
        if (indexPath.section == 0 && indexPath.row == 0) {
            return 35;
        }
        return 255;
    }else if (tableView == midVC.tableView) {
        //中间  连续听
        if (indexPath.section == 0 && indexPath.row == 0) {
            return 35;
        }
        return 80;
    }else if (tableView == rightVC.tableView) {
        //右边  天天学
        if (indexPath.section == 0 && indexPath.row == 0) {
            return 35;
        }
        return 210;
    }else{
        //导师信息
        SLDTextCellLayoutFrame *layout = [[SLDTextCellLayoutFrame alloc]initWithTitle:_titles[indexPath.section] TextString:_contents[indexPath.section]];
        return layout.cellHeight;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _SLDTableView) {
        return 10;
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == _SLDTableView) {
        return CGFLOAT_MIN;
    }
    return 10;
}

//改变导航栏透明度
- (void)changeNavigationViewAlphaWithOffsetY:(CGFloat)offsetY{
    CGFloat alpha = MIN(1, offsetY/(_headerImageHeight - 64.0));
    _navigationView.alpha = alpha;
    if (alpha > 0) {
        _titleLabel.hidden =  NO;
    }else{
        _titleLabel.hidden = YES;
    }
}


#pragma mark - 导师信息

/**
 *  添加导师信息tableView
 */
- (void)setupSLDTableView{
    //预制一个空白view做为tableView的headerView
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _titleHeight + _headerImageHeight)];
    view.backgroundColor = [UIColor clearColor];
    
    _SLDTableView = [[SubscribeLecturerDetailTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _SLDTableView.alpha = 0;
    _SLDTableView.delegate = self;
    _SLDTableView.hidden = YES;
    _SLDTableView.tableHeaderView = view;
    [self.view insertSubview:_SLDTableView belowSubview:_headerView];
    
    //还原按钮
    [self setupRestoreButton];
}

- (void)setupRestoreButton{
    _restoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _restoreButton.frame = CGRectMake(_detailBarView.width - 44 - 10, kScreenHeight - 44 - 50, 44, 44);
    [_restoreButton setImage:[UIImage imageNamed:@"expert_shouqi"] forState:UIControlStateNormal];
    _restoreButton.layer.cornerRadius = _restoreButton.width/2.0;
    _restoreButton.layer.masksToBounds = YES;
    _restoreButton.hidden = YES;
    [_restoreButton addTarget:self action:@selector(restoreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_restoreButton];
}

#pragma mark - 切换页面  导师信息和导师内容
- (void)openButtonAction{
    NSLog(@"打开");
    _SLDTableView.hidden = NO;
    _restoreButton.hidden = NO;
    
    [UIView animateWithDuration:0.8f animations:^{
        _SLDTableView.alpha = 1;
        _titleView.alpha = 0;
        _contentScrollView.alpha = 0;
        _detailBarView.frame = CGRectMake(15, _headerView.height - 85, kScreenWidth - 30, 85);
        [_detailBarView LSDBarTransformWithSLDBarState:SLDBarStateShadow];
        
        
        //将headView复原,_SLDTableView的contentOffset复原
        _headerView.frame = CGRectMake(0, 0, _headerView.width, _headerView.height);
        _SLDTableView.contentOffset = CGPointMake(0, 0);
        //导航栏alpha复原为0
        [self changeNavigationViewAlphaWithOffsetY:0];
        
    } completion:^(BOOL finished) {
        _titleView.hidden = YES;
        _contentScrollView.hidden = YES;
        _contentScrollView.delegate = nil;
        _contentScrollView.userInteractionEnabled = NO;
        for (UITableViewController *vc in self.childViewControllers) {
            vc.tableView.delegate = nil;
            vc.tableView.userInteractionEnabled = NO;
        }
    }];
}

- (void)restoreButtonAction{
    NSLog(@"关闭");
    _restoreButton.hidden = YES;
    _contentScrollView.hidden = NO;
    _titleView.hidden = NO;
    //停止滚动
    _stopDecelerating = YES;
    [self scrollViewDidEndDecelerating:_SLDTableView];

    [UIView animateWithDuration:0.8f animations:^{
        _titleView.alpha = 1;
        _contentScrollView.alpha = 1;
        _detailBarView.frame = CGRectMake(0, _headImageview.height - 35, kScreenWidth, 35);
        [_detailBarView LSDBarTransformWithSLDBarState:SLDBarStateNormal];
        
        _SLDTableView.alpha = 0;
        
        //将headView复原,3个tableView的contentOffset复原
        _headerView.frame = CGRectMake(0, 0, _headerView.width, _headerView.height);
        for (UITableViewController *vc in self.childViewControllers) {
            vc.tableView.delegate = self;
            vc.tableView.userInteractionEnabled = YES;;
            vc.tableView.contentOffset = CGPointMake(0, 0);
        }
        //导航栏alpha复原为0
        [self changeNavigationViewAlphaWithOffsetY:0];
        
    } completion:^(BOOL finished) {
        _stopDecelerating = NO;
        _SLDTableView.hidden = YES;
        _contentScrollView.delegate = self;
        _contentScrollView.userInteractionEnabled = YES;
        for (UITableViewController *vc in self.childViewControllers) {
            vc.tableView.delegate = self;
            vc.tableView.userInteractionEnabled = YES;;
        }
    }];
}




@end


