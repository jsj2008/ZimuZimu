//
//  HomeCollectionView.m
//  Zimu
//
//  Created by Redpower on 2017/4/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeCollectionView.h"

static NSString *identifier = @"HomeCollectionCell";
@interface HomeCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation HomeCollectionView

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
        
        [self registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
        _titleArray = @[@"萌拍",@"找朋友",@"互动游戏",@"活动报名",@"公开课",@"发现更多"];
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.layer.cornerRadius = 5;
    cell.titleImageString = [NSString stringWithFormat:@"home_icon_%li",indexPath.row + 1];
    cell.bgimageString = [NSString stringWithFormat:@"home_cellbg_%li",indexPath.row + 1];
    cell.coverImageString = [NSString stringWithFormat:@"home_cover_%li",indexPath.row + 1];
    cell.titleString = _titleArray[indexPath.row];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    if (indexPath.row % 2 != 0) {
//        cell.transform = CGAffineTransformTranslate(cell.transform, 0, 200);
//    }else{
//        cell.transform = CGAffineTransformTranslate(cell.transform, 0, 300);
//    }
    
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
    CGFloat width = (kScreenWidth - 12)/3.0;
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 3, 0, 3);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = (HomeCollectionViewCell *)[self cellForItemAtIndexPath:indexPath];
    [self.collectionDelegate collectionView:self didSelectCell:cell indexPath:indexPath];
}

@end
