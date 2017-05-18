//
//  ZM_FriendsListView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZM_FriendsListView.h"
#import "ZM_FriendCell.h"

static NSString *friendCellId = @"ZM_FriendCell";
static NSString *nullCell = @"friendNullCell";
@interface ZM_FriendsListView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableDictionary *selectItems;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;


@end

@implementation ZM_FriendsListView
- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _selectItems = [NSMutableDictionary dictionary];
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowLayout;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:self.flowLayout];
    if (self) {
        //注册cell
        UINib *nib = [UINib nibWithNibName:friendCellId bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellWithReuseIdentifier:friendCellId];
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:nullCell];
        
        self.backgroundColor = [UIColor colorWithHexString:@"F2F3F7"];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)setState:(chooseState)state{
    _state = state;
    [self reloadData];
}
#pragma mark - delegate datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count + 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= _dataArray.count) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:nullCell forIndexPath:indexPath];
        return cell;
    }
    
    ZM_FriendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:friendCellId forIndexPath:indexPath];
    if (_state == chooseStateChoosing) {
        NSString *selectKey = [NSString stringWithFormat:@"%zd", indexPath.row];
        if (_selectItems[selectKey] != nil) {
            cell.state = friendViewStateChoosingSelected;
        }else{
            cell.state = friendViewStateChoosingDisSelected;
        }
    }else{
        cell.state = friendViewStateNormal;
    }
    
    //在这里设置cell的内容
    NSDictionary *dataDic = _dataArray[indexPath.row];
    cell.nameString = dataDic[@"name"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= _dataArray.count) {
        NSLog(@"我不是"); 
    }else{
        if (_state == chooseStateChoosing) {
            NSString *selectKey = [NSString stringWithFormat:@"%zd", indexPath.row];
            if (_selectItems[selectKey] != nil) {
                [_selectItems removeObjectForKey:selectKey];
            }else{
                if (_selectItems.count >= 3) {
                    
                }else{
                    [_selectItems setObject:_dataArray[indexPath.row] forKey:selectKey];
                    [self.selectMoreDelegate didSelectItems:(NSDictionary *)_selectItems];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadItemsAtIndexPaths:@[indexPath]];
            });
        }else{
            [self.selectMoreDelegate watchFriendDetailWithIndex:indexPath.row];
        }
    }
}


#pragma mark - 布局Delegate
//每个Cell的contentView缩进
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//每个Cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.width * 0.3333 - 45 * 0.3333, self.width * 0.38);
}

@end
