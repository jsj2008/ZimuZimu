//
//  FriendsMsgViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FriendsMsgViewController.h"
#import "FriendMsgCell.h"

static NSString *cellId = @"FriendMsgCell";
@interface FriendsMsgViewController ()<UITableViewDelegate, UITableViewDataSource, FriendAcceptDelegate>

@property (nonatomic, strong) UITableView *listView;

@end

@implementation FriendsMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    self.title = @"消息";
    [self makeUI];
    // Do any additional setup after loading the view.
}

#pragma mark - makeUI
- (void)makeUI{
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _listView.dataSource = self;
        _listView.delegate = self;
        _listView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        
        //注册单元格
        UINib *nib = [UINib nibWithNibName:cellId bundle:[NSBundle mainBundle]];
        [_listView registerNib:nib forCellReuseIdentifier:cellId];
        
        [self.view addSubview:_listView];
    }
}

#pragma mark - 列表代理数据源
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.nameString = @"苏武";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isFriend = indexPath.row < 20 ? YES : NO;
    cell.clickBtnDelegate =self;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - 点击同意
- (void)didClickAccceptBtn:(FriendMsgCell *)cell{
    NSIndexPath *index = [_listView indexPathForCell:cell];
    NSLog(@"%zd", index.row);
}


@end
