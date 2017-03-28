//
//  CourseTabelView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CourseTabelView.h"
#import "ImageCarouselView.h"
#import "CourseListCollectionView.h"
#import "CourseHotBookListView.h"
#import "CourseHotListView.h"
#import "CarouselCellInfo.h"

#import "CourseHeadCell.h"
#import "CourseFuncationCell.h"


//tableViewCell的高度
#define COURSE_CYCLE_HEIGHT     kScreenWidth * 0.733 + 20
#define COURSE_FUN_HEIGHT       kScreenWidth * 0.293 + 20
#define COURSE_HEAD_HEIGHT      37

#define COURSE_VIDEOIMG_HEIGHT  kScreenWidth * 0.533
#define COURSE_VIDEO_HEIGHT     (COURSE_VIDEOIMG_HEIGHT + 14 + 30) * 2
#define COURSE_FM_HEIGHT        kScreenWidth * 0.427 + 60
#define COURSE_BOOK_HEIGHT      kScreenWidth * 0.747 + 30 + 30

//cell复用的id
static NSString *headCellId = @"CourseHeadCell";
static NSString *funcCellId = @"CourseFuncationCell";
static NSString *normalCellId = @"courseListNormalCell";

//各个单元格的高度

@interface CourseTabelView () <UITableViewDelegate, UITableViewDataSource, ImageCarouselViewDelegate, ImageCarouselViewDataSource>

/* 顶部轮播视图 */
@property (nonatomic, strong) ImageCarouselView             *imageCarouselView;
//免费排行
@property (nonatomic, strong) CourseListCollectionView      *freeListView;
//热门视频课程
@property (nonatomic, strong) CourseListCollectionView      *hotVideoListView;
//畅销FM
@property (nonatomic, strong) CourseHotListView             *fmListView;
//热门书籍
@property (nonatomic, strong) CourseHotBookListView         *bookListView;
//轮播图的数据
@property (nonatomic, strong) NSArray *cellInfoArray;

@end

@implementation CourseTabelView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        //注册单元格
        UINib *nib1 = [UINib nibWithNibName:headCellId bundle:[NSBundle mainBundle]];
        [self registerNib:nib1 forCellReuseIdentifier:headCellId];
        
        UINib *nib2 = [UINib nibWithNibName:funcCellId bundle:[NSBundle mainBundle]];
        [self registerNib:nib2 forCellReuseIdentifier:funcCellId];
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:normalCellId];
        
        self.delegate = self;
        self.dataSource = self;
        
        _cellInfoArray = @[@"course_banner_m", @"course_banner_m", @"course_banner_m"];
        
    }
    return self;
}
#pragma mark - 代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 1;
    if (section == 1) return 1;
    if (section == 2) return 2;
    if (section == 3) return 2;
    if (section == 4) return 2;
    if (section == 5) return 2;
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellId];
        if (!_imageCarouselView) {
            _imageCarouselView = [[ImageCarouselView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, COURSE_CYCLE_HEIGHT - 20) withDataSource:self withDelegate:self];
        }
        [cell addSubview:_imageCarouselView];
        return cell;
    }
    
    UITableViewCell *cell;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) return 0;
    if (section == 1) return 20;
    if (section == 2) return 20;
    if (section == 3) return 20;
    if (section == 4) return 20;
    if (section == 5) return 20;
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) return COURSE_CYCLE_HEIGHT;
    else if (section == 1) return COURSE_FUN_HEIGHT;
    else{
        if (row == 0) return 37;
        else{
            if (section == 2 || section == 3) return COURSE_VIDEO_HEIGHT;
            if (section ==4) return COURSE_FM_HEIGHT;
            if (section == 5) return COURSE_BOOK_HEIGHT;
        }
    }
    
    return 0;
}
#pragma mark - ImageCarouselView代理和数据源
- (CGSize)sizeForPageInCarouselView:(ImageCarouselView *)carouselView {
    return CGSizeMake(kScreenWidth, self.pageHeight);
}

- (NSInteger)numberOfPagesInCarouselView:(ImageCarouselView *)carouselView {
    return self.cellInfoArray.count;
}

- (CarouselCell *)carouselView:(ImageCarouselView *)carouselView cellForPageAtIndex:(NSUInteger)index {
    CarouselCellImageView *cell = [[CarouselCellImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 4, self.pageHeight)];
    cell.showTime = 4;
    cell.imageView.image = [UIImage imageNamed:_cellInfoArray[index]];
    
    return cell;
}

- (void)carouselView:(ImageCarouselView *)carouselView didScrollToPage:(NSInteger)pageNumber {
//    _labelOne.text = [NSString stringWithFormat:@"滚动到了第 %zd 页", pageNumber];
    NSLog(@"滚到了了%zd", pageNumber);
//    carouselView set
}

- (void)carouselView:(ImageCarouselView *)carouselView didSelectPageAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd", index);
//    _labelTwo.text = [NSString stringWithFormat:@"点击了第 %zd 页", index];
}


- (NSUInteger)pageHeight {
    return COURSE_CYCLE_HEIGHT - 20;
}

@end
