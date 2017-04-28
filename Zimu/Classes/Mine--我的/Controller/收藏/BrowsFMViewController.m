//
//  BrowsFMViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BrowsFMViewController.h"
#import "SubscribeFreeFMCell.h"

static NSString *fmCell = @"SubscribeFreeFMCellrecent";
@interface BrowsFMViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *fmTableView;

@end

@implementation BrowsFMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = themeWhite;
    
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createTableView{
    if (!_fmTableView) {
        _fmTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, kScreenWidth, kScreenHeight - 101) style:UITableViewStylePlain];
        _fmTableView.backgroundColor = themeGray;
        
        UINib *nib = [UINib nibWithNibName:@"SubscribeFreeFMCell" bundle:[NSBundle mainBundle]];
        [_fmTableView registerNib:nib forCellReuseIdentifier:fmCell];
        
        _fmTableView.dataSource = self;
        _fmTableView.delegate = self;
        
        [self.view addSubview:_fmTableView];
    }
}

#pragma mark - 数据源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SubscribeFreeFMCell *cell = [tableView dequeueReusableCellWithIdentifier:fmCell forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (kScreenWidth - 20) * 0.16 + 20;
}
@end
