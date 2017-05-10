//
//  ActivityIntroCell.h
//  Zimu
//
//  Created by Redpower on 2017/5/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityIntroCellLayoutFrame.h"

@protocol ActivityIntroCellDelegate <NSObject>

- (void)openIntroCellLayout;

@end

@interface ActivityIntroCell : UITableViewCell

@property (nonatomic, assign) BOOL isOpening;
@property (nonatomic, strong) ActivityIntroCellLayoutFrame *layoutFrame;

@property (nonatomic, assign) id<ActivityIntroCellDelegate> delegate;

@end
