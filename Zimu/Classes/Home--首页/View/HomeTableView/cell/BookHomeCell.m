//
//  BookHomeCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BookHomeCell.h"
#import "UIImage+ZMExtension.h"

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

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    UIImage *image = _bookImageView.image;
//    image = [image imageAddCornerWithRadious:5 size:_bookImageView.size];
//    _bookImageView.image = image;
    
    _bookImageView.clipsToBounds = YES;
    _bookImageView.layer.cornerRadius = 5;
    _bookImageView.layer.masksToBounds = YES;
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _bookImageView.image = [UIImage imageNamed:_imageString];;
    }
}


- (void)setHomeArticleItem:(HomeArticleItems *)homeArticleItem{
    if (_homeArticleItem != homeArticleItem) {
        _homeArticleItem = homeArticleItem;
        
        _titleLabel.text = homeArticleItem.articleTitle;
        _contentLabel.text = homeArticleItem.articleAbs;
        _saleCountLabel.text = [NSString stringWithFormat:@"阅读量:%li",homeArticleItem.readNum];
        _authorLabel.text = [NSString stringWithFormat:@"作者:%@",homeArticleItem.userName];
    }
}



@end
