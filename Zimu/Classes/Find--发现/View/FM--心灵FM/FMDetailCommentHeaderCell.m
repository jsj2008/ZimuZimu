//
//  FMDetailCommentHeaderCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/1.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMDetailCommentHeaderCell.h"

@interface FMDetailCommentHeaderCell ()

@property (weak, nonatomic) IBOutlet UIView *markView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *seperateLine;

- (IBAction)commentButton:(id)sender;


@end

@implementation FMDetailCommentHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _commentButton.layer.cornerRadius = _commentButton.height/2.0;
    _commentButton.layer.masksToBounds = YES;
    _commentButton.backgroundColor = themeGray;
    
    _seperateLine.backgroundColor = themeGray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)commentButton:(id)sender {
    NSLog(@"去评论");
}
@end
