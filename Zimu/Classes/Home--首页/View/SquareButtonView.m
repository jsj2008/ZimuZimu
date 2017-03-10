//
//  SquareButtonView.m
//  Zimu
//
//  Created by Redpower on 2017/2/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SquareButtonView.h"
#import "Masonry.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SquareButtonView ()

@property (nonatomic, strong) UIButton *examApplyButton;      //考试报名按钮
@property (nonatomic, strong) UIButton *questionAnswerButton;      //试题解答
@property (nonatomic, strong) UIButton *openCourseButton;   //公开课程
@property (nonatomic, strong) UIButton *publicBenefitButton;    //公益众筹

@end

@implementation SquareButtonView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.examApplyButton];
    [self addSubview:self.questionAnswerButton];
    [self addSubview:self.openCourseButton];
    [self addSubview:self.publicBenefitButton];
    
    //布局
    [_examApplyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(5);
        make.top.equalTo(self.mas_top).with.offset(5);
        make.bottom.equalTo(self.mas_centerY).with.offset(-2.5);
        make.right.equalTo(self.mas_centerX).with.offset(-2.5);
    }];
    
    [_questionAnswerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).with.offset(2.5);
        make.top.equalTo(_examApplyButton.mas_top);
        make.bottom.equalTo(_examApplyButton.mas_bottom);
        make.right.equalTo(self.mas_right).with.offset(-5);
    }];
    
    [_openCourseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_examApplyButton.mas_left);
        make.top.equalTo(self.mas_centerY).with.offset(2.5);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
        make.width.equalTo(_examApplyButton.mas_width);
    }];
    
    [_publicBenefitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_questionAnswerButton.mas_left);
        make.top.equalTo(_openCourseButton.mas_top);
        make.bottom.equalTo(_openCourseButton.mas_bottom);
        make.right.equalTo(_questionAnswerButton.mas_right);
    }];
    [self layoutIfNeeded];
    _examApplyButton.layer.cornerRadius = 5;
    _examApplyButton.layer.masksToBounds = YES;
    
    _questionAnswerButton.layer.cornerRadius = 5;
    _questionAnswerButton.layer.masksToBounds = YES;
    
    _openCourseButton.layer.cornerRadius = 5;
    _openCourseButton.layer.masksToBounds = YES;
    
    _publicBenefitButton.layer.cornerRadius = 5;
    _publicBenefitButton.layer.masksToBounds = YES;
}


/**
 *  考试报名
 */
- (UIButton *)examApplyButton{
    if (!_examApplyButton) {
        _examApplyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_examApplyButton setImage:[UIImage imageNamed:@"cycle_01.jpg"] forState:UIControlStateNormal];
        [[_examApplyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.delegate examApply];
        }];
    }
    return _examApplyButton;
}

/**
 *  试题解答
 */
- (UIButton *)questionAnswerButton{
    if (!_questionAnswerButton) {
        _questionAnswerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_questionAnswerButton setImage:[UIImage imageNamed:@"cycle_02.jpg"] forState:UIControlStateNormal];
        [[_questionAnswerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.delegate questionAnswer];
        }];
    }
    return _questionAnswerButton;
}

/**
 *  公开课程
 */
- (UIButton *)openCourseButton{
    if (!_openCourseButton) {
        _openCourseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_openCourseButton setImage:[UIImage imageNamed:@"cycle_03.jpg"] forState:UIControlStateNormal];
        [[_openCourseButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.delegate openCourse];
        }];
    }
    return _openCourseButton;
}

/**
 *  公益众筹
 */
- (UIButton *)publicBenefitButton{
    if (!_publicBenefitButton) {
        _publicBenefitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publicBenefitButton setImage:[UIImage imageNamed:@"cycle_04.jpg"] forState:UIControlStateNormal];
        [[_publicBenefitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.delegate publicBenefit];
        }];
    }
    return _publicBenefitButton;
}

@end
