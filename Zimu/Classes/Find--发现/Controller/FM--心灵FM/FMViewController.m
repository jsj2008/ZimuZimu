//
//  FMViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/30.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMViewController.h"
#import "FMPlayView.h"
#import "FMTableView.h"

@interface FMViewController ()<FMPlayViewDelegate>

@property (nonatomic, strong) FMPlayView *FMPlayView;
@property (nonatomic, strong) FMTableView *tableView;

@end

@implementation FMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"心灵FM";
    self.view.backgroundColor = themeGray;
    
    [self.view addSubview:self.tableView];
    
}

/**
 *  创建FMTableView
 */
- (FMTableView *)tableView{
    if (!_tableView) {
        _tableView = [[FMTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.tableHeaderView = self.FMPlayView;
    }
    return _tableView;
}

- (FMPlayView *)FMPlayView{
    if (!_FMPlayView) {
        NSArray *fmURLArray = @[@"http://on9fin031.bkt.clouddn.com/music/mp3AGA%20-%20%E5%9C%86.mp3",
                                @"http://on9fin031.bkt.clouddn.com/music/mp3League%20of%20Legends%20-%20Get%20Jinxed.mp3",
                                @"http://on9fin031.bkt.clouddn.com/music/mp3%E4%BB%8E%E4%BD%A0%E7%9A%84%E5%85%A8%E4%B8%96%E7%95%8C%E8%B7%AF%E8%BF%87,%E8%89%BE%E4%B9%8B%E8%B6%85%20-%20%E5%BC%80%E5%BE%80%E6%98%A5%E5%A4%A9%E7%9A%84%E5%9C%B0%E9%93%81%E3%80%8A%E4%BB%8E%E4%BD%A0%E7%9A%84%E5%85%A8%E4%B8%96%E7%95%8C%E8%B7%AF%E8%BF%87%E3%80%8B.mp3",
                                @"http://on9fin031.bkt.clouddn.com/music/mp3%E5%8F%8C%E7%AC%99%20-%20%E5%A4%A9%E6%B6%AF%E8%BF%87%E5%AE%A2%EF%BC%88Cover%EF%BC%9A%E5%91%A8%E6%9D%B0%E4%BC%A6%EF%BC%89.mp3"];
        _FMPlayView = [[FMPlayView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenWidth) fmURLArray:fmURLArray];
        _FMPlayView.backgroundColor = themeWhite;
        _FMPlayView.delegate = self;
    }
    return _FMPlayView;
}

//FMPlayViewDelegate
- (void)nextSong{
    
}
- (void)previousSong{
    [_tableView reloadData];
}

@end
