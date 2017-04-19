//
//  BooksTableViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BooksTableViewCell.h"

@interface BooksTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *booksImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkDetailLabel;



@end

@implementation BooksTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _booksImageView.image = [UIImage imageNamed:@"cycle_01.jpg"];
    _titleLabel.text = @"《孩子叛逆的时候，你该怎么办？》";
    _titleLabel.textColor = themeBlack;
    _contentLabel.text = @"文字补丁文字补丁文字补丁文字补丁文字补丁文字补丁文字补丁文字补丁文字补丁文字补丁文字补丁文字补丁文字补丁文字补丁文字补丁文字补丁文字补丁文字补丁文字补丁";
    _checkDetailLabel.text = @"查看详情>";
    
}


@end
