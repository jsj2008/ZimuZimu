//
//  CourseListCollectionView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CourseListCollectionView.h"
#import "CourseListVideoCell.h"
#import "HomeVideoDetailViewController.h"
#import "UIView+ViewController.h"

#define FREECOURSE_WIDTH (kScreenWidth / 2)
#define COURSE_VIDEOIMG_HEIGHT  kScreenWidth * 0.266
#define COURSE_VIDEO_HEIGHT     (COURSE_VIDEOIMG_HEIGHT + 14 + 30)

static NSString *cellReuesId = @"CourseListVideoCellid";
@interface CourseListCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** 图片和标题数组 **/
@property (nonatomic, copy) NSArray *imgDataArray;
@property (nonatomic, copy) NSArray *textDataArray;

@end

@implementation CourseListCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _imgDataArray = @[@"find_topic_1", @"find_topic_2", @"find_topic_4", @"find_topic_4"];
        _textDataArray = @[@"哪一刻你觉得自己得了抑郁症", @"哪一刻你觉得自己得了抑郁症", @"哪一刻你觉得自己得了抑郁症", @"哪一刻你觉得自己得了抑郁症"];
        //注册单元格
        UINib *nib = [UINib nibWithNibName:@"CourseListVideoCell" bundle:[NSBundle mainBundle]];
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
    CourseListVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuesId forIndexPath:indexPath];
    cell.img.image = [UIImage imageNamed:_imgDataArray[indexPath.row]];
    cell.courseTitle.text = _textDataArray[indexPath.row];
    return cell;
}
#pragma mark - delegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(FREECOURSE_WIDTH, COURSE_VIDEO_HEIGHT);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeVideoDetailViewController *videoDetailVC = [[HomeVideoDetailViewController alloc] init];
    [self.viewController.navigationController pushViewController:videoDetailVC animated:YES];
}
@end
