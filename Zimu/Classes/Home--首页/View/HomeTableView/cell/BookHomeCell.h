//
//  BookHomeCell.h
//  Zimu
//
//  Created by Redpower on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeArticleModel.h"

@interface BookHomeCell : UITableViewCell

@property (nonatomic, copy) NSString *imageString;

@property (nonatomic, strong) HomeArticleItems *homeArticleItem;

@end
