//
//  FMCollectionView.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMCollectionView.h"
#import "FMCollectionViewCell.h"
#import "FMViewController.h"
#import "UIView+ViewController.h"

static NSString *identifier = @"FMCollectionViewCell";
@interface FMCollectionView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end
@implementation FMCollectionView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    
    [self registerNib:[UINib nibWithNibName:@"FMCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:identifier];
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _homeFMModelArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.homeFMItem = _homeFMModelArray[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = 100/375.0 * kScreenWidth;
    CGFloat height = self.height - 20;
    return CGSizeMake(width, height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath : %@",indexPath);
    
    [self.viewController.navigationController pushViewController:[[FMViewController alloc]init] animated:YES];

}

- (void)setHomeFMModelArray:(NSArray *)homeFMModelArray{
    if (_homeFMModelArray != homeFMModelArray) {
        _homeFMModelArray = homeFMModelArray;
        [self reloadData];
    }
}
//255 234 170


@end
