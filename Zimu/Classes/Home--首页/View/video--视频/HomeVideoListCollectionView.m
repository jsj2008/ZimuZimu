//
//  HomeVideoListCollectionView.m
//  Zimu
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeVideoListCollectionView.h"
#import "SectionFootCell.h"
#import "SubjectCourseListView.h"
#import "VideoListCell.h"
#import "SectionTitleCell.h"
#import "SDCycleScrollView.h"

static NSString *sectionHeadCell = @"SectionTitleCell";
static NSString *sectionFootCell = @"SectionFootCell";
static NSString *videoCell = @"VideoListCell";

#pragma mark - 各个cell的尺寸定义，方便修改，不用去下面改

#define CYCLECELL_HEIGHT kScreenWidth * 0.67
#define SUBJECT_HEIGHT (kScreenWidth / 3) * 1.25
#define VIDEO_HEIGHT kScreenWidth / 2 * 0.90
#define HEADFOOT_HEIGHT 60

@interface HomeVideoListCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SDCycleScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *circleData;    //轮播图数组
@property (nonatomic, strong) NSDictionary *subjectCourseListData;      //专题课程数组
@property (nonatomic, strong) NSMutableArray *videoListData;     //视频列表数组

@end

@implementation HomeVideoListCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        //注册Cell
        UINib *nib2 = [UINib nibWithNibName:sectionFootCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib2 forCellWithReuseIdentifier:sectionFootCell];
        
        UINib *nib3 = [UINib nibWithNibName:sectionHeadCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib3 forCellWithReuseIdentifier:sectionHeadCell];
        
        UINib *nib4 = [UINib nibWithNibName:videoCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib4 forCellWithReuseIdentifier:videoCell];
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"norMalCollCell"];
        
        //代理和数据源
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

//请求数据传入View，刷新数据和控件
- (void)setCirData:(NSMutableArray *)cirData subjectCourseListData:(NSDictionary *)subjectData videoListData:(NSMutableArray *)videoListData{
    if (cirData) {
        _circleData = cirData;
    }
    if (subjectData) {
        _subjectCourseListData = subjectData;
    }
    if (videoListData) {
        _videoListData = videoListData;
    }
//    [self reloadData];
    
}

#pragma mark - dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2 + _videoListData.count;
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else{
        return 6;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {              //轮播
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"norMalCollCell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UICollectionViewCell alloc] init];
            
        }
        for (UIView *view in cell.subviews) {
            [view removeFromSuperview];
        }
        SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, CYCLECELL_HEIGHT) delegate:self placeholderImage:[UIImage imageNamed:@"bfx-logo"]];
        cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
        cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
        NSArray *imgAry = @[@"http://www.yixian8.com/dingnai/1.png", @"http://www.yixian8.com/dingnai/2.png", @"http://www.yixian8.com/dingnai/3.png"];
        cycleScrollView3.imageURLStringsGroup = imgAry;
        cycleScrollView3.titlesGroup = @[@"啊速度快解放", @"胃康灵", @"早教课目无"];
        [cell addSubview:cycleScrollView3];
        return cell;
    }else if (indexPath.section == 1){          //专题课程
        if (indexPath.row == 0) {                       //头
            SectionTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sectionHeadCell forIndexPath:indexPath];
            cell.sectionTitle.text = @"专题课程";
            return cell;
        }
        else{                                           //列表
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"norMalCollCell" forIndexPath:indexPath];
            for (UIView *view in cell.subviews) {
                [view removeFromSuperview];
            }
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
            flowLayout.minimumLineSpacing = 1;
            flowLayout.minimumInteritemSpacing = 1;
            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            SubjectCourseListView *sclView = [[SubjectCourseListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SUBJECT_HEIGHT + 58) collectionViewLayout:flowLayout ];
            [sclView setCourseListData:_subjectCourseListData[@"seectionData"]];
            [cell addSubview:sclView];
            
            return cell;
        }
    }else{                                      //视频列表
        NSDictionary *videoDic = _videoListData[indexPath.section - 2];
        if (indexPath.row == 0) {                       //头
            SectionTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sectionHeadCell forIndexPath:indexPath];
            cell.sectionTitle.text = videoDic[@"sectionTitle"];
            return cell;
        }else if (indexPath.row == 5){                  //尾
            SectionFootCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sectionFootCell forIndexPath:indexPath];
            cell.changeListBtn.tag = indexPath.section;
            cell.seeMoreBtn.tag = indexPath.section;
            [cell.changeListBtn addTarget:self action:@selector(changeList:) forControlEvents:UIControlEventTouchUpInside];
            [cell.seeMoreBtn addTarget:self action:@selector(seemORE:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{                                          //视频内容
            NSArray *arr = videoDic[@"seectionData"];
            NSDictionary *rowDic = arr[indexPath.row - 1];
            VideoListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:videoCell forIndexPath:indexPath];
            cell.img.image = [UIImage imageNamed:rowDic[@"videoPic"]];
            cell.title.text = rowDic[@"videoTitle"];
            cell.detail.text = rowDic[@"videoText"];
            return cell;
        }
        
    }
    return nil;
}



#pragma mark - delegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 0) {        //滚动图
        return UIEdgeInsetsMake(0, 0, 1, 0);
    }else if (section == 1){  //专题课程列表
        return UIEdgeInsetsMake(0, 0, 1, 1);
    }else{
        return UIEdgeInsetsMake(0, 0, 1, 1);
    }
    
    return UIEdgeInsetsZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {        //滚动图
        return CGSizeMake(kScreenWidth, CYCLECELL_HEIGHT);
    }else if (indexPath.section == 1){  //专题课程列表
        if (indexPath.row == 0) {
            return CGSizeMake(kScreenWidth, HEADFOOT_HEIGHT);
        }else{
            return CGSizeMake(kScreenWidth, SUBJECT_HEIGHT + 58);
        }
    }else{
        if (indexPath.row == 0) {       //在视频列表，如果是第一或者最后一栏返回一样的大小
            return CGSizeMake(kScreenWidth, HEADFOOT_HEIGHT);
        }else if (indexPath.row == 5){
            return CGSizeMake(kScreenWidth, HEADFOOT_HEIGHT);
        }else{                           //视频列表
            return CGSizeMake((kScreenWidth - 2)/ 2, VIDEO_HEIGHT);
        }
    }
    
    CGFloat cellWidth = (kScreenWidth - 3) / 2;
    return CGSizeMake(cellWidth, cellWidth + 65);
}
#pragma mark - delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
        if (indexPath.section == 1) {
            if (indexPath.row != 0) {
                NSLog(@"专题------%li", indexPath.row);
            }
        }else{
            if (indexPath.row != 0 && indexPath.row != 5) {
                NSLog(@"视频------%li-%li", indexPath.section - 2, indexPath.row - 1);
            }
        }
    }
//    NSLog(@"%li", indexPath.row);
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%li", index);
}
#pragma mark - 更多和换一批
- (void)seemORE:(UIButton *)btn{
    NSLog(@"查看更多------%li",btn.tag);
}

- (void)changeList:(UIButton *)btn{
    NSLog(@"换一批-------%li",btn.tag);
}

@end
