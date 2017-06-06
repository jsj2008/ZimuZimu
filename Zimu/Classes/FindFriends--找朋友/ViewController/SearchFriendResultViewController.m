//
//  SearchFriendResultViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SearchFriendResultViewController.h"
#import "SearchFriendsFriendCell.h"
#import "FriendMsgModel.h"

static NSString *cellId = @"SearchFriendsFriendCellde";
@interface SearchFriendResultViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SearchFriendResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    self.title = @"搜索结果";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
- (void)makeUI{
    [self.view addSubview:self.tableView];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        UINib *nib = [UINib nibWithNibName:@"SearchFriendsFriendCell" bundle:[NSBundle mainBundle]];
        [_tableView registerNib:nib forCellReuseIdentifier:cellId];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataDic isEqual:[NSNull null]] ? 0 : 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSDictionary *userDic = _dataArray[indexPath.row];
    FriendMsgModel *fmm = [FriendMsgModel yy_modelWithJSON:_dataDic];
    SearchFriendsFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    NSString *userImg = [imagePrefixURL stringByAppendingString:fmm.userImg];
    [cell setName:fmm.userName idStr:fmm.userId age:fmm.age imgUrlString:@"asdfij" sex:fmm.userSex];
    cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
    cell.addFriendBtn.hidden = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
@end
