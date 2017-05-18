//
//  SearchFriendMyMsgCell.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchFriendMyMsgCell : UITableViewCell
//必须调用这个方法
- (void)setName:(NSString *)name idStr:(NSString *)idString age:(NSInteger)age imgUrlString:(NSString *)urlStr;
@end
