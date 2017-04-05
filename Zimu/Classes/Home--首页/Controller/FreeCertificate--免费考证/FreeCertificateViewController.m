//
//  FreeCertificateViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/30.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FreeCertificateViewController.h"
#import "FreeCertificateTableView.h"

@interface FreeCertificateViewController ()

@property (nonatomic, strong) FreeCertificateTableView *freeCertificateTableView;
@property (nonatomic, strong) UIButton *askButton;

@end

@implementation FreeCertificateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"免费考证";
    self.view.backgroundColor = themeWhite;
    
    [self.view addSubview:self.freeCertificateTableView];
    
    [self.view addSubview:self.askButton];
}


/**
 *  创建freeCertificateTableView
 */
- (FreeCertificateTableView *)freeCertificateTableView{
    if (!_freeCertificateTableView) {
        _freeCertificateTableView = [[FreeCertificateTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _freeCertificateTableView.backgroundColor = themeGray;
    }
    return _freeCertificateTableView;
}

/**
 *  创建askButton
 */
- (UIButton *)askButton{
    if (!_askButton) {
        _askButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat width = 60 / 320.0 * kScreenWidth;
        _askButton.frame = CGRectMake(kScreenWidth - width, kScreenHeight * 0.7, width, width);
        [_askButton setBackgroundColor:[UIColor colorWithHexString:@"fedb18"]];
        _askButton.layer.cornerRadius = width/2.0;
        _askButton.layer.shadowColor = [UIColor blackColor].CGColor;
        _askButton.layer.shadowRadius = width/2.0;
        _askButton.layer.shadowOpacity = 0.33;
        _askButton.layer.shadowOffset = CGSizeMake(0, 1.5);
        
        UIImageView *askImageView = [[UIImageView alloc]initWithFrame:CGRectMake((_askButton.width - 15)/2.0, _askButton.height/2.0 - 15 - 2.5, 15, 15)];
        askImageView.image = [UIImage imageNamed:@"home_tiwen"];
        [_askButton addSubview:askImageView];
        UILabel *askLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _askButton.height/2.0 + 2.5, _askButton.width, 15)];
        askLabel.text = @"我要提问";
        askLabel.font = [UIFont systemFontOfSize:12];
        askLabel.textColor = themeWhite;
        askLabel.textAlignment = NSTextAlignmentCenter;
        [_askButton addSubview:askLabel];
        
        [_askButton addTarget:self action:@selector(askButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _askButton;
}

- (void)askButtonAction{
    NSLog(@"我要提问");
}
    


@end
