//
//  ExpertTableViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExpertTableViewCell.h"
#import "Masonry.h"
#import "UIImage+ZMExtension.h"

static const NSInteger tagFont = 13;

@interface ExpertTableViewCell ()

@property (strong, nonatomic) UIImageView *headImageView;            //头像
@property (strong, nonatomic) UILabel *nameLabel;                    //姓名
@property (strong, nonatomic) UILabel *tagLabel1;                    //标签1
@property (strong, nonatomic) UILabel *tagLabel2;                    //标签2
@property (strong, nonatomic) UILabel *tagLabel3;                    //标签3

@property (strong, nonatomic) UIImageView *addressImageView;            //地址
@property (strong, nonatomic) UILabel *addressLabel;                   //地址
@property (nonatomic, strong) UIButton *addressButton;

@property (strong, nonatomic) UIImageView *countImageView;              //人数
@property (strong, nonatomic) UILabel *countLabel;                     //人数
@property (nonatomic, strong) UIButton *countButton;

@property (strong, nonatomic) UIImageView *percentImageView;            //好评率
@property (strong, nonatomic) UILabel *percentLabel;                   //好评率
@property (nonatomic, strong) UIButton *percentButton;

@end

@implementation ExpertTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //头像
        if (!_headImageView) {
            _headImageView = [[UIImageView alloc]init];
            _headImageView.image = [UIImage imageNamed:@"cycle_01.jpg"];
            [self.contentView addSubview:_headImageView];
//            [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self).with.offset(10);
//                make.left.equalTo(self).with.offset(10);
//                make.size.mas_equalTo(CGSizeMake(80, 80));
//            }];
//            _headImageView.image = [_headImageView.image imageAddCornerWithRadious:80/2.0 size:CGSizeMake(80, 80)];
        }
        
        //姓名
        if (!_nameLabel) {
            _nameLabel =[[UILabel alloc]init];
            _nameLabel.textColor = themeBlack;
            _nameLabel.font = [UIFont systemFontOfSize:15];
            _nameLabel.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:_nameLabel];
//            [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(_headImageView.mas_right).with.offset(10);
//                make.top.equalTo(_headImageView);
//                make.size.mas_equalTo(CGSizeMake(200, 20));
//            }];
        }
        //标签1
        if (!_tagLabel1) {
            _tagLabel1 =[[UILabel alloc]init];
            _tagLabel1.textColor = [UIColor lightGrayColor];
            _tagLabel1.layer.cornerRadius = 7;
            _tagLabel1.layer.masksToBounds = YES;
            _tagLabel1.layer.borderColor = [UIColor lightGrayColor].CGColor;
            _tagLabel1.layer.borderWidth = 0.5;
            _tagLabel1.font = [UIFont systemFontOfSize:tagFont];
            _tagLabel1.textAlignment = NSTextAlignmentCenter;
            
            [self.contentView addSubview:_tagLabel1];
            
        }
        //标签2
        if (!_tagLabel2) {
            _tagLabel2 =[[UILabel alloc]init];
            _tagLabel2.textColor = [UIColor lightGrayColor];
            _tagLabel2.layer.cornerRadius = 7;
            _tagLabel2.layer.masksToBounds = YES;
            _tagLabel2.layer.borderColor = [UIColor lightGrayColor].CGColor;
            _tagLabel2.layer.borderWidth = 0.5;
            _tagLabel2.font = [UIFont systemFontOfSize:tagFont];
            _tagLabel2.textAlignment = NSTextAlignmentCenter;
            
            [self.contentView addSubview:_tagLabel2];
            
        }
        //标签3
        if (!_tagLabel3) {
            _tagLabel3 =[[UILabel alloc]init];
            _tagLabel3.textColor = [UIColor lightGrayColor];
            _tagLabel3.layer.cornerRadius = 7;
            _tagLabel3.layer.masksToBounds = YES;
            _tagLabel3.layer.borderColor = [UIColor lightGrayColor].CGColor;
            _tagLabel3.layer.borderWidth = 0.5;
            _tagLabel3.font = [UIFont systemFontOfSize:tagFont];
            _tagLabel3.textAlignment = NSTextAlignmentCenter;
            
            [self.contentView addSubview:_tagLabel3];
            
        }
        
        //地址
        if (!_addressButton) {
            _addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_addressButton setImage:[UIImage imageNamed:@"home_meiwentuijian_icon"] forState:UIControlStateNormal];
            [_addressButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _addressButton.titleLabel.font = [UIFont systemFontOfSize:tagFont];
            [self.contentView addSubview:_addressButton];
            
        }
        //人数
        if (!_countButton) {
            _countButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_countButton setImage:[UIImage imageNamed:@"home_zhuanlandingyue_icon"] forState:UIControlStateNormal];
            [_countButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _countButton.titleLabel.font = [UIFont systemFontOfSize:tagFont];
            [self.contentView addSubview:_countButton];
            
        }
        //好评率
        if (!_percentButton) {
            _percentButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_percentButton setImage:[UIImage imageNamed:@"home_jinrituijian_icon"] forState:UIControlStateNormal];
            [_percentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _percentButton.titleLabel.font = [UIFont systemFontOfSize:tagFont];
            [self.contentView addSubview:_percentButton];
            
        }
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    _headImageView.image = [_headImageView.image imageAddCornerWithRadious:70/2.0 size:CGSizeMake(70, 70)];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).with.offset(10);
        make.top.equalTo(_headImageView);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    CGSize tagSize1 = [_tagString1 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:tagFont]}];
    [_tagLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(tagSize1.width + 10, 20));
    }];
    CGSize tagSize2 = [_tagString2 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:tagFont]}];
    [_tagLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tagLabel1.mas_right).with.offset(8);
        make.top.equalTo(_tagLabel1.mas_top);
        make.size.mas_equalTo(CGSizeMake(tagSize2.width + 10, 20));
    }];
    CGSize tagSize3 = [_tagString3 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:tagFont]}];
    [_tagLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tagLabel2.mas_right).with.offset(8);
        make.top.equalTo(_tagLabel1.mas_top);
        make.size.mas_equalTo(CGSizeMake(tagSize3.width + 10, 20));
    }];
    
    CGSize addressSize = [_address sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:tagFont]}];
    [_addressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.bottom.equalTo(self).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(addressSize.width + addressSize.height, addressSize.height));
    }];
    CGSize countSize = [_countString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:tagFont]}];
    [_countButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_addressButton.mas_right).with.offset(5);
        make.top.equalTo(_addressButton.mas_top);
        make.size.mas_equalTo(CGSizeMake(countSize.width + countSize.height, countSize.height));
    }];
    CGSize percentSize = [_percentString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:tagFont]}];
    [_percentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_countButton.mas_right).with.offset(5);
        make.top.equalTo(_addressButton.mas_top);
        make.size.mas_equalTo(CGSizeMake(percentSize.width + 20, percentSize.height));
    }];

}


- (void)setName:(NSString *)name{
    if (_name != name) {
        _name = name;
        _nameLabel.text = _name;
    }
}

- (void)setTagString1:(NSString *)tagString1{
    if (_tagString1 != tagString1) {
        _tagString1 = tagString1;
        _tagLabel1.text = _tagString1;
        
    }
}

- (void)setTagString2:(NSString *)tagString2{
    if (_tagString2 != tagString2) {
        _tagString2 = tagString2;
        _tagLabel2.text = _tagString2;
        
    }
}

- (void)setTagString3:(NSString *)tagString3{
    if (_tagString3 != tagString3) {
        _tagString3 = tagString3;
        _tagLabel3.text = _tagString3;
        
    }
}

- (void)setAddress:(NSString *)address{
    if (_address != address) {
        _address = address;
        [_addressButton setTitle:_address forState:UIControlStateNormal];
    }
}

- (void)setCountString:(NSString *)countString{
    if (_countString != countString) {
        _countString = [NSString stringWithFormat:@"%@人咨询 ",countString];
        [_countButton setTitle:_countString forState:UIControlStateNormal];
    }
}

- (void)setPercentString:(NSString *)percentString{
    if (_percentString != percentString) {
        _percentString = [percentString stringByAppendingString:@"%好评"];
        [_percentButton setTitle:_percentString forState:UIControlStateNormal];
    }
}


@end
