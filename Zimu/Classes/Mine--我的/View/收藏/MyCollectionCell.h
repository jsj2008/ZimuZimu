//
//  MyCollectionCell.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ParentSchoolListModel.h"

typedef enum CollectionType{
    CollectionTypeArticle = 0,        //文章类
    CollectionTypeVideo,              //视频类
    CollectionTypeFM                  //FM类
}CollectionType;

@interface MyCollectionCell : UITableViewCell
//@property (nonatomic, copy) NSString *flagImageString;
@property (nonatomic, copy) NSString *bgImageString;
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *countString;

@property (nonatomic, assign) CollectionType collectionType;

@end
