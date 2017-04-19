//
//  ListenHeartDynamicCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ListenHeartDynamicCell.h"
#import "DynamicTextTableView.h"

@interface ListenHeartDynamicCell ()

@property (weak, nonatomic) IBOutlet DynamicTextTableView *dynamicTextTableView;


@end

@implementation ListenHeartDynamicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTextArray:(NSArray *)textArray{
    if (_textArray != textArray) {
        _textArray = textArray;
        _dynamicTextTableView.textArray = (NSMutableArray *)textArray;
    }
}

@end
