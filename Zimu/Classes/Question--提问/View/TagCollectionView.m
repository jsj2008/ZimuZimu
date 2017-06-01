//
//  TagCollectionView.m
//  Zimu
//
//  Created by Redpower on 2017/3/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "TagCollectionView.h"
#import "TagCollectionViewCell.h"
#import "MBProgressHUD+MJ.h"
#import "QuestionTagModel.h"

static NSString *tagCellIdentifier = @"TagCollectionViewCell";
@interface TagCollectionView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *selectArray;

@end
@implementation TagCollectionView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    
    _selectArray = [NSMutableArray array];
    _selectTagArray = [NSMutableArray array];
    //注册单元格
    [self registerNib:[UINib nibWithNibName:@"TagCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:tagCellIdentifier];
}

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
        
        _selectArray = [NSMutableArray array];
        _selectTagArray = [NSMutableArray array];
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
    //遍历数组，检查是否已选择
    cell.bgImageView.hidden = YES;
    if (_selectArray.count) {
        for (NSIndexPath *indexP in _selectArray) {
            if (indexPath.row == indexP.row) {
                cell.bgImageView.hidden = NO;
            }
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    QuestionTagModel *tagModel = _tagArray[indexPath.row];
    NSString *tagString = _tagArray[indexPath.row];
    CGSize tagSize = [tagString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    return CGSizeMake(tagSize.width + 20, 25);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (void)setTagArray:(NSArray *)tagArray{
    if (_tagArray != tagArray) {
        _tagArray = tagArray;
        [self reloadData];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //遍历数组，检查是否已存在
    if (_selectArray.count == 0) {
        [_selectArray addObject:indexPath];
    } else {
        BOOL exist = NO;
        
        for (NSIndexPath *indexP in _selectArray) {
            if (indexPath == indexP) {
                [_selectArray removeObject:indexP];
                exist = YES;
                break;      //遍历时操作数组，操作完必须break，否则会die
            }else{
                exist = NO;
            }
        }
        if (!exist) {
            if (_selectArray.count >= 3) {
                [MBProgressHUD showMessage_WithoutImage:@"已选择3个" toView:nil];
            }else if (_selectArray.count > 0){
                //不存在，添加
                [_selectArray addObject:indexPath];
            }
        }
    }
    [self getTags];
    [collectionView reloadData];
    NSLog(@"selectArray %@",_selectArray);
}

- (void)getTags{
    [_selectTagArray removeAllObjects];
    for (NSIndexPath *indexPath in _selectArray) {
        NSString *tagText = _tagArray[indexPath.row];
        [_selectTagArray addObject:tagText];
    }
}

@end
