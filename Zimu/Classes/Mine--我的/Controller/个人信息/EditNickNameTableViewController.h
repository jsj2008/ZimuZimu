//
//  EditNickNameTableViewController.h
//  Zimu
//
//  Created by Redpower on 2017/5/2.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NickNameBlock)(NSString *);

@interface EditNickNameTableViewController : UITableViewController

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NickNameBlock nickNameBlock;

@end
