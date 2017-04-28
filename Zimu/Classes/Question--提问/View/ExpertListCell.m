//
//  ExpertListCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExpertListCell.h"
#import "UIImage+ZMExtension.h"

@interface ExpertListCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel1;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel2;
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;

@end

@implementation ExpertListCell

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
    
    //头像
    _headImageView.frame = CGRectMake(10, 10, 60, 60);
    UIImage *image = _headImageView.image;
    image = [image imageAddCornerWithRadious:_headImageView.width/2.0 size:_headImageView.size];
    _headImageView.image = image;
    
    //姓名
    NSString *nameString = @"吴老师";
    _nameLabel.text = nameString;
    CGSize nameSize = [nameString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame) + 10, CGRectGetMinY(_headImageView.frame) + 10, nameSize.width, nameSize.height);
    
    //标签1
    NSString *tagString1 = @"亲子关系";
    _tagLabel1.text = tagString1;
    CGSize tagSize1 = [tagString1 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _tagLabel1.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_headImageView.frame) - tagSize1.height - 5, tagSize1.width, tagSize1.height);
    
    
    //标签2
    NSString *tagString2 = @"叛逆";
    _tagLabel2.text = tagString2;
    CGSize tagSize2 = [tagString2 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _tagLabel2.frame = CGRectMake(CGRectGetMaxX(_tagLabel1.frame) + 15, CGRectGetMinY(_tagLabel1.frame), tagSize2.width, tagSize2.height);
    
    
    //关注
    NSString *attentionString = @"咨询";
    [_attentionButton setTitle:attentionString forState:UIControlStateNormal];
    [_attentionButton setTitleColor:themeWhite forState:UIControlStateNormal];
    CGSize attentionSize = [attentionString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _attentionButton.frame = CGRectMake(self.width - attentionSize.width - 30 - 10, (self.height - attentionSize.height - 10)/2.0, attentionSize.width + 30, 30);
    _attentionButton.layer.cornerRadius = 5;
    _attentionButton.layer.masksToBounds = YES;
    
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _headImageView.image = [UIImage imageNamed:_imageString];
    }
}


@end
