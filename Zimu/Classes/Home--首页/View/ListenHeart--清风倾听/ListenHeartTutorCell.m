//
//  ListenHeartTutorCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/15.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ListenHeartTutorCell.h"
#import "UIImage+ZMExtension.h"

@interface ListenHeartTutorCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *certificateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel1;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel2;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel3;
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;


@end

@implementation ListenHeartTutorCell

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
    
    //导师资质
    NSString *certificateString = @"国家二级认证咨询师";
    _certificateLabel.text = certificateString;
    CGSize certificateSize = [certificateString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
    _certificateLabel.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame) + 10, CGRectGetMinY(_nameLabel.frame) - (certificateSize.height + 10 - nameSize.height), certificateSize.width + 10, certificateSize.height + 10);
    _certificateLabel.layer.cornerRadius = 5;
    _certificateLabel.layer.masksToBounds = YES;
    _certificateLabel.layer.borderWidth = 1.0f;
    _certificateLabel.layer.borderColor = [UIColor colorWithHexString:@"FBBF38"].CGColor;
    _certificateLabel.textColor = [UIColor colorWithHexString:@"FBBF38"];
    
    //标签1
    NSString *tagString1 = @"亲子";
    _tagLabel1.text = tagString1;
    CGSize tagSize1 = [tagString1 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _tagLabel1.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_headImageView.frame) - tagSize1.height - 5, tagSize1.width, tagSize1.height);

    //标签2
    NSString *tagString2 = @"家庭";
    _tagLabel2.text = tagString2;
    CGSize tagSize2 = [tagString2 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _tagLabel2.frame = CGRectMake(CGRectGetMaxX(_tagLabel1.frame) + 15, CGRectGetMinY(_tagLabel1.frame), tagSize2.width, tagSize2.height);
    
    //标签1
    NSString *tagString3 = @"育儿";
    _tagLabel3.text = tagString3;
    CGSize tagSize3 = [tagString3 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _tagLabel3.frame = CGRectMake(CGRectGetMaxX(_tagLabel2.frame) + 15, CGRectGetMinY(_tagLabel1.frame), tagSize3.width, tagSize3.height);
    
    //关注
    NSString *attentionString = @"关注";
    [_attentionButton setTitle:attentionString forState:UIControlStateNormal];
    [_attentionButton setTitleColor:themeWhite forState:UIControlStateNormal];
    CGSize attentionSize = [attentionString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _attentionButton.frame = CGRectMake(self.width - attentionSize.width - 30, (self.height - attentionSize.height - 10)/2.0, attentionSize.width + 20, attentionSize.height + 10);
    _attentionButton.layer.cornerRadius = 5;
    _attentionButton.layer.masksToBounds = YES;
    [_attentionButton setBackgroundColor:themeBlue];
    
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _headImageView.image = [UIImage imageNamed:_imageString];
    }
}

@end
