//
//  NewTagView.m
//  Zimu
//
//  Created by Redpower on 2017/5/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "NewTagView.h"
#import "TagCollectionView.h"
#import "QuestionTagModel.h"

@interface NewTagView ()

//@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) TagCollectionView *tagCollectionView;

@end

@implementation NewTagView

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
    //标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 30, self.width - 80, 20)];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = [UIColor colorWithHexString:@"222222"];
    _titleLabel.text = @"标签选择(最多选3个)";
    [self addSubview:_titleLabel];
}

- (void)setupTagCollectionView{
    _tagCollectionView = [[TagCollectionView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_titleLabel.frame) + 10, self.width - 60, 65) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    _tagCollectionView.showsVerticalScrollIndicator = NO;
    _tagCollectionView.backgroundColor = themeWhite;
    NSArray *array = [NSArray array];
    _tagCollectionView.tagArray = array;
    [self addSubview:_tagCollectionView];
}


- (NSString *)tagText{
    NSMutableString *tagString = [NSMutableString string];
    for (int index = 0; index < _tagCollectionView.selectTagArray.count; index++) {
        
        NSString *text = _tagCollectionView.selectTagArray[index];
        if (index == 0) {
            [tagString appendString:text];
        }else {
            [tagString appendString:@","];
            [tagString appendString:text];
        }
    }
    return tagString;
}

- (void)setTagModelArray:(NSArray *)tagModelArray{
    _tagModelArray = tagModelArray;
    NSMutableArray *tagStringArray = [NSMutableArray array];
    for (int index = 0; index < tagModelArray.count; index++) {
        QuestionTagModel *tagModel = tagModelArray[index];
        [tagStringArray addObject:tagModel.categoryName];
    }
    _tagCollectionView.tagArray = tagStringArray;
}


@end
