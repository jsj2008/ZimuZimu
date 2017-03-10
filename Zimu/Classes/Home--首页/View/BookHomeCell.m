//
//  BookHomeCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BookHomeCell.h"

@interface BookHomeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;


@end

@implementation BookHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _bookImageView.image = [UIImage imageNamed:@"cycle_08.jpg"];
//    _titleLabel.text = @"";
    
}



@end
