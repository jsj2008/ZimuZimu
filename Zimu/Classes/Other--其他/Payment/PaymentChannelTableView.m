//
//  PaymentChannelTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "PaymentChannelTableView.h"
#import "PaymentChannelCell.h"

static NSString *channelIdentifier = @"PaymentChannelCell";
@interface PaymentChannelTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation PaymentChannelTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"PaymentChannelCell" bundle:nil] forCellReuseIdentifier:channelIdentifier];
        self.separatorColor = themeGray;
        
        //设置头视图
        self.tableHeaderView = [self headerView];
        
        //设置尾视图
        self.tableFooterView = [self footerView];
        
    }
    return self;
}

//头视图
- (UIView *)headerView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    headerView.backgroundColor = themeWhite;
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, headerView.width - 20, headerView.height)];
    headerLabel.text = @"支付方式";
    headerLabel.font = [UIFont systemFontOfSize:18];
    headerLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [headerView addSubview:headerLabel];
    
    CALayer *seperateLine = [[CALayer alloc]init];
    seperateLine.frame = CGRectMake(0, headerView.height - 1, headerView.width, 1);
    seperateLine.backgroundColor = themeGray.CGColor;
    [headerView.layer addSublayer:seperateLine];

    return headerView;
}

//尾视图
- (UIView *)footerView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    footerView.backgroundColor = themeWhite;
    UILabel *footerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerView.width - 20, footerView.height)];
    footerLabel.numberOfLines = 0;
    footerLabel.text = @"*倾诉费用支付到子慕平台账号，若中途倾诉失败活取消，倾诉费用将原路退回至您的支付账户";
    footerLabel.font = [UIFont systemFontOfSize:11];
    footerLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [footerView addSubview:footerLabel];
    
    CALayer *seperateLine = [[CALayer alloc]init];
    seperateLine.frame = CGRectMake(0, 0, footerView.width, 1);
    seperateLine.backgroundColor = themeGray.CGColor;
    [footerView.layer addSublayer:seperateLine];
    
    return footerView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PaymentChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:channelIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(cell.height - 1, 10, 0, 0);
    if (indexPath.row == 0) {
        cell.imageString = @"payment_alipay_icon";
        cell.channelString = @"  支付宝";
    }else{
        cell.imageString = @"payment_weixin_icon";
        cell.channelString = @"  微信";
    }
    
    //设置默认付款方式
    [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PaymentChannelCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectButton.selected = YES;
    NSIndexPath *another = indexPath;
    if (indexPath.row == 0) {
        //支付宝支付
        another = [NSIndexPath indexPathForRow:1 inSection:0];
    }else{
        //微信支付
        another = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    PaymentChannelCell *anotherCell = [tableView cellForRowAtIndexPath:another];
    anotherCell.selectButton.selected = NO;
    
    _channel = cell.channelString;
    
    [self.channelDelegate selectPaymentChannel:cell.channelString];
}

@end
