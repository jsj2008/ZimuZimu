//
//  CityCourseViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/29.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CityCourseViewController.h"
#import "CityCourseTableView.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "SegmentView.h"
#import "YMCitySelect.h"

@interface CityCourseViewController ()<YMCitySelectDelegate>

@property (nonatomic, strong) SegmentView *segmentView;
@property (nonatomic, strong) CityCourseTableView *cityCourseTableView;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton *addressButton;

@end

@implementation CityCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"一城一课";
    self.view.backgroundColor = themeGray;
    
    //搜索按钮
    UIBarButtonItem *searchBarButton = [UIBarButtonItem barButtonItemWithImageName:@"course_searchicon" title:@"" target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem = searchBarButton;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [self.view addSubview:self.segmentView];
    [self setupAddressView];
    [self.view addSubview:self.cityCourseTableView];
    
}

//搜索
- (void)searchAction{
    NSLog(@"搜索");
}

/**
 *  地址（当前位置）
 */
- (void)setupAddressView{
    _addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addressButton.frame = CGRectMake(0, 64, kScreenWidth, 40);
    [_addressButton addTarget:self action:@selector(selectAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addressButton];
    
    _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, _addressButton.width - 20, 40)];
    _addressLabel.backgroundColor = [UIColor clearColor];
    _addressLabel.textAlignment = NSTextAlignmentLeft;
    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.textColor = [UIColor colorWithHexString:@"666666"];
    NSMutableAttributedString *title = [self appendImageString:@"杭州"];
    _addressLabel.attributedText = title;
    [_addressButton addSubview:_addressLabel];
    
    
}
- (void)selectAddress:(UIButton *)button{
    NSLog(@"address : %@",button.titleLabel.text);
    
    YMCitySelect *ymcityselectVC = [[YMCitySelect alloc]init];
    ymcityselectVC.ymDelegate = self;
    [self presentViewController:ymcityselectVC animated:YES completion:nil];
    
}

- (void)ym_ymCitySelectCityName:(NSString *)cityName{
    NSMutableAttributedString *city = [self appendImageString:cityName];
    _addressLabel.attributedText = city;
}

- (NSMutableAttributedString *)appendImageString:(NSString *)cityName{
    NSString *string = [NSString stringWithFormat:@" %@",cityName];
    NSAttributedString *attributedString = [[NSAttributedString alloc]initWithString:string];
    NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
    attachment.image = [UIImage imageNamed:@"home_dingwei"];
    NSMutableAttributedString *imageString = (NSMutableAttributedString *)[NSMutableAttributedString attributedStringWithAttachment:attachment];
    [imageString appendAttributedString:attributedString];
    return imageString;
}


/**
 *  segmentView
 */
- (UIView *)segmentView{
    if (!_segmentView) {
        _segmentView = [[SegmentView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 42)];
        _segmentView.backgroundColor = themeWhite;
    }
    return _segmentView;
}


/**
 *  cityCourseTableView
 */
- (CityCourseTableView *)cityCourseTableView{
    if (!_cityCourseTableView) {
        _cityCourseTableView = [[CityCourseTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_addressButton.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(_addressButton.frame)) style:UITableViewStylePlain];
        _cityCourseTableView.backgroundColor = themeGray;
        
    }
    return _cityCourseTableView;
}



@end
