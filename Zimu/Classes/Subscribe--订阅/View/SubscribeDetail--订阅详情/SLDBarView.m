//
//  SLDBarView.m
//  Zimu
//
//  Created by Redpower on 2017/3/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SLDBarView.h"


static NSInteger largeFont = 16;
static NSInteger midFont = 12;
static NSInteger smallFont = 11;

@interface SLDBarView ()

@end

@implementation SLDBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    /*普通状态*/
    //导师姓名
    _normalNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, self.height)];
    _normalNameLabel.text = @"吴老师";
    _normalNameLabel.textColor = themeWhite;
    _normalNameLabel.font = [UIFont systemFontOfSize:15];
    _normalNameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_normalNameLabel];
    //展开按钮
    _openButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _openButton.frame = CGRectMake(self.width - self.height, 0, self.height, self.height);
    [_openButton setImage:[UIImage imageNamed:@"yiding_xiala"] forState:UIControlStateNormal];
    [_openButton addTarget:self action:@selector(openButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_openButton];
    
    /*阴影状态*/
    _shadowBGView = [[UIView alloc]initWithFrame:self.bounds];
    _shadowBGView.backgroundColor = [UIColor clearColor];
    _shadowBGView.clipsToBounds = YES;
    [self addSubview:_shadowBGView];
    //导师姓名
    NSString *shadowNameString = @"吴老师";
    UIFont *shadowNameFont = [UIFont systemFontOfSize:largeFont];
    CGSize shadowNameSize = [shadowNameString sizeWithAttributes:@{NSFontAttributeName:shadowNameFont}];
    _shadowNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, shadowNameSize.width, shadowNameSize.height)];
    _shadowNameLabel.text = shadowNameString;
    _shadowNameLabel.textColor = themeBlack;
    _shadowNameLabel.font = shadowNameFont;
    [_shadowBGView addSubview:_shadowNameLabel];
    
    //职称
    NSString *rankString = @"国家二级心理咨询师";
    UIFont *rankFont = [UIFont systemFontOfSize:midFont];
    CGSize rankSize = [rankString sizeWithAttributes:@{NSFontAttributeName:rankFont}];
    _rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_shadowNameLabel.frame) + 10, CGRectGetMaxY(_shadowNameLabel.frame) - rankSize.height, rankSize.width, rankSize.height)];
    _rankLabel.text = rankString;
    _rankLabel.font = rankFont;
    _rankLabel.textColor = [UIColor darkGrayColor];
    [_shadowBGView addSubview:_rankLabel];
    
    //标签1
    UIFont *tagFont = [UIFont systemFontOfSize:smallFont];
    NSString *tagString1 = @"缺失";
    CGSize tagSize1 = [tagString1 sizeWithAttributes:@{NSFontAttributeName:tagFont}];
    _tagLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_shadowNameLabel.frame), CGRectGetMaxY(_shadowNameLabel.frame) + 8, tagSize1.width + 10, tagSize1.height + 5)];
    _tagLabel1.text = tagString1;
    _tagLabel1.font = tagFont;
    _tagLabel1.textAlignment = NSTextAlignmentCenter;
    _tagLabel1.textColor = [UIColor lightGrayColor];
    _tagLabel1.layer.cornerRadius = 3;
    _tagLabel1.layer.masksToBounds = YES;
    _tagLabel1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _tagLabel1.layer.borderWidth = 1.0;
    [_shadowBGView addSubview:_tagLabel1];
    
    //标签2
    NSString *tagString2 = @"叛逆";
    CGSize tagSize2 = [tagString2 sizeWithAttributes:@{NSFontAttributeName:tagFont}];
    _tagLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_tagLabel1.frame) + 15, CGRectGetMinY(_tagLabel1.frame), tagSize2.width + 10, tagSize2.height + 5)];
    _tagLabel2.text = tagString2;
    _tagLabel2.font = tagFont;
    _tagLabel2.textAlignment = NSTextAlignmentCenter;
    _tagLabel2.textColor = [UIColor lightGrayColor];
    _tagLabel2.layer.cornerRadius = 3;
    _tagLabel2.layer.masksToBounds = YES;
    _tagLabel2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _tagLabel2.layer.borderWidth = 1.0;
    [_shadowBGView addSubview:_tagLabel2];
    
    //标签3
    NSString *tagString3 = @"学习问题";
    CGSize tagSize3 = [tagString3 sizeWithAttributes:@{NSFontAttributeName:tagFont}];
    _tagLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_tagLabel2.frame) + 15, CGRectGetMinY(_tagLabel1.frame), tagSize3.width + 8, tagSize3.height + 5)];
    _tagLabel3.text = tagString3;
    _tagLabel3.font = tagFont;
    _tagLabel3.textAlignment = NSTextAlignmentCenter;
    _tagLabel3.textColor = [UIColor lightGrayColor];
    _tagLabel3.layer.cornerRadius = 3;
    _tagLabel3.layer.masksToBounds = YES;
    _tagLabel3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _tagLabel3.layer.borderWidth = 1.0;
    [_shadowBGView addSubview:_tagLabel3];
    
    //咨询数据
    NSString *dataString = @"1000人咨询过 | 99%好评";
    UIFont *dataFont = [UIFont systemFontOfSize:smallFont];
    CGSize dataSize = [dataString sizeWithAttributes:@{NSFontAttributeName:dataFont}];
    _dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_shadowNameLabel.frame), CGRectGetMaxY(_tagLabel1.frame) + 5, dataSize.width, dataSize.height)];
    _dataLabel.text = dataString;
    _dataLabel.font = dataFont;
    _dataLabel.textColor = [UIColor lightGrayColor];
    [_shadowBGView addSubview:_dataLabel];
    _shadowBGView.alpha = 0;
}

- (void)openButtonAction{
    NSLog(@"open");

    [self.delegate openSLDTableView];
}


- (void)LSDBarTransformWithSLDBarState:(SLDBarState)SLDBarState{
    switch (SLDBarState) {
        case SLDBarStateNormal:{
            
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
            self.layer.shadowColor = [UIColor clearColor].CGColor;
            self.layer.shadowOpacity = 0;
            self.layer.shadowOffset = CGSizeMake(0, 0);
            _openButton.frame = CGRectMake(self.width - 35, 0, 35, 35);
            _normalNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 35)];
            
            _normalNameLabel.hidden = NO;
            _openButton.hidden = NO;
            
            _shadowBGView.alpha = 0;
            _shadowBGView.size = CGSizeMake(self.width, self.height);
            
        }break;
            
        case SLDBarStateShadow:{
            
            self.backgroundColor = themeWhite;
            self.layer.shadowColor = [UIColor blackColor].CGColor;
            self.layer.shadowOpacity = 0.33;
            self.layer.shadowOffset = CGSizeMake(0, 1.5);
            _openButton.frame = CGRectMake(self.width - 35, 0, 35, 35);
            _normalNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 35)];

            _normalNameLabel.hidden = YES;
            _openButton.hidden = YES;
            _shadowBGView.alpha = 1;
            _shadowBGView.size = CGSizeMake(self.width, self.height);

        }break;
    }
}






@end
