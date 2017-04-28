//
//  TagView.m
//  Zimu
//
//  Created by Redpower on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "TagView.h"
#import "TagCollectionView.h"

@interface TagView ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) TagCollectionView *tagCollectionView;

@end

@implementation TagView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = themeWhite;
        [self setupHeaderView];
        [self setupTagCollectionView];
    }
    return self;
}

- (void)setupHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 35)];
    [self addSubview:_headerView];
    
    //竖线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 5, 20)];
    lineView.centerY = _headerView.centerY;
    lineView.backgroundColor = themeYellow;
    [_headerView addSubview:lineView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame) + 5, 10, self.width/2.0, 20)];
    titleLabel.centerY = _headerView.centerY;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor colorWithHexString:@"222222"];
    titleLabel.text = @"标签选择(最多选3个)";
    [_headerView addSubview:titleLabel];
}

- (void)setupTagCollectionView{
    _tagCollectionView = [[TagCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame) + 10, self.width, 65) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    _tagCollectionView.showsVerticalScrollIndicator = NO;
    _tagCollectionView.backgroundColor = themeWhite;
    NSArray *array = @[@"抑郁",@"孩子叛逆",@"教养方法",@"懦弱",@"不爱学习",@"离异",@"性格内向",@"胆小",@"脾气暴躁",@"注意力分散"];
    _tagCollectionView.tagArray = array;
    [self addSubview:_tagCollectionView];
}


- (NSString *)tagText{
    NSMutableString *tagString = [NSMutableString string];
    for (int index = 0; index < _tagCollectionView.selectTagArray.count; index++) {
        NSString *text = _tagCollectionView.selectTagArray[index];
        [tagString appendString:text];
    }
    return tagString;
}


@end
