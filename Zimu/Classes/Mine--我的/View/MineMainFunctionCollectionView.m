//
//  MineMainFunctionCollectionView.m
//  Zimu
//
//  Created by apple on 2017/3/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MineMainFunctionCollectionView.h"
#import "MineBigFunctionCell.h"
#import "MySecretViewController.h"
#import "UIView+ViewController.h"

#define MAINFUN_CELL_HEIGHT 95
#define MAINFUN_CELL_WIDTH (kScreenWidth / 3)
static NSString *cellReuesId = @"MineBigFunctionCellid";
@interface MineMainFunctionCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** 图片和标题数组 **/
@property (nonatomic, copy) NSArray *imgDataArray;
@property (nonatomic, copy) NSArray *textDataArray;

@end
@implementation MineMainFunctionCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _imgDataArray = @[@"mine_my_course", @"mine_secrt", @"mine_psychologicTeacher"];
        _textDataArray = @[@"我的课程", @"我的心事", @"我的心理专家"];
        //注册单元格
        UINib *nib = [UINib nibWithNibName:@"MineBigFunctionCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellWithReuseIdentifier:cellReuesId];
        
        self.backgroundColor = themeWhite;
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma mark - delegate dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MineBigFunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuesId forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:_imgDataArray[indexPath.row]];
    cell.titleLabel.text = _textDataArray[indexPath.row];
    cell.titleLabel.textColor = themeBlack;
    
    return cell;
}
#pragma mark - delegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(MAINFUN_CELL_WIDTH, MAINFUN_CELL_HEIGHT);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        MySecretViewController *mySeVC = [[MySecretViewController alloc] init];
        [self.viewController.navigationController pushViewController:mySeVC animated:YES];
    }
}

@end
