//
//  ExpertTableViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExpertTableViewCell.h"
#import "ListSelectButton.h"
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

@property (strong, nonatomic) UIImageView *countImageView;              //人数
@property (strong, nonatomic) UILabel *countLabel;                     //人数

@property (strong, nonatomic) UIImageView *percentImageView;            //好评率
@property (strong, nonatomic) UILabel *percentLabel;                   //好评率

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
            [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(10);
                make.left.equalTo(self).with.offset(10);
                make.size.mas_equalTo(CGSizeMake(60, 60));
            }];
            _headImageView.image = [_headImageView.image imageAddCornerWithRadious:60/2.0 size:CGSizeMake(60, 60)];
        }
        
        //姓名
        if (!_nameLabel) {
            _nameLabel =[[UILabel alloc]init];
            _nameLabel.textColor = themeBlack;
            _nameLabel.font = [UIFont systemFontOfSize:15];
            _nameLabel.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:_nameLabel];
            [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_headImageView.mas_right).with.offset(10);
                make.top.equalTo(_headImageView);
                make.size.mas_equalTo(CGSizeMake(200, 20));
            }];
        }
        //标签1
        if (!_tagLabel1) {
            _tagLabel1 =[[UILabel alloc]init];
            _tagLabel1.textColor = themeWhite;
            _tagLabel1.backgroundColor = themeGreen;
            _tagLabel1.layer.cornerRadius = 7;
            _tagLabel1.layer.masksToBounds = YES;
            _tagLabel1.font = [UIFont systemFontOfSize:tagFont];
            _tagLabel1.textAlignment = NSTextAlignmentCenter;
            
            [self.contentView addSubview:_tagLabel1];
            
        }
        //标签2
        if (!_tagLabel2) {
            _tagLabel2 =[[UILabel alloc]init];
            _tagLabel2.textColor = themeWhite;
            _tagLabel2.backgroundColor = themeGreen;
            _tagLabel2.layer.cornerRadius = 7;
            _tagLabel2.layer.masksToBounds = YES;
            _tagLabel2.font = [UIFont systemFontOfSize:tagFont];
            _tagLabel2.textAlignment = NSTextAlignmentCenter;
            
            [self.contentView addSubview:_tagLabel2];
            
        }
        //标签3
        if (!_tagLabel3) {
            _tagLabel3 =[[UILabel alloc]init];
            _tagLabel3.textColor = themeWhite;
            _tagLabel3.backgroundColor = themeGreen;
            _tagLabel3.layer.cornerRadius = 7;
            _tagLabel3.layer.masksToBounds = YES;
            _tagLabel3.font = [UIFont systemFontOfSize:tagFont];
            _tagLabel3.textAlignment = NSTextAlignmentCenter;
            
            [self.contentView addSubview:_tagLabel3];
            
        }
        //地址
        if (!_addressImageView) {
            _addressImageView = [[UIImageView alloc]init];
            _addressImageView.image = [UIImage imageNamed:@"tabBar_essence_icon_click"];
            [self.contentView addSubview:_addressImageView];
            
        }
        if (!_addressLabel) {
            _addressLabel =[[UILabel alloc]init];
            _addressLabel.textColor = [UIColor lightGrayColor];
            _addressLabel.font = [UIFont systemFontOfSize:tagFont];
            _addressLabel.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:_addressLabel];
            
        }
        
        
        //人数
        if (!_countImageView) {
            _countImageView = [[UIImageView alloc]init];
            _countImageView.image = [UIImage imageNamed:@"tabBar_friendTrends_icon_click"];
            [self.contentView addSubview:_countImageView];
            
        }
        if (!_countLabel) {
            _countLabel =[[UILabel alloc]init];
            _countLabel.textColor = [UIColor lightGrayColor];
            _countLabel.font = [UIFont systemFontOfSize:tagFont];
            _countLabel.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:_countLabel];
            
        }
        //好评率
        if (!_percentImageView) {
            _percentImageView = [[UIImageView alloc]init];
            _percentImageView.image = [UIImage imageNamed:@"tabBar_me_icon_click"];
            [self.contentView addSubview:_percentImageView];
            
        }
        if (!_percentLabel) {
            _percentLabel =[[UILabel alloc]init];
            _percentLabel.textColor = [UIColor lightGrayColor];
            _percentLabel.font = [UIFont systemFontOfSize:tagFont];
            _percentLabel.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:_percentLabel];
            
        }
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize tagSize1 = [_tagString1 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:tagFont]}];
    [_tagLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(3);
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
    
    [_addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_tagLabel1.mas_bottom).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    CGSize addressSize = [_address sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:tagFont]}];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_addressImageView.mas_right).with.offset(1);
        make.top.equalTo(_addressImageView.mas_top);
        make.size.mas_equalTo(CGSizeMake(addressSize.width, 20));
    }];
    
    [_countImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_addressLabel.mas_right).with.offset(5);
        make.top.equalTo(_addressImageView.mas_top);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    CGSize countSize = [_countString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:tagFont]}];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_countImageView.mas_right).with.offset(1);
        make.top.equalTo(_countImageView.mas_top);
        make.size.mas_equalTo(CGSizeMake(countSize.width, 20));
    }];
    
    [_percentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_countLabel.mas_right).with.offset(5);
        make.top.equalTo(_countLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    CGSize percentSize = [_percentString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:tagFont]}];
    [_percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_percentImageView.mas_right).with.offset(1);
        make.top.equalTo(_percentImageView.mas_top);
        make.size.mas_equalTo(CGSizeMake(percentSize.width, 20));
    }];
//    NSLog(@"x : %lf y : %lf w : %@  h : %@",_percentLabel.x,_percentLabel.y,_percentLabel.mas_width,_percentLabel.mas_height);
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
        _addressLabel.text = _address;
    }
}

- (void)setCountString:(NSString *)countString{
    if (_countString != countString) {
        _countString = [NSString stringWithFormat:@"%@人咨询 ",countString];
        _countLabel.text = _countString;
    }
}

- (void)setPercentString:(NSString *)percentString{
    if (_percentString != percentString) {
        _percentString = [percentString stringByAppendingString:@"%好评"];
        _percentLabel.text = _percentString;
    }
}


@end
