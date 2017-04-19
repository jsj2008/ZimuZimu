//
//  SearchHeaderCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SearchHeaderCell.h"

@interface SearchHeaderCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation SearchHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
