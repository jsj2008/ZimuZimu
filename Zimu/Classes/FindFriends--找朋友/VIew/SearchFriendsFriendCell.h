//
//  SearchFriendsFriendCell.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchFriendsFriendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *addFriendBtn;
//必须调用这个方法
- (void)setName:(NSString *)name idStr:(NSString *)idString age:(NSInteger)age imgUrlString:(NSString *)urlStr sex:(NSInteger)sex;


//0 女  1男
- (void)setSex:(NSInteger)sex;

@end
