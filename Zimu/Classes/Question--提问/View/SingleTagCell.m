//
//  SingleTagCell.m
//  Zimu
//
//  Created by Redpower on 2017/6/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SingleTagCell.h"

@interface SingleTagCell ()

@property (nonatomic, strong) UILabel *tagLabel;

@end

@implementation SingleTagCell

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
    _tagLabel = [[UILabel alloc]init];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    UIColor *color = [UIColor colorWithHexString:@"F5CD13"];
    _tagLabel.textColor = color;
    _tagLabel.font = [UIFont systemFontOfSize:11];
    _tagLabel.layer.masksToBounds = YES;
    _tagLabel.layer.borderColor = color.CGColor;
    _tagLabel.layer.borderWidth = 1;
    [self.contentView addSubview:_tagLabel];
}

- (void)setTagText:(NSString *)tagText{
    _tagLabel.text = tagText;
    CGSize size = [tagText sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _tagLabel.frame = CGRectMake(10, 10, size.width + 15, size.height + 10);
    _tagLabel.layer.cornerRadius = _tagLabel.height/2.0;
}

@end
