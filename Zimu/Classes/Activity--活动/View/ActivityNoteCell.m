//
//  ActivityNoteCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityNoteCell.h"
#import <Masonry.h>

@interface ActivityNoteCell ()

@property (nonatomic, strong) UILabel *markLabel;
@property (nonatomic, strong) UIView *separateLine;
@property (nonatomic, strong) UILabel *noteLabel1;
@property (nonatomic, strong) UILabel *noteLabel2;
@property (nonatomic, strong) UILabel *noteLabel3;

@end

@implementation ActivityNoteCell

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
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    //markLabel
    NSString *markString = @"报名须知";
    UIFont *markFont = [UIFont systemFontOfSize:17];
    CGSize size = [markString sizeWithAttributes:@{NSFontAttributeName:markFont}];
    _markLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, size.height)];
    _markLabel.font = markFont;
    _markLabel.textColor = themeYellow;
    _markLabel.textAlignment = NSTextAlignmentLeft;
    _markLabel.text = markString;
    [self.contentView addSubview:_markLabel];
    
    //分割线
    _separateLine = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_markLabel.frame) + 10, kScreenWidth - 15, 1)];
    _separateLine.backgroundColor = themeGray;
    [self.contentView addSubview:_separateLine];
    
    UIColor *noteColor = [UIColor colorWithHexString:@"666666"];
    UIFont *noteFont = [UIFont systemFontOfSize:14];
    //note1
    NSString *noteString = @"● 邀请好友报名";
    size = [noteString sizeWithAttributes:@{NSFontAttributeName:noteFont}];
    NSMutableAttributedString *noteAttributedString = [[NSMutableAttributedString alloc]initWithString:noteString attributes:@{NSFontAttributeName:noteFont,NSForegroundColorAttributeName:noteColor}];
    [noteAttributedString addAttribute:NSForegroundColorAttributeName value:themeYellow range:NSMakeRange(0, 1)];
    [noteAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    _noteLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_separateLine.frame) + 10, size.width, size.height)];
    _noteLabel1.textAlignment = NSTextAlignmentLeft;
    _noteLabel1.attributedText = noteAttributedString;
    [self.contentView addSubview:_noteLabel1];
    
    //note2
    noteString = @"● 报名人满即可举办活动";
    size = [noteString sizeWithAttributes:@{NSFontAttributeName:noteFont}];
    noteAttributedString = [[NSMutableAttributedString alloc]initWithString:noteString attributes:@{NSFontAttributeName:noteFont,NSForegroundColorAttributeName:noteColor}];
    [noteAttributedString addAttribute:NSForegroundColorAttributeName value:themeYellow range:NSMakeRange(0, 1)];
    [noteAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    _noteLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_noteLabel1.frame) + 10, size.width, size.height)];
    _noteLabel2.textAlignment = NSTextAlignmentLeft;
    _noteLabel2.attributedText = noteAttributedString;
    [self.contentView addSubview:_noteLabel2];
    
    //note3
    noteString = @"● 人数不满原路退款";
    size = [noteString sizeWithAttributes:@{NSFontAttributeName:noteFont}];
    noteAttributedString = [[NSMutableAttributedString alloc]initWithString:noteString attributes:@{NSFontAttributeName:noteFont,NSForegroundColorAttributeName:noteColor}];
    [noteAttributedString addAttribute:NSForegroundColorAttributeName value:themeYellow range:NSMakeRange(0, 1)];
    [noteAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    _noteLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_noteLabel2.frame) + 10, size.width, size.height)];
    _noteLabel3.textAlignment = NSTextAlignmentLeft;
    _noteLabel3.attributedText = noteAttributedString;
    [self.contentView addSubview:_noteLabel3];
    
}


@end
