//
//  FMDetailIntroCell.h
//  Zimu
//
//  Created by Redpower on 2017/3/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDetailIntroLayoutFrame.h"

@protocol FMDetailIntroCellDelegate <NSObject>

- (void)openCellContentLayout;

@end

@interface FMDetailIntroCell : UITableViewCell

@property (nonatomic, strong) FMDetailIntroLayoutFrame *introLayoutFrame;

@property (nonatomic, copy) NSString *imageString;

@property (nonatomic, assign) id<FMDetailIntroCellDelegate> delegate;

@end
