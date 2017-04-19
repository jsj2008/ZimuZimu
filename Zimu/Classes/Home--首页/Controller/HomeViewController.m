//
//  HomeViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionView.h"
#import "SecondViewController.h"

#import "OpenCourseViewController.h"
#import "FindViewController.h"
#import "ActivityViewController.h"
#import "MineViewController.h"
#import "SettingView.h"
#import "LovelyFaceViewController.h"

@interface HomeViewController ()<CollectionViewDelegate>

@property (nonatomic, strong) HomeCollectionView *collectionView;
@property (nonatomic, strong) UIView *toolBar;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UIView *transitionView;
@property (nonatomic, strong) UIImageView *transitionCoverView;


@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeWhite;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupBgImageView];
    [self setupCollectionView];
    [self setupCoverImageView];
    [self setupToolView];
    
}

#pragma mark - bgImageView
- (void)setupBgImageView{
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgImageView.image = [UIImage imageNamed:@"home_bgImage"];
    [self.view insertSubview:_bgImageView atIndex:0];
}

#pragma mark - HomeCollectionView

- (void)setupCollectionView{
    CGFloat height = (kScreenWidth - 12)/3.0 * 2 + 3;
    _collectionView = [[HomeCollectionView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 65 - height, kScreenWidth, height) collectionViewLayout:[UICollectionViewFlowLayout new]];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.collectionDelegate = self;
    [self.view addSubview:_collectionView];
    
}

//CollectionViewDelegate
- (void)collectionView:(HomeCollectionView *)collectionView didSelectCell:(HomeCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    //背景
    CGRect frame = [collectionView convertRect:cell.frame toView:self.view];
    _transitionView = [[UIView alloc]initWithFrame:frame];
    _transitionView.backgroundColor = [UIColor mostColorOfImage:cell.bgImageView.image];
    _transitionView.alpha = 1;
    
    //cover图
    frame = [cell convertRect:cell.coverImageView.frame toView:self.view];
    _transitionCoverView = [[UIImageView alloc]initWithImage:cell.coverImageView.image];
    _transitionCoverView.frame = frame;
    _transitionCoverView.alpha = 1;
    
    
    /*转场动画*/
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:_transitionView];
    [window addSubview:_transitionCoverView];
    
    [UIView animateWithDuration:0.3 animations:^{
        _transitionView.transform = CGAffineTransformScale(_transitionView.transform, (kScreenWidth / _transitionView.width), kScreenHeight / _transitionView.height);
        _transitionView.center = self.view.center;
        
        _transitionCoverView.transform = CGAffineTransformScale(_transitionCoverView.transform, 1.3, 1.3);
        _transitionCoverView.center = window.center;
        
    } completion:^(BOOL finished) {
        if (indexPath.row == 0) {
            //将我们的storyBoard实例化，“Main”为StoryBoard的名称
            UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"LovelyFace" bundle:nil];
            //将第二个控制器实例化，"SecondViewController"为我们设置的控制器的ID
            LovelyFaceViewController *faceVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"LovelyFaceViewController"];
            //跳转事件
            [self.navigationController pushViewController:faceVC animated:NO];
        }else if (indexPath.row == 3) {               //活动报名
            ActivityViewController *activityVC = [[ActivityViewController alloc]init];
            [self.navigationController pushViewController:activityVC animated:NO];
        }else if (indexPath.row == 4){          //公开课
            OpenCourseViewController *openCourseVC = [[OpenCourseViewController alloc]init];
            [self.navigationController pushViewController:openCourseVC animated:NO];
        }else if (indexPath.row == 5){          //发现更多
            FindViewController *findVC = [[FindViewController alloc]init];
            [self.navigationController pushViewController:findVC animated:NO];
        }else{
            SecondViewController *secondVC = [[SecondViewController alloc]init];
            secondVC.naviColor = _transitionView.backgroundColor;
            [self.navigationController pushViewController:secondVC animated:NO];
        }
        
    }];
    [UIView animateWithDuration:0.5 delay:0.6 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _transitionCoverView.alpha = 0;
        _transitionView.alpha = 0;
        _transitionCoverView.transform = CGAffineTransformScale(_transitionCoverView.transform, 2, 2);
    } completion:^(BOOL finished) {
        [_transitionView removeFromSuperview];
        _transitionView = nil;
        [_transitionCoverView removeFromSuperview];
        _transitionCoverView = nil;
    }];

    
}

#pragma mark - coverImageView
- (void)setupCoverImageView{
    _coverImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_cover"]];
    _coverImageView.frame = CGRectMake(155 * kScreenWidth / 375.0, CGRectGetMinY(_collectionView.frame) - _coverImageView.image.size.height + 35, _coverImageView.image.size.width, _coverImageView.image.size.height);
    [self.view insertSubview:_coverImageView belowSubview:_collectionView];
    _coverImageView.alpha = 0;
    _coverImageView.transform = CGAffineTransformTranslate(_coverImageView.transform, 0, _coverImageView.height - 35);
    [UIView animateWithDuration:0.7 delay:0.7 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _coverImageView.transform = CGAffineTransformIdentity;
        _coverImageView.alpha = 1;
    } completion:^(BOOL finished) {
        [self.view insertSubview:_coverImageView aboveSubview:_collectionView];
    }];
}


#pragma mark - toolBar

- (void)setupToolView{
    _toolBar = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_collectionView.frame), kScreenWidth, 65)];
    _toolBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_toolBar];
    
    //专家解答
    UIButton *expertButton = [UIButton buttonWithType:UIButtonTypeCustom];
    expertButton.frame = CGRectMake(10, (_toolBar.height - 35)/2.0, 120, 35);
    expertButton.backgroundColor = themeGreen;
    expertButton.layer.cornerRadius = expertButton.height / 2.0;
    expertButton.layer.masksToBounds = YES;
    [expertButton setImage:[UIImage imageNamed:@"home_zhuanjiajieda"] forState:UIControlStateNormal];
    [expertButton setTitle:@"  专家解答" forState:UIControlStateNormal];
    [expertButton setTitleColor:themeWhite forState:UIControlStateNormal];
    expertButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [expertButton addTarget:self action:@selector(transitionAction:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:expertButton];
    
    //设置
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    setButton.frame = CGRectMake(kScreenWidth - 10 - 35, (_toolBar.height - 35)/2.0, 35, 35);
    setButton.backgroundColor = themeYellow;
    setButton.layer.cornerRadius = setButton.height / 2.0;
    setButton.layer.masksToBounds = YES;
    [setButton setImage:[UIImage imageNamed:@"home_shezhi"] forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(setButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:setButton];
    
    //我的
    UIButton *mineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mineButton.frame = CGRectMake(CGRectGetMinX(setButton.frame) - 15 - 35, (_toolBar.height - 35)/2.0, 35, 35);
    mineButton.backgroundColor = themeYellow;
    mineButton.layer.cornerRadius = mineButton.height / 2.0;
    mineButton.layer.masksToBounds = YES;
    [mineButton setImage:[UIImage imageNamed:@"home_person"] forState:UIControlStateNormal];
    [mineButton addTarget:self action:@selector(mineButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:mineButton];
    
    //动画
    _toolBar.transform = CGAffineTransformTranslate(_toolBar.transform, 0, 200);
    [UIView animateWithDuration:0.7 animations:^{
        _toolBar.transform = CGAffineTransformIdentity;
    }];
}

- (void)transitionAction:(UIButton *)button{
    SecondViewController *homeVC = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:homeVC animated:YES];
}

/*我的*/
- (void)mineButtonAction{
    MineViewController *mineVC = [[MineViewController alloc]init];
    [self.navigationController pushViewController:mineVC animated:YES];
}

/*设置*/
- (void)setButtonAction{
    [SettingView showToView:self.view];
}



@end
