//
//  ActivityMemberCollectionViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityMemberCollectionViewCell.h"
#import <Masonry.h>

@interface ActivityMemberCollectionViewCell ()

@property (nonatomic, strong) UIImageView *coverImageView;      //圆角覆盖图
@property (nonatomic, strong) UIImageView *headerImageView;     //头像

@end

@implementation ActivityMemberCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    //头像
    _headerImageView = [[UIImageView alloc]init];
    _headerImageView.image = [UIImage imageNamed:@"home_FM1"];
    [self.contentView addSubview:_headerImageView];
    
    //圆角覆盖图
    _coverImageView = [[UIImageView alloc]init];
    _coverImageView.image = [UIImage imageNamed:@"cycle_head"];
    [self.contentView addSubview:_coverImageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //头像
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(self.mas_width).with.offset(-10);
        make.height.equalTo(self.mas_height).with.offset(-10);
    }];
    
    //圆角覆盖图
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_headerImageView);
        make.size.equalTo(_headerImageView);
    }];
    
}

@end
