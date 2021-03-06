//
//  VideoCourseCollectionView.m
//  Zimu
//
//  Created by Redpower on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "VideoCourseCollectionView.h"
#import "VideoCourseCollectionViewCell.h"
#import "VideoCourseBigCell.h"
#import "HomeVideoDetailViewController.h"
#import "UIView+ViewController.h"


static NSString *bigIdentifier = @"VideoCourseBigCell";
static NSString *identifier = @"videoCourseCollectionCell";
@interface VideoCourseCollectionView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation VideoCourseCollectionView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    
    [self registerNib:[UINib nibWithNibName:@"VideoCourseBigCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:bigIdentifier];
    [self registerNib:[UINib nibWithNibName:@"VideoCourseCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:identifier];
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
    switch (_videoCourseCellStyle) {
        case VideoCourseCellStyleFree:
            return _imageArray.count;
//            return _homeFreeCourseModelArray.count;
            
            break;
        case VideoCourseCellStyleNotFree:
            return _imageArray.count;
//            return _homeNotFreeCourseModelArray.count;
            break;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        VideoCourseBigCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bigIdentifier forIndexPath:indexPath];
        cell.imageString = _imageArray[indexPath.row];
        
        return cell;
    }
    VideoCourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.imageString = _imageArray[indexPath.row];
    
    
//    先放着
//    switch (_videoCourseCellStyle) {
//        case VideoCourseCellStyleFree:
//            
//            cell.homeFreeCourseModel = _homeFreeCourseModelArray[indexPath.row];
//            
//            break;
//        case VideoCourseCellStyleNotFree:
//            
//            cell.homeNotFreeCourseModel = _homeNotFreeCourseModelArray[indexPath.row];
//            
//            break;
//    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = kScreenWidth - 20;
    CGFloat height = width * 0.5 + 38;
    if (indexPath.row == 0) {
        return CGSizeMake(width, height);
    }
    width = (kScreenWidth - 30)/2;
    height = width * 0.5 + 40;
    return CGSizeMake(width, height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath : %@",indexPath);
    HomeVideoDetailViewController *videoVC = [[HomeVideoDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:videoVC animated:YES];
}


- (void)setHomeFreeCourseModelArray:(NSArray *)homeFreeCourseModelArray{
    if (_homeFreeCourseModelArray != homeFreeCourseModelArray) {
        _homeFreeCourseModelArray = homeFreeCourseModelArray;
        [self reloadData];
    }
}

- (void)setHomeNotFreeCourseModelArray:(NSArray *)homeNotFreeCourseModelArray{
    if (_homeNotFreeCourseModelArray != homeNotFreeCourseModelArray) {
        _homeNotFreeCourseModelArray = homeNotFreeCourseModelArray;
        [self reloadData];
    }
}

@end
