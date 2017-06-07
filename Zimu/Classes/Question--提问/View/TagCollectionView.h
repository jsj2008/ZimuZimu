//
//  TagCollectionView.h
//  Zimu
//
//  Created by Redpower on 2017/3/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagCollectionView : UICollectionView

@property (nonatomic, strong) NSArray *tagArray;
@property (nonatomic, strong) NSMutableArray *selectTagArray;


@property (nonatomic, copy) NSString *selectTagId;      //选择的tag的ID
@property (nonatomic, strong) NSArray *tagModelArray;
@property (nonatomic, strong) NSMutableArray *selectModelArray;


@end
