//
//  BrowsArticleViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BrowsArticleViewController.h"
#import "BrowsArticleCell.h"

static NSString *artCell = @"BrowsArticleCell";
@interface BrowsArticleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *articleTableView;

@end

@implementation BrowsArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = themeGray;
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView{
    if (!_articleTableView) {
        _articleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, kScreenWidth, kScreenHeight - 101) style:UITableViewStylePlain];
        _articleTableView.backgroundColor = themeGray;
        
        UINib *nib = [UINib nibWithNibName:artCell bundle:[NSBundle mainBundle]];
        [_articleTableView registerNib:nib forCellReuseIdentifier:artCell];
        
        _articleTableView.delegate = self;
        _articleTableView.dataSource = self;
        
        [self.view addSubview:_articleTableView];
    }
}

#pragma mark - 表视图代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 16;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BrowsArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:artCell forIndexPath:indexPath];
    cell.separatorInset = UIEdgeInsetsZero;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.4*kScreenWidth + 73;
}
@end
