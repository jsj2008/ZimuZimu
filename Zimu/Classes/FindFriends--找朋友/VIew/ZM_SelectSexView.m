//
//  ZM_SelectSexView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZM_SelectSexView.h"

@interface ZM_SelectSexView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIScrollView *bgScrollView;

@property (nonatomic, strong) UIImageView *bgImgeView;

//年龄选择
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *ageBgView;
@property (nonatomic, strong) UIPickerView *ageView;

@end

@implementation ZM_SelectSexView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = themeWhite;
        
        self.sex = 0;
        self.age = 7;
        
        [self setChildViews];
        
        [self createAgeView];
    }
    return self;
}
//设置子视图 , 性别选择
- (void)setChildViews{
    _bgScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    _bgScrollView.contentSize = CGSizeMake(2 * self.width, self.height);
    _bgScrollView.scrollEnabled = NO;
    _bgScrollView.userInteractionEnabled = YES;
    _bgScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_bgScrollView];
    
    _bgImgeView = [[UIImageView alloc] initWithFrame:self.frame];
    _bgImgeView.image = [UIImage imageNamed:@"boy"];
    _bgImgeView.userInteractionEnabled = YES;
    [_bgScrollView addSubview:_bgImgeView];
    
    CGFloat width = self.width / 2;
    CGFloat height = self.height / 2.5;
    for (int i = 0; i < 2; i ++) {
        UIButton *btn = [self backItemWithImageNamed:@"" frmae:CGRectMake(i * width, self.height - height - 35, width, height) title:@"" target:self action:@selector(btnAction:)];
        btn.tag = i;
        [_bgImgeView addSubview:btn];
    }
}
- (UIButton *)backItemWithImageNamed:(NSString *)imageName frmae:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action
{
    //设置左边的按钮
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];

    btn.frame = frame;

    btn.backgroundColor = [UIColor clearColor];
    //添加  监听  btn 按钮的Events :单击 然后调用 Target:self 的Action:方法
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  btn;
}
- (void)btnAction:(UIButton *)btn{
    if (btn.tag == 0) {
        _bgImgeView.image = [UIImage imageNamed:@"boy"];
        self.sex = 0;
    }else{
        _bgImgeView.image = [UIImage imageNamed:@"girl"];
        self.sex = 1;
    }
    [UIView animateWithDuration:0.6 animations:^{
        _bgScrollView.contentOffset = CGPointMake(self.width, 0);
    }];
}

#pragma mark - ---------年龄选择------------
- (void)createAgeView{
    //年龄选择页底部视图
    _ageBgView = [[UIView alloc] initWithFrame:CGRectMake(self.width, 0, self.width, self.height)];
    _ageBgView.backgroundColor = themeWhite;
    _ageBgView.userInteractionEnabled = YES;
    [_bgScrollView addSubview:_ageBgView];
    
    //你的年龄图片
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width / 2 - 80, 30, 160, 35)];
    _imgView.image = [UIImage imageNamed:@"yourAge"];
    [_ageBgView addSubview:_imgView];
    
    //年龄选择器
    if (!_ageView) {
        _ageView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.width / 2 - 40, self.height - 65 - self.height / 2, 80, self.height / 2)];
        _ageView.delegate = self;
        _ageView.dataSource = self;
        [_ageView selectRow:7 inComponent:0 animated:NO];
    }
    //设置年龄选择器的初始位置在最右侧
    [_ageBgView addSubview:_ageView];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(self.width / 2 - 60, self.height - 45, 120, 30);
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"f5ce13"];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:themeWhite forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(msgCollectEndedAction) forControlEvents:UIControlEventTouchUpInside];
    [_ageBgView addSubview:sureBtn];
}

- (void)msgCollectEndedAction{
    [self.delegate msgCollectEndedWithSex:_sex age:_age];
    NSLog(@"%li", _age);
}
#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 16;
}
#pragma mark - delegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return 80;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}
// 返回选中的行，这是当前显示的大字的内容
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _age = row;
    NSLog(@"%zd", row);
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //富文本对象
    NSString *string = [NSString stringWithFormat:@"%li岁", row];
    CGFloat length = string.length;
     NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:string];
  
      //富文本样式
    [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                                           value:[UIColor colorWithHexString:@"f5ce13"]
                                           range:NSMakeRange(0, string.length - 1)];
//   //前面的数字字体
//    [aAttributedString addAttribute:NSFontAttributeName             //文字字体
//                                           value:[UIFont systemFontOfSize:25]
//                                           range:NSMakeRange(0, string.length - 1)];
    //后面的 岁 的字体大小
    [aAttributedString addAttribute:NSFontAttributeName             //文字字体
                              value:[UIFont systemFontOfSize:1]
                              range:NSMakeRange(0, length)];
    
    
    
    return (NSAttributedString *)aAttributedString;
}


@end
