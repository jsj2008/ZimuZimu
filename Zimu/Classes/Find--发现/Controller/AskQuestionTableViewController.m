//
//  AskQuestionTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AskQuestionTableViewController.h"
#import "AskQuestionCell.h"


static NSString *askQuestionCellIdentifier = @"AskQuestionCell";
@interface AskQuestionTableViewController (){
    NSMutableArray *_heightArray;
}

@end

@implementation AskQuestionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDataHeight];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /*注册单元格*/
    [self registerNibs];
    
}

/*注册单元格*/
- (void)registerNibs{
    [self.tableView registerNib:[UINib nibWithNibName:@"AskQuestionCell" bundle:nil] forCellReuseIdentifier:askQuestionCellIdentifier];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AskQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:askQuestionCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *modelDic = _heightArray[indexPath.section];
    cell.layoutFrame = modelDic[@"layoutFrame"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *modelDic = _heightArray[indexPath.section];
    return [modelDic[@"height"] floatValue];
}

- (void)loadDataHeight{
    _heightArray = [NSMutableArray array];
    for (int index = 0; index < 10; index++) {
        NSString *content = @"上了一堂真正的心理课，现在心情豁然开朗，终于知道这位专家为什么这么火了，都是有原因的。上了一堂真正的心理课，现在心情豁然开朗，终于知道这位专家为什么这么火了，都是有原因的。上了一堂真正的心理课，现在心情豁然开朗，终于知道这位专家为什么这么火了，都是有原因的。";
        if (index == 1) {
            content = @"上了一堂真正的心理课，现在心情豁然开朗，终于知道这位专家为什么这么火了，都是有原因的。";
        }
        AskQuestionCellLayoutFrame *layoutFrame = [[AskQuestionCellLayoutFrame alloc]initWithContent:content];
        NSNumber *height = [NSNumber numberWithFloat:layoutFrame.cellHeight];
        NSDictionary *modelDic = @{@"layoutFrame":layoutFrame,@"height":height};
        [_heightArray addObject:modelDic];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 9) {
        return CGFLOAT_MIN;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}



@end
