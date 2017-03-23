//
//  TagCollectionView.m
//  Zimu
//
//  Created by Redpower on 2017/3/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "TagCollectionView.h"
#import "TagCollectionViewCell.h"

static NSString *tagCellIdentifier = @"TagCollectionViewCell";
@interface TagCollectionView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end
@implementation TagCollectionView

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 5;
        _flowLayout.minimumInteritemSpacing = 5;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowLayout;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:self.flowLayout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        //注册单元格
        [self registerNib:[UINib nibWithNibName:@"TagCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:tagCellIdentifier];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _tagArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tagCellIdentifier forIndexPath:indexPath];
    cell.tagString = _tagArray[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize tagSize = [_tagArray[indexPath.row] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    return CGSizeMake(tagSize.width + 20, 25);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)setTagArray:(NSArray *)tagArray{
    if (_tagArray != tagArray) {
        _tagArray = tagArray;
        [self reloadData];
    }
}


@end
