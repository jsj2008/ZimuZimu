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

#import "UIView+ViewController.h"
#import "ExamApplyViewController.h"
#import "OpenCourseViewController.h"
#import "QuestionAnswerViewController.h"
#import "CityCourseViewController.h"
#import "FreeCertificateViewController.h"

@interface SquareButtonView ()

@property (nonatomic, strong) UIButton *examApplyButton;      //考试报名按钮    一城一课
@property (nonatomic, strong) UIButton *questionAnswerButton;      //试题解答  免费考证
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
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
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
//    _examApplyButton.layer.cornerRadius = 5;
//    _examApplyButton.layer.masksToBounds = YES;
    [_examApplyButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    _examApplyButton.imageView.clipsToBounds = YES;
    
//    _questionAnswerButton.layer.cornerRadius = 5;
//    _questionAnswerButton.layer.masksToBounds = YES;
    [_questionAnswerButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    _questionAnswerButton.imageView.clipsToBounds = YES;
    
//    _openCourseButton.layer.cornerRadius = 5;
//    _openCourseButton.layer.masksToBounds = YES;
    [_openCourseButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    _openCourseButton.imageView.clipsToBounds = YES;
    
//    _publicBenefitButton.layer.cornerRadius = 5;
//    _publicBenefitButton.layer.masksToBounds = YES;
    [_publicBenefitButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    _publicBenefitButton.imageView.clipsToBounds = YES;
}

/**
 *  一城一课
 */
- (UIButton *)examApplyButton{
    if (!_examApplyButton) {
        _examApplyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_examApplyButton setBackgroundImage:[UIImage imageNamed:@"home_yichengyike"] forState:UIControlStateNormal];
        [[_examApplyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//            [self.viewController.navigationController pushViewController:[[ExamApplyViewController alloc]init] animated:YES];
            [self.viewController.navigationController pushViewController:[[CityCourseViewController alloc]init] animated:YES];
        }];
    }
    return _examApplyButton;
}

/**
 *  免费考证
 */
- (UIButton *)questionAnswerButton{
    if (!_questionAnswerButton) {
        _questionAnswerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_questionAnswerButton setBackgroundImage:[UIImage imageNamed:@"home_mianfeikaozheng"] forState:UIControlStateNormal];
        [[_questionAnswerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//            [self.viewController.navigationController pushViewController:[[QuestionAnswerViewController alloc]init] animated:YES];
            [self.viewController.navigationController pushViewController:[[FreeCertificateViewController alloc]init] animated:YES];
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
        [_openCourseButton setBackgroundImage:[UIImage imageNamed:@"home_gongkaike"] forState:UIControlStateNormal];
        [[_openCourseButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.viewController.navigationController pushViewController:[[OpenCourseViewController alloc]init] animated:YES];
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
        [_publicBenefitButton setBackgroundImage:[UIImage imageNamed:@"home_zhongchou"] forState:UIControlStateNormal];
        [[_publicBenefitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.viewController.navigationController pushViewController:[[QuestionAnswerViewController alloc]init] animated:YES];
        }];
    }
    return _publicBenefitButton;
}

@end
