//
//  InsertCommentCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "InsertCommentCell.h"
#import <Masonry.h>

@interface InsertCommentCell ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *wordCountLabel;
@property (nonatomic, assign) NSInteger maxWordCount;

@end

@implementation InsertCommentCell

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
        _maxWordCount = 30;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _textView = [[UITextView alloc]init];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:_textView];
    
    //显示字数label
    _wordCountLabel = [[UILabel alloc]init];
    _wordCountLabel.textColor = [UIColor lightGrayColor];
    _wordCountLabel.font = [UIFont systemFontOfSize:13];
    _wordCountLabel.textAlignment = NSTextAlignmentRight;
    _wordCountLabel.text = [NSString stringWithFormat:@"%li",_maxWordCount];
    [_textView addSubview:_wordCountLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(10);
        make.top.mas_equalTo(self.mas_top);
        make.centerY.equalTo(self);
        make.right.mas_equalTo(self.mas_right).with.offset(-10);
    }];
    
    [_wordCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(-3);
    }];
}

#pragma mark - UITextView

- (void)textViewDidChange:(UITextView *)textView{
    NSInteger number = [textView.text length];
    if (number > _maxWordCount) {
        textView.text = [textView.text substringToIndex:_maxWordCount];
        number = _maxWordCount;
    }
    _wordCountLabel.text = [NSString stringWithFormat:@"%li", (_maxWordCount - number)];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
