//
//  FindHotTopicListCollectiomView.m
//  Zimu
//
//  Created by apple on 2017/3/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindHotTopicListCollectiomView.h"
#import "FindHotTopicCell.h"

#define TOPIC_WIDTH (kScreenWidth / 2.5)
#define TOPIC_HEIGHT (TOPIC_WIDTH * 0.538)
static NSString *cellReuesId = @"FindHotTopicCellid";
@interface FindHotTopicListCollectiomView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** 图片和标题数组 **/
@property (nonatomic, copy) NSArray *imgDataArray;
@property (nonatomic, copy) NSArray *textDataArray;

@end

@implementation FindHotTopicListCollectiomView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _imgDataArray = @[@"find_topic_1", @"find_topic_2", @"find_topic_4", @"find_topic_4"];
        _textDataArray = @[@"哪一刻你觉得自己得了抑郁症", @"哪一刻你觉得自己得了抑郁症", @"哪一刻你觉得自己得了抑郁症", @"哪一刻你觉得自己得了抑郁症"];
        //注册单元格
        UINib *nib = [UINib nibWithNibName:@"FindHotTopicCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellWithReuseIdentifier:cellReuesId];
        
        self.backgroundColor = themeWhite;
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}
#pragma mark - delegate dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imgDataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FindHotTopicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuesId forIndexPath:indexPath];
    cell.img.image = [UIImage imageNamed:_imgDataArray[indexPath.row]];
    cell.text.text = _textDataArray[indexPath.row];
    return cell;
}
#pragma mark - delegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 5, 0, 5);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(TOPIC_WIDTH - 10, TOPIC_HEIGHT);
}
@end
