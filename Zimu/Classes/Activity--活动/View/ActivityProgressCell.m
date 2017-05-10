//
//  ActivityProgressCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityProgressCell.h"
#import "ZMSlider.h"
#import "ActivityMemberCollectionView.h"

@interface ActivityProgressCell ()

@property (nonatomic, strong) ZMSlider *progressView;       //进度条
@property (nonatomic, strong) ActivityMemberCollectionView *memberCollectionView;   //头像
@property (nonatomic, strong) UILabel *memberCountLabel;        //已报名人数

@end

@implementation ActivityProgressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    //进度条
    _progressView = [[ZMSlider alloc]initWithFrame:CGRectMake(30, 30, kScreenWidth - 60, 10)];
    _progressView.userInteractionEnabled = NO;
    _progressView.currentValueColor = [UIColor colorWithHexString:@"F5CE13"];
    _progressView.maxValue = 500;
    _progressView.currentSliderValue = 200;
    _progressView.circleViewColor = [UIColor colorWithHexString:@"F5CE13"];
    [self.contentView addSubview:_progressView];
    
    //头像
    _memberCollectionView = [[ActivityMemberCollectionView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_progressView.frame), CGRectGetMaxY(_progressView.frame) + 10, _progressView.width, _progressView.width/8.0) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    [self.contentView addSubview:_memberCollectionView];
    
    //已报名人数
    CGFloat labelWidth = 90*kScreenWidth/375.0;
    _memberCountLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - labelWidth)/2.0, CGRectGetMaxY(_memberCollectionView.frame) + 5, labelWidth, 25)];
    _memberCountLabel.font = [UIFont systemFontOfSize:12];
    _memberCountLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _memberCountLabel.textAlignment = NSTextAlignmentCenter;
    _memberCountLabel.layer.cornerRadius = 5.0;
    _memberCountLabel.layer.masksToBounds = self;
    _memberCountLabel.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    _memberCountLabel.layer.borderWidth = 0.5;
    _memberCountLabel.text = @"200人已报名";
    [self.contentView addSubview:_memberCountLabel];
}



@end
