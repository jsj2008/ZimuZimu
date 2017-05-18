//
//  CourseHotListView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CourseHotListView.h"
#import "CourseHotListCell.h"

#define FREECOURSE_WIDTH (kScreenWidth / 3)
#define COURSE_FM_HEIGHT  kScreenWidth * 0.214 + 60

static NSString *hotListCellIdentifier = @"CourseHotListCellid";
@interface CourseHotListView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation CourseHotListView

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:self.flowLayout];
    if (self) {
        //注册单元格
        [self registerClass:[CourseHotListCell class] forCellWithReuseIdentifier:hotListCellIdentifier];
        
        self.backgroundColor = themeWhite;
        self.dataSource = self;
        self.delegate = self;
        
    }
    return self;
}
#pragma mark - delegate dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _hotVideoModelArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CourseHotListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:hotListCellIdentifier forIndexPath:indexPath];
    cell.hotVideoModel = _hotVideoModelArray[indexPath.row];
    
    return cell;
}
#pragma mark - delegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (kScreenWidth - 40)/3.0;
    return CGSizeMake(width, width * 0.8 + 45);
}

- (void)setHotVideoModelArray:(NSArray *)hotVideoModelArray{
    _hotVideoModelArray = hotVideoModelArray;
    
    [self reloadData];
}

@end
