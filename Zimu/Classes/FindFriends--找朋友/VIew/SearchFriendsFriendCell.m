//
//  SearchFriendsFriendCell.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SearchFriendsFriendCell.h"
#import "AddFriendApi.h"
#import "MBProgressHUD+MJ.h"
#import "UIView+ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SearchFriendsFriendCell ()

@property (nonatomic, copy) NSString *idStr;
@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) NSInteger sex;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@end

@implementation SearchFriendsFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{
    _ageLabel.layer.cornerRadius = 6;
    _ageLabel.layer.borderColor = [UIColor colorWithHexString:@"f5ce13"].CGColor;
    _ageLabel.layer.borderWidth = 0.5;
    _ageLabel.layer.masksToBounds = YES;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_imgUrl] placeholderImage:[UIImage imageNamed:@"mine_head_placeholder"]];
    _nameLabel.text = _nameStr;
    if (_sex == 0) {
        _ageLabel.backgroundColor = [UIColor colorWithHexString:@"fd809d"];
        _ageLabel.text = [NSString stringWithFormat:@" 女 %zd岁 ", _age];
    }else{
        _ageLabel.backgroundColor = [UIColor colorWithHexString:@"6ab1fe"];
        _ageLabel.text = [NSString stringWithFormat:@" 男 %zd岁 ", _age];
    }
}
- (void)setName:(NSString *)name idStr:(NSString *)idString age:(NSInteger)age imgUrlString:(NSString *)urlStr sex:(NSInteger)sex{
    _idStr = idString;
    _nameStr = name;
    _imgUrl = urlStr;
    _age = age;
    _sex = sex;
}
- (void)setSex:(NSInteger)sex{
    _sex = sex;
    
}

- (IBAction)addFriendBtnAction:(id)sender {
    AddFriendApi *addFriendApi = [[AddFriendApi alloc] initWithUserId:_idStr];
    [addFriendApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络" toView:self.viewController.view];
            return ;
        }else{
            NSLog(@"添加好友结果%@", dataDic);
            if ([dataDic[@"isTrue"] integerValue] == 1) {
                [MBProgressHUD showMessage_WithoutImage:@"好友添加请求已发送" toView:self.viewController.view];
            }else{
                [MBProgressHUD showMessage_WithoutImage:@"好友添加请求发送失败" toView:self.viewController.view];
            }
//            NSArray *dataArray = dataDic[@"items"];
//            if (dataArray.count == 0) {
//                
//            }else{
//                dispatch_sync(dispatch_get_main_queue(), ^{
//                 
//                });
//            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络" toView:self.viewController.view];
    }];
}

@end
