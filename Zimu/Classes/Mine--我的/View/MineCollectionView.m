//
//  MineCollectionView.m
//  Zimu
//
//  Created by Redpower on 2017/4/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MineCollectionView.h"
#import "MineCollectionViewCell.h"
#import "UIView+ViewController.h"
#import "OrderViewController.h"
#import "SecondViewController.h"
#import "MySecretViewController.h"
#import "MyCollectViewController.h"
#import "MyEvaluationViewController.h"
#import "ExpertListViewController.h"

static NSString *identifier = @"MineCollectionViewCell";

@interface MineCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation MineCollectionView

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 3;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowLayout;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:self.flowLayout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = [UIColor clearColor];
        [self registerNib:[UINib nibWithNibName:@"MineCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
        _imageArray = @[@"mine_dingdan",@"mine_ceshi",@"mine_xinshi",@"mine_haoyou",@"mine_shoucang",@"mine_zhuanjia"];
        _titleArray = @[@"订单",@"测试",@"心事",@"好友",@"收藏",@"专家"];
        _colorArray = @[@"faab8a",@"85beea",@"fbb7c9",@"74d195",@"beb3e6",@"f7d36c"];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.markImageString = _imageArray[indexPath.row];
    cell.titleString = _titleArray[indexPath.row];
    cell.colorString = _colorArray[indexPath.row];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat translateY = 0;
    if (indexPath.row == 0) {
        translateY = 150;
    }else if (indexPath.row == 1){
        translateY = 230;
    }else if (indexPath.row == 2){
        translateY = 310;
    }else if (indexPath.row == 3){
        translateY = 310;
    }else if (indexPath.row == 4){
        translateY = 390;
    }else{
        translateY = 470;
    }
    cell.transform = CGAffineTransformTranslate(cell.transform, 0, translateY);
    
    cell.alpha = 0.0;
    [UIView animateWithDuration:0.7 animations:^{
        cell.transform = CGAffineTransformIdentity;
        cell.alpha = 1.0;
    } completion:^(BOOL finished) {
        
        
    }];
}

- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (kScreenWidth - 50 - 20)/3.0;
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MineCollectionViewCell *cell = (MineCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@",cell.titleString);
    if (indexPath.row == 0) {
        OrderViewController *orderVC = [[OrderViewController alloc]init];
        [self.viewController.navigationController pushViewController:orderVC animated:YES];
    }else if (indexPath.row == 1) {
        MyEvaluationViewController *myEvaluationVC = [[MyEvaluationViewController alloc]init];
        [self.viewController.navigationController pushViewController:myEvaluationVC animated:YES];
    }else if (indexPath.row == 2) {
        MySecretViewController *mySecretVC = [[MySecretViewController alloc]init];
        [self.viewController.navigationController pushViewController:mySecretVC animated:YES];
    }else if (indexPath.row == 4){
        MyCollectViewController *myCollectVC = [[MyCollectViewController alloc]init];
        [self.viewController.navigationController pushViewController:myCollectVC animated:YES];
    }else if(indexPath.row == 5){
        ExpertListViewController *expertListVC = [[ExpertListViewController alloc]init];
        [self.viewController.navigationController pushViewController:expertListVC animated:YES];
    }
}

@end
