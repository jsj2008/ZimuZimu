//
//  BookCourseViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BookCourseViewController.h"
#import "BookCourseTableView.h"
#import "CourseBannerView.h"

@interface BookCourseViewController ()

@property (nonatomic, strong) BookCourseTableView *bookCourseTableView;
@property (nonatomic, strong) CourseBannerView *headerView;

@end

@implementation BookCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"书籍";
    self.view.backgroundColor = themeGray;
    
    [self.view addSubview:self.bookCourseTableView];

}

- (BookCourseTableView *)bookCourseTableView{
    if (!_bookCourseTableView) {
        _bookCourseTableView = [[BookCourseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _bookCourseTableView.backgroundColor = themeGray;
        
        _bookCourseTableView.tableHeaderView = self.headerView;
    }
    return _bookCourseTableView;
}

- (CourseBannerView *)headerView{
    if (!_headerView) {
        _headerView = [[CourseBannerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        _headerView.bannerArray = @[@"http://on9fin031.bkt.clouddn.com/image/20170323174423228187",
                                    @"http://on9fin031.bkt.clouddn.com/image/20170323174653515679",
                                    @"http://on9fin031.bkt.clouddn.com/image/20170323174810211784",
                                    @"http://on9fin031.bkt.clouddn.com/image/20170323174827350730"];
    }
    return _headerView;
}



@end
