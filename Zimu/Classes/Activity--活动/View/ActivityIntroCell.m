//
//  ActivityIntroCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityIntroCell.h"

@interface ActivityIntroCell ()

@property (nonatomic, strong) UILabel *markLabel;
@property (nonatomic, strong) UIView *separateLine;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) UIButton *lookMoreButton;

@end

@implementation ActivityIntroCell

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
    //markLabel
    _markLabel = [[UILabel alloc]init];
    _markLabel.font = [UIFont systemFontOfSize:17];
    _markLabel.textColor = themeYellow;
    _markLabel.text = @"活动简介";
    [self.contentView addSubview:_markLabel];
    
    //分割线
    _separateLine = [[UIView alloc]init];
    _separateLine.backgroundColor = themeGray;
    [self.contentView addSubview:_separateLine];
    
    //简介内容
    _introLabel = [[UILabel alloc]init];
    _introLabel.text = @"北京夏茉教育咨询有限公司的前身为本心文化传播（上海）有限公司。子慕，提供多元化的家庭情感咨询定制化服务。也是国内唯一集情感咨询、情感维护、家庭类视频制作、情感电台、书籍发行、落地式亲子活动、国家家庭教育政府项目采购、国际性幸福论坛、中国亲子家庭教育资格认定于一体的情感咨询幸福产业缔造者。";
    _introLabel.font = [UIFont systemFontOfSize:14];
    _introLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _introLabel.numberOfLines = 0;
    [self.contentView addSubview:_introLabel];
    
    //展开查看更多
    _lookMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lookMoreButton setImage:[UIImage imageNamed:@"FM_open"] forState:UIControlStateNormal];
    [_lookMoreButton addTarget:self action:@selector(openLookMore) forControlEvents:UIControlEventTouchUpInside];
    [self .contentView addSubview:_lookMoreButton];
}

- (void)openLookMore{
    NSLog(@"展开查看更多");
    if ([self.delegate respondsToSelector:@selector(openIntroCellLayout)]) {
        [self.delegate openIntroCellLayout];
    }
}

- (void)setLayoutFrame:(ActivityIntroCellLayoutFrame *)layoutFrame{
    
    //markLabel
    _markLabel.frame = layoutFrame.markLabelFrame;
    
    //separateLine
    _separateLine.frame = layoutFrame.separateLineFrame;
    
    //introLabel
    _introLabel.frame = layoutFrame.introLabelFrame;
    
    //lookMoreButton
    _lookMoreButton.frame = layoutFrame.lookMoreButtonFrame;
    
}

//展开时不显示箭头
- (void)setIsOpening:(BOOL)isOpening{
    _isOpening = isOpening;
    if (_isOpening) {
        _lookMoreButton.hidden = YES;
    }
}



@end
