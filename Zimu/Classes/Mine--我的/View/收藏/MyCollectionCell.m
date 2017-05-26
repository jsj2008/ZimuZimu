//
//  MyCollectionCell.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MyCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface MyCollectionCell ()
@property (strong, nonatomic)  UIImageView *bgImageView;
@property (strong, nonatomic)  UIImageView *flagImageView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UIButton *countButton;

@property (nonatomic, copy) NSString *flagImageString;
@end

@implementation MyCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self draw];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self draw];
}

- (void)draw{
    
    //背景图
    _bgImageView = [[UIImageView alloc] init];
    _bgImageView.frame = CGRectMake(0, 0, self.width, self.height);
    [self addSubview:_bgImageView];
    //标签
    _flagImageView = [[UIImageView alloc] init];
    [self addSubview:_flagImageView];
    _flagImageView.image = [UIImage imageNamed:_flagImageString];
    _flagImageView.frame = CGRectMake(self.width - 10 - _flagImageView.image.size.width, 10, _flagImageView.image.size.width, _flagImageView.image.size.height);
    
    //标题
    _titleLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
    CGFloat titleWidth = 125 * kScreenWidth / 375.0;
    _titleLabel.frame = CGRectMake(self.width - titleWidth - 25, (self.height - 50)/2.0, titleWidth, 50);
    _titleLabel.numberOfLines = 2;
    _titleLabel.textColor = themeWhite;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    
    //查看数
    _countButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_countButton];
    
    CGSize size = [_countString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    size.height = 20;
    size.width = size.width + 20;
    _countButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _countButton.frame = CGRectMake(self.width - size.width - 10, self.height - 10 - size.height, size.width, size.height);
}


//cell类型
- (void)setCollectionType:(CollectionType)collectionType{
    _collectionType = collectionType;
    switch (_collectionType) {
        case CollectionTypeArticle:       //文章
            _flagImageString = @"find_article_icon";
            
            break;
            
        case CollectionTypeFM:            //FM
            _flagImageString = @"find_FM_icon";
            
            break;
            
        case CollectionTypeVideo:         //视频
            _flagImageString = @"find_video_icon";
            break;
        default:
            _flagImageString  = @"find_video_icon";
            break;
    }
    if (!_flagImageView) {
        [self draw];
    }
    _flagImageView.image = [UIImage imageNamed:_flagImageString];
}
- (void)setTitleString:(NSString *)titleString{
    if (titleString) {
        _titleString = titleString;
        if (!_titleLabel) {
            [self draw];
        }
        _titleLabel.text = _titleString;
    }
}

- (void)setBgImageString:(NSString *)bgImageString{
    if (bgImageString) {
        if (!_bgImageView) {
            [self draw];
        }
        _bgImageString = [imagePrefixURL stringByAppendingString:bgImageString];
        [_bgImageView sd_setImageWithURL:[NSURL URLWithString:_bgImageString]];
    }
}
- (void)setCountString:(NSString *)countString{
    if (countString) {
        if (!_countButton) {
            [self draw];
        }
        _countString = [@" " stringByAppendingString:countString];
        [_countButton setTitle:_countString forState:UIControlStateNormal];
    }
}
@end
