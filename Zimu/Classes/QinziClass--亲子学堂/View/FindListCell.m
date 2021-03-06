//
//  FindListCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindListCell.h"
#import "UIImageView+WebCache.h"

@interface FindListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *countButton;

@property (nonatomic, copy) NSString *flagImageString;

@end

@implementation FindListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self draw];
}

- (void)draw{
    
    //背景图
    _bgImageView.frame = CGRectMake(0, 0, self.width, self.height);
    
    //标签
    _flagImageView.image = [UIImage imageNamed:_flagImageString];
    _flagImageView.frame = CGRectMake(self.width - 10 - _flagImageView.image.size.width, 10, _flagImageView.image.size.width, _flagImageView.image.size.height);
    
    //标题
    CGFloat titleWidth = 125 * kScreenWidth / 375.0;
    _titleLabel.numberOfLines = 2;
    _titleLabel.frame = CGRectMake(self.width - titleWidth - 25, (self.height - 50)/2.0, titleWidth, 50);
    
    //查看数
    CGSize size = [_countString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    size.height = 20;
    size.width = size.width + 20;
    _countButton.frame = CGRectMake(self.width - size.width - 10, self.height - 10 - size.height, size.width, size.height);
}


//cell类型
- (void)setFindCellType:(FindCellType)findCellType{
    _findCellType = findCellType;
    switch (findCellType) {
        case FindCellTypeArticle:       //文章
            _flagImageString = @"find_article_icon";
            
            break;
            
        case FindCellTypeFM:            //FM
            _flagImageString = @"find_FM_icon";
            
            break;
            
        case FindCellTypeVideo:         //视频
            _flagImageString = @"find_video_icon";
            
            break;
    }
}


- (void)setModel:(ParentSchoolItem *)model{
    if (_model != model) {
        _model = model;
        
        //标题
        _titleLabel.text = model.title;
        
        //背景图
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imagePrefixURL,model.picture]];
        [_bgImageView sd_setImageWithURL:imageURL];
        
        //类型
        int type = [model.type intValue];
        self.findCellType = type;
        
        //数量
        _countString = [NSString stringWithFormat:@" %li",model.readtimes];
        [_countButton setTitle:_countString forState:UIControlStateNormal];
        
        [self draw];
    }
}

@end
