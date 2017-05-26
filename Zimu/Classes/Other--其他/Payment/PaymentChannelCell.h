//
//  PaymentChannelCell.h
//  Zimu
//
//  Created by Redpower on 2017/4/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentChannelCell : UITableViewCell

@property (nonatomic, copy) NSString *channelString;
@property (nonatomic, copy) NSString *channel;                  //支付方式  wx/alipay
@property (nonatomic, copy) NSString *imageString;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;        //选择按钮


@end
