//
//  FindListCell.h
//  Zimu
//
//  Created by Redpower on 2017/4/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum FindCellType{
    FindCellTypeArticle = 0,        //文章类
    FindCellTypeFM,                 //FM类
    FindCellTypeVideo               //视频类
}FindCellType;

@interface FindListCell : UITableViewCell

@property (nonatomic, copy) NSString *bgImageString;
//@property (nonatomic, copy) NSString *flagImageString;
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *countString;

@property (nonatomic, assign) FindCellType findCellType;

@end
