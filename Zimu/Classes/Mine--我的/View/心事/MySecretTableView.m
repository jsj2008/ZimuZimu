//
//  MySecretTableView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/30.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MySecretTableView.h"
#import "MySecretCell.h"
#import "MySecretCellLayoutFrame.h"
#import "AnswerViewController.h"
#import "AnswerDetailViewController.h"
#import "UIView+ViewController.h"
#import "SecretModel.h"

static NSString *identifier = @"MySecretCell";


@interface MySecretTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MySecretTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        UINib *nib = [UINib nibWithNibName:@"MySecretCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellReuseIdentifier:identifier];

        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = themeGray;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

#pragma mark - tableView代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _modelArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MySecretCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SecretModel *secretModel = _modelArray[indexPath.section];
    MySecretCellLayoutFrame *layoutFrame = [[MySecretCellLayoutFrame alloc]initWithSecretModel:secretModel];
    cell.layoutFrame = layoutFrame;
    
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SecretModel *secretModel = _modelArray[indexPath.section];
    MySecretCellLayoutFrame *layoutFrame = [[MySecretCellLayoutFrame alloc]initWithSecretModel:secretModel];
    return layoutFrame.cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        return CGFLOAT_MIN;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SecretModel *secretModel = _modelArray[indexPath.section];
    AnswerViewController *vc = [[AnswerViewController alloc]init];
    vc.questionID = secretModel.questionId;
    vc.previousVC = NSStringFromClass([self.viewController class]);
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (void)setModelArray:(NSArray *)modelArray{
    _modelArray = modelArray;
    [self reloadData];
}

@end
