//
//  PersonalFunctionView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "PersonalFunctionView.h"
#import "MineCollectionViewCell.h"
#import "UIView+ViewController.h"
#import "SingleChiefViewController.h"
#import "SingleViewerViewController.h"
#import "PLMediaViewerPKViewController.h"
#import "PLMediaChiefPKViewController.h"

static NSString *identifier = @"MineCollectionViewCell";

@interface PersonalFunctionView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation PersonalFunctionView

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 3;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowLayout;
}
- (void)setIsFriend:(BOOL)isFriend{
    _isFriend = isFriend;
    if (_isFriend == NO) {
        _imageArray = @[@"minei_dingdan456",@"mine_wodekecheng"];
        _titleArray = @[@"好友备注",@"添加好友"];
    }else{
        _imageArray = @[@"minei_dingdan456",@"mine_wod"];
        _titleArray = @[@"好友备注",@"发起聊天"];
    }
    _colorArray = @[@"faab8a",@"85beea"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
    
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:self.flowLayout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = [UIColor clearColor];
        [self registerNib:[UINib nibWithNibName:@"MineCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
            }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.markImageString = _imageArray[indexPath.row];
    cell.titleString = _titleArray[indexPath.row];
    cell.colorString = _colorArray[indexPath.row];
    
    return cell;
}


//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    CGFloat translateY = 0;
//    if (indexPath.row == 0) {
//        translateY = 150;
//    }else if (indexPath.row == 1){
//        translateY = 230;
//    }else if (indexPath.row == 2){
//        translateY = 310;
//    }else if (indexPath.row == 3){
//        translateY = 310;
//    }else if (indexPath.row == 4){
//        translateY = 390;
//    }else{
//        translateY = 470;
//    }
//    cell.transform = CGAffineTransformTranslate(cell.transform, 0, translateY);
//    
//    cell.alpha = 0.0;
//    [UIView animateWithDuration:0.7 animations:^{
//        cell.transform = CGAffineTransformIdentity;
//        cell.alpha = 1.0;
//    } completion:^(BOOL finished) {
//        
//        
//    }];
//}

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
    if ([cell.titleString isEqualToString:@"发起聊天"]) {
//        PLMediaViewerPKViewController *viewerVC = [[PLMediaViewerPKViewController alloc] init];
//        viewerVC.roomName = @"test778";
//        [self.viewController presentViewController:viewerVC animated:YES completion:nil];
        
//        PLMediaChiefPKViewController *chiefVC = [[PLMediaChiefPKViewController alloc] init];
//        chiefVC.roomName = @"test778";
//        [self.viewController presentViewController:chiefVC animated:YES completion:nil];
        
        SingleViewerViewController *singView = [[SingleViewerViewController alloc] init];
        singView.roomName = @"test778";
        singView.userType = PLMediaUserPKTypeSecondChief;
        [self.viewController presentViewController:singView animated:YES completion:nil];
        
//        SingleChiefViewController *singChief = [[SingleChiefViewController alloc] init];
//        singChief.roomName = @"test778";
//        [self.viewController presentViewController:singChief animated:YES completion:nil];
    }

}

@end

