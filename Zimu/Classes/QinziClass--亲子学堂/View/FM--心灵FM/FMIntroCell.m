//
//  FMIntroCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMIntroCell.h"

@interface FMIntroCell ()

@property (nonatomic, strong) UILabel *titleLabel;      //标题
@property (nonatomic, strong) UILabel *flagLabel;       //标签&时间
@property (nonatomic, strong) UILabel *introLabel;      //介绍

@end

@implementation FMIntroCell

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
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    //标题
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor colorWithHexString:@"222222"];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    //标签&时间
    _flagLabel = [[UILabel alloc]init];
    _flagLabel.font = [UIFont systemFontOfSize:12];
    _flagLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:_flagLabel];
    
    //介绍
    _introLabel = [[UILabel alloc]init];
    _introLabel.font = [UIFont systemFontOfSize:13];
    _introLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _introLabel.numberOfLines = 2;
    [self.contentView addSubview:_introLabel];
    
}

//FM
- (void)setFMlayoutFrame:(FMIntroCellLayoutFrame *)FMlayoutFrame{
    //标题
    _titleLabel.frame = FMlayoutFrame.titleLabelFrame;
    _titleLabel.text = FMlayoutFrame.fmDetailModel.fmTitle;
    
    //标签&时间
    _flagLabel.frame = FMlayoutFrame.flagLabelFrame;
    _flagLabel.text = [NSString stringWithFormat:@"#%@",FMlayoutFrame.fmDetailModel.keyWord];//@"#家庭教养";
    
    //介绍
    _introLabel.frame = FMlayoutFrame.introLabelFrame;
    _introLabel.text = FMlayoutFrame.fmDetailModel.fmProfile;
    
}

//视频
- (void)setVideolayoutFrame:(FMIntroCellLayoutFrame *)videolayoutFrame{
    //标题
    _titleLabel.frame = videolayoutFrame.titleLabelFrame;
    _titleLabel.text = videolayoutFrame.videoDetailModel.videoTitle;
    
    //标签&时间
    _flagLabel.frame = videolayoutFrame.flagLabelFrame;
    _flagLabel.text = [NSString stringWithFormat:@"#%@",videolayoutFrame.videoDetailModel.keyWord];//@"#家庭教养";
    
    //介绍
    _introLabel.frame = videolayoutFrame.introLabelFrame;
    _introLabel.text = videolayoutFrame.videoDetailModel.videoProfile;
}

@end
