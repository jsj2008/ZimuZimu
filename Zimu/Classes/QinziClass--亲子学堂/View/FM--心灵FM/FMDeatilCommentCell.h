//
//  FMDeatilCommentCell.h
//  Zimu
//
//  Created by Redpower on 2017/4/1.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDetailCommentLayoutFrame.h"

@interface FMDeatilCommentCell : UITableViewCell

@property (nonatomic, strong) FMDetailCommentLayoutFrame *commentLayoutFrame;

/*提问：用户评论*/
@property (nonatomic, strong) FMDetailCommentLayoutFrame *userCommentLayoutFrame;

@end
