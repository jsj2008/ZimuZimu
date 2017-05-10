//
//  ChatRoomMemberView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/4.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ChatRoomMemberView.h"
#import "ChatRoomMemberCell.h"

static NSString *memberCell = @"ChatRoomMemberCell";

@interface ChatRoomMemberView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation ChatRoomMemberView

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 15;
        _flowLayout.minimumInteritemSpacing = 30;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:self.flowLayout];
    if (self) {
        UINib *nib = [UINib nibWithNibName:memberCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellWithReuseIdentifier:memberCell];
        
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma mark - collectView代理和数据源

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ChatRoomMemberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:memberCell forIndexPath:indexPath];
    //设置cell的内容
    cell.name = @"苏三";
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

//每个Cell的contentView缩进
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsZero;
}
//每个Cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenWidth - 90) / 3, (kScreenWidth - 90) / 3 + 14 + 17);
}


@end
