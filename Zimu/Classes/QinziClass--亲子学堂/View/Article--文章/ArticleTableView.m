//
//  ArticleTableView.m
//  Zimu
//
//  Created by Redpower on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ArticleTableView.h"
#import "FMCommentHeaderCell.h"
#import "FMCommentTableViewCell.h"
#import "FMCommentCellLayoutFrame.h"
#import "CommentModel.h"

static NSString *headerIdentifier = @"FMCommentHeaderCell";
static NSString *commentIdentifier = @"FMCommentTableViewCell";

@interface ArticleTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ArticleTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorColor = themeGray;
        [self registerClass:[FMCommentHeaderCell class] forCellReuseIdentifier:headerIdentifier];
        [self registerClass:[FMCommentTableViewCell class] forCellReuseIdentifier:commentIdentifier];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _articleCommentModelArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FMCommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.commentCount = _articleCommentModelArray.count;
        
        return cell;
    }else{
        FMCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentIdentifier];
        CommentModel *commentModel = _articleCommentModelArray[indexPath.row - 1];
        FMCommentCellLayoutFrame *layoutFrame = [[FMCommentCellLayoutFrame alloc]initWithCommentModel:commentModel];
        cell.dataCommentLayoutFrame = layoutFrame;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 35;
    }
    CommentModel *commentModel = _articleCommentModelArray[indexPath.row - 1];
    FMCommentCellLayoutFrame *layoutFrame = [[FMCommentCellLayoutFrame alloc]initWithCommentModel:commentModel];
    return layoutFrame.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (void)setArticleCommentModelArray:(NSArray *)articleCommentModelArray{
    _articleCommentModelArray = articleCommentModelArray;
    
    [self reloadData];
}

@end
