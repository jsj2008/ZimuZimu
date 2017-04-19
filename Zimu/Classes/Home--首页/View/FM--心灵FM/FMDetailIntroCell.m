//
//  FMDetailIntroCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMDetailIntroCell.h"

@interface FMDetailIntroCell ()

@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *openButton;
- (IBAction)openButton:(id)sender;


@end

@implementation FMDetailIntroCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setIntroLayoutFrame:(FMDetailIntroLayoutFrame *)introLayoutFrame{
    if (_introLayoutFrame != introLayoutFrame) {
        _introLayoutFrame = introLayoutFrame;
        
        _markLabel.frame = introLayoutFrame.markLabelFrame;
        _markLabel.text = @"内容简介";
        
        _contentLabel.text = @"北京夏茉教育咨询有限公司的前身为本心文化传播（上海）有限公司。子慕，提供多元化的家庭情感咨询定制化服务。也是国内唯一集情感咨询、情感维护、家庭类视频制作、情感电台、书籍发行、落地式亲子活动、国家家庭教育政府项目采购、国际性幸福论坛、中国亲子家庭教育资格认定于一体的情感咨询幸福产业缔造者。";
        _contentLabel.frame = introLayoutFrame.contentLabelFrame;
        _openButton.frame = introLayoutFrame.openButtonFrame;
        
    }
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        [_openButton setImage:[UIImage imageNamed:_imageString] forState:UIControlStateNormal];
    }
}


- (IBAction)openButton:(id)sender {
    
    [self.delegate openCellContentLayout];
    
}


@end
