//
//  OpenCourseVideoCollectionView.m
//  Zimu
//
//  Created by Redpower on 2017/3/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "OpenCourseVideoCollectionView.h"
#import "OpenCourseVideoCollectionViewCell.h"

static NSString *openCourseVideoIdentifier = @"openCourseVideoCollectionCell";
@interface OpenCourseVideoCollectionView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

//@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation OpenCourseVideoCollectionView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self registerNib:[UINib nibWithNibName:@"OpenCourseVideoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:openCourseVideoIdentifier];
    
    self.delegate = self;
    self.dataSource = self;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OpenCourseVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:openCourseVideoIdentifier forIndexPath:indexPath];
    cell.imageString = _imageArray[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (kScreenWidth - 30)/2.0;
    CGFloat height = width * 0.7 + 60;
    return CGSizeMake(width, height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath : %@",indexPath);
}

- (void)setImageArray:(NSArray *)imageArray{
    if (_imageArray != imageArray) {
        _imageArray = imageArray;
        [self reloadData];
    }
}

@end
