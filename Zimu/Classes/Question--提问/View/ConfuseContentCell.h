//
//  ConfuseContentCell.h
//  Zimu
//
//  Created by Redpower on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfuseContentCellLayoutFrame.h"

@interface ConfuseContentCell : UITableViewCell

@property (nonatomic, strong) ConfuseContentCellLayoutFrame *layoutFrame;
//@property (nonatomic, strong) ConfuseContentCellLayoutFrame *layoutFrameNormal;

@property (nonatomic, assign) NSInteger careState;

@end
