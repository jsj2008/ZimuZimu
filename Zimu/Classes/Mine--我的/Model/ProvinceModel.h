//
//  ProvinceModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel :NSObject
@property (nonatomic , copy) NSString              * first;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * shortName;         //省份简称
@property (nonatomic , copy) NSString              * position;
@property (nonatomic , copy) NSString              * prevId;
@property (nonatomic , copy) NSString              * jianpin;           //省份名简拼
@property (nonatomic , copy) NSString              * pinyin;            //省份名拼音
@property (nonatomic , copy) NSString              * lat;
@property (nonatomic , assign) NSInteger             level;
@property (nonatomic , copy) NSString              * areaName;          //省份名
@property (nonatomic , copy) NSString              * lng;
@property (nonatomic , assign) NSInteger             cityId;           //省份Id
@property (nonatomic , assign) NSInteger             sort;
@property (nonatomic , assign) NSInteger             parentId;

@end

@interface ProvinceDataModel :NSObject
@property (nonatomic , assign) BOOL              isTrue;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) NSArray<ProvinceModel *>              * items;

@end
