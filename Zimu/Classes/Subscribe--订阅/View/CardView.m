//
//  CardView.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "CardView.h"
#import "UIImage+ZMExtension.h"
#import "UIView+ViewController.h"
#import "SubscribeDetailViewController.h"
#import "TagCollectionView.h"
#import "RecommendExpertDetailViewController.h"

@interface CardView ()

@property (nonatomic, strong) UIView *contentView;      //内容视图
@property (nonatomic, strong) UIImageView *imageView;   //导师图片
@property (nonatomic, strong) UILabel *introLabel;      //导师介绍
@property (nonatomic, strong) UIView *lineView;         //分割线
@property (nonatomic, strong) TagCollectionView *tagCollectionView; //导师标签

@end

@implementation CardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // Shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.33;
    self.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.layer.shadowRadius = 4.0;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // Corner Radius
    self.layer.cornerRadius = 10.0;
    
    [self addSubview:self.contentView];
    
    [_contentView addSubview:self.imageView];
    [_contentView addSubview:self.introLabel];
    [_contentView addSubview:self.lineView];
    [_contentView addSubview:self.tagCollectionView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}

//contentView
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:self.bounds];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.layer.cornerRadius = 10;
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}

//imageView
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width * 0.7)];
        UIImage *image = [UIImage imageNamed:@"home_zhuanlandingyue1"];
        _imageView.image = image;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}


//introLabel
- (UILabel *)introLabel{
    if (!_introLabel) {
        _introLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_imageView.frame) + 10, self.width - 30, 40)];
        _introLabel.text = @"一句话描述讲师，比如没有什么问题是解决不了的，没有什么问题是不能解决的";
        _introLabel.font = [UIFont systemFontOfSize:14];
        _introLabel.textColor = [UIColor lightGrayColor];
        _introLabel.textAlignment = NSTextAlignmentCenter;
        _introLabel.numberOfLines = 2;
    }
    return _introLabel;
}

//lineView
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_introLabel.frame) + 10, self.width - 30, 1)];
        _lineView.backgroundColor = themeGray;
    }
    return _lineView;
}

//tagCollectionView
- (TagCollectionView *)tagCollectionView{
    if (!_tagCollectionView) {
        _tagCollectionView = [[TagCollectionView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_lineView.frame) + 10, self.width - 30, self.height - CGRectGetMaxY(_lineView.frame) - 20) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
//        _tagCollectionView.userInteractionEnabled = NO;
        _tagCollectionView.showsVerticalScrollIndicator = NO;
        _tagCollectionView.backgroundColor = themeWhite;
        NSArray *tagArray = @[@"抑郁",@"孩子叛逆",@"教养方法",@"懦弱",@"不爱学习",@"离异",@"性格内向",@"胆小",@"脾气暴躁",@"注意力分散"];
        _tagCollectionView.tagArray = tagArray;
    }
    return _tagCollectionView;
}


- (void)tapAction{
    NSLog(@"别碰我 %li", _index);
    [self.viewController.navigationController pushViewController:[[RecommendExpertDetailViewController alloc]init] animated:YES];
}


- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _imageView.image = [UIImage imageNamed:_imageString];
    }
}

@end
