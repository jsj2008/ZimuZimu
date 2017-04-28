//
//  SubjectCourseListView.m
//  Zimu
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubjectCourseListView.h"
#import "SubjectListCell.h"

static NSString *subjectCell = @"SubjectListCell";

@interface SubjectCourseListView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *subjectCourseData;  //专题课程数据数组

@end

@implementation SubjectCourseListView



- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = themeGray;
        //注册Cell
        UINib *nib1 = [UINib nibWithNibName:subjectCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib1 forCellWithReuseIdentifier:subjectCell];
        
        //代理和数据源
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)setCourseListData:(NSMutableArray *)arr{
    if (arr) {
        _subjectCourseData = arr;
//        [self reloadData];
    }
}

#pragma mark - dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _subjectCourseData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSDictionary *dic = _subjectCourseData[row];

    SubjectListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:subjectCell forIndexPath:indexPath];
    cell.title.text = dic[@"videoTitle"];
    cell.img.image = [UIImage imageNamed:dic[@"videoPic"]];
    return cell;
}

//delegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 1);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
       
    CGFloat cellWidth = (kScreenWidth - 3) / 3;
    return CGSizeMake(cellWidth, cellWidth * 1.25 + 59);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     NSLog(@"专题------%li", indexPath.row);
}
@end
