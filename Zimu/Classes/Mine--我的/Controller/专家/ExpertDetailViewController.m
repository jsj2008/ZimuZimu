//
//  ExpertDetailViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExpertDetailViewController.h"
#import "SubscribeLecturerDetailTableView.h"
#import "SLDBarView.h"
#import "SLDTextCellLayoutFrame.h"
#import "PaymentChannelView.h"
#import "UIView+SnailUse.h"
#import "SnailQuickMaskPopups.h"

@interface ExpertDetailViewController ()<UITableViewDelegate>

@property (nonatomic, strong) UIView *navigationView;       //自定义导航栏
@property (nonatomic, strong) UIButton *backButton;         //返回按钮
@property (nonatomic, strong) UILabel *titleLabel;          //标题

@property (nonatomic, strong) UIView *headerView;       //头部视图(头部图片+标题栏的底部view)
@property (nonatomic, strong) UIImageView *headImageview;  //头部图片view
@property (nonatomic, strong) SLDBarView *detailBarView;        //点击展开详情

@property (nonatomic, strong) SubscribeLecturerDetailTableView *SLDTableView;

@property (nonatomic, assign) CGFloat headerHeight;     //headerView高度

@property (nonatomic, strong) UIView *bottomView;       //底部订阅按钮的底层view

@property (nonatomic, strong) SnailQuickMaskPopups *popup;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *contents;

@end

@implementation ExpertDetailViewController

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
    
    
    _titles = @[@"相关资质",@"从业背景与经验",@"适宜人群",@"最近更新"];
    _contents = @[@"清华大学心理学博士\n国家二级心理咨询师\n国家心理中心认证咨询师\n清华大学心理学博士\n国家二级心理咨询师\n国家心理中心认证咨询师",
                  @"从业经验：2011年参加亲密之旅培训并成为带领者，6年来带领婚恋情商训练20余场，时长超过500小时；2012年参加爱家《无悔今生》培训员训练成为青少年讲师，带领青少年课程、营会超过60场，受益者超过3000人；1013年参加杭州温莎教育心理咨询师系统训练，考取心理咨询师二级；之后陆续参加《绽放孩子的天赋才华》、《行为认知疗法法》、《萨提亚家庭治疗模式》、《P.E.T.父母效能训练》、《NLP心灵成长》、《完形格式塔》、《TA交互式沟通》等培训；整合应用心理学各流派知识技能\n\n培训思路：以全人成长为目标；结合中医“阴平阳秘，精神乃治”、“虚则补之，实则泻之”、“通则不痛，通则不痛”、辨证治疗等理念，综合人本主义、EFT、行为认知疗法、萨提亚家庭式治疗等技巧；帮助人不仅仅关注解决当下产生的问题，更能深入追溯疗愈原生家庭及成长经历中的未完成事件的影响，立足于当下，着眼于未来的全人成长；致力于成为无条件接纳每一个学员、愿意用心倾听和陪伴并用智慧和学员一起成长的心灵导师！",
                  @"1、教育系统（大中学生、教师）\n2、家庭教育（普通家长、孩子）\n3、企业员工训练\n4、心理咨询师、婚姻家庭咨询师",
                  @"塑造孩子的自信"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    _SLDTableView = [[SubscribeLecturerDetailTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
    _SLDTableView.delegate = self;
    _SLDTableView.tableHeaderView = self.headerView;
    [self.view insertSubview:_SLDTableView belowSubview:_navigationView];
    
}

//UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SLDTextCellLayoutFrame *layout = [[SLDTextCellLayoutFrame alloc]initWithTitle:_titles[indexPath.section] TextString:_contents[indexPath.section]];
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
    //订阅按钮
    UIButton *subscribeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    subscribeButton.frame = CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49);
    [subscribeButton setTitle:@"咨询" forState:UIControlStateNormal];
    [subscribeButton setBackgroundColor:themeYellow];
    [subscribeButton setTitleColor:themeWhite forState:UIControlStateNormal];
    subscribeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [subscribeButton addTarget:self action:@selector(subscribeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subscribeButton];
}

//订阅
- (void)subscribeAction{
    NSLog(@"咨询");
    PaymentChannelView *view = [UIView paymentChannelView];
    _popup = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:view];
    _popup.isAllowPopupsDrag = YES;
    _popup.dampingRatio = 0.9;
    _popup.presentationStyle = PresentationStyleBottom;
    [_popup presentAnimated:YES completion:nil];
}


@end
