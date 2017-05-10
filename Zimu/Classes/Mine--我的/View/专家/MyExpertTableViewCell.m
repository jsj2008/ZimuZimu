//
//  ExpertTableViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MyExpertTableViewCell.h"

@interface MyExpertTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView    *headImageView;         //头像
@property (weak, nonatomic) IBOutlet UILabel        *nameLabel;             //姓名
@property (weak, nonatomic) IBOutlet UILabel        *tagLabel1;             //标签1
@property (weak, nonatomic) IBOutlet UILabel        *tagLabel2;             //标签2
@property (weak, nonatomic) IBOutlet UILabel        *introLabel;            //介绍
@property (weak, nonatomic) IBOutlet UIView *seperateLine;

@end

@implementation MyExpertTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _tagLabel1.layer.borderColor = themeYellow.CGColor;
    _tagLabel1.layer.borderWidth = 0.5;
    
    _tagLabel2.layer.borderColor = themeYellow.CGColor;
    _tagLabel2.layer.borderWidth = 0.5;
    
    _seperateLine.backgroundColor = themeGray;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLayoutFrame:(MyExpertCellLayoutFrame *)layoutFrame{
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        
        //头像
        _headImageView.frame = layoutFrame.headImageViewFrame;
        
        //姓名
        _nameLabel.frame = layoutFrame.nameLabelFrame;
        
        //标签1
        _tagLabel1.frame = layoutFrame.tagLabel1Frame;
        _tagLabel1.layer.cornerRadius = _tagLabel1.height / 2.0;
        _tagLabel1.layer.masksToBounds = YES;
        
        //标签2
        _tagLabel2.frame = layoutFrame.tagLabel2Frame;
        _tagLabel2.layer.cornerRadius = _tagLabel2.height / 2.0;
        _tagLabel2.layer.masksToBounds = YES;
        
        //介绍
        _introLabel.frame = layoutFrame.introLabelFrame;
        
        //分割线
        _seperateLine.frame = layoutFrame.seperateLineFrame;
        
    }
}

@end
