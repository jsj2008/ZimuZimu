//
//  CourseHotBookListView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CourseHotBookListView.h"
#import "CourseHotBookListCell.h"

#define FREECOURSE_WIDTH        (kScreenWidth / 3) - 10
#define COURSE_BOOK_HEIGHT      (FREECOURSE_WIDTH) * 1.333 + 37 + 27
static NSString *cellReuesId = @"CourseHotBookListCellid";
@interface CourseHotBookListView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** 图片和标题数组 **/
@property (nonatomic, copy) NSArray *imgDataArray;
@property (nonatomic, copy) NSArray *textDataArray;

@end

@implementation CourseHotBookListView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _imgDataArray = @[@"find_topic_1", @"find_topic_2", @"find_topic_4", @"find_topic_4"];
        _textDataArray = @[@"哪一刻你觉得自己得了抑郁症", @"哪一刻你觉得自己得了抑郁症", @"哪一刻你觉得自己得了抑郁症", @"哪一刻你觉得自己得了抑郁症"];
        //注册单元格
        UINib *nib = [UINib nibWithNibName:@"CourseHotBookListCell" bundle:[NSBundle mainBundle]];
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
    CourseHotBookListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuesId forIndexPath:indexPath];
    cell.img.image = [UIImage imageNamed:_imgDataArray[indexPath.row]];
    cell.hotBookTitleLabel.text = _textDataArray[indexPath.row];
    return cell;
}
#pragma mark - delegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 5, 0, 5);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(FREECOURSE_WIDTH, COURSE_BOOK_HEIGHT);
}

@end
