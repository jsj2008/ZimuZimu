//
//  BookSectionCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BookSectionCell.h"

@interface BookSectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BookSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
