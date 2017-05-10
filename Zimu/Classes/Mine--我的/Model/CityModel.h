//
//  CityModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel :NSObject
@property (nonatomic , copy) NSString              * first;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * shortName;     //城市名简称
@property (nonatomic , copy) NSString              * position;
@property (nonatomic , copy) NSString              * prevId;        //所属省份id
@property (nonatomic , copy) NSString              * jianpin;
@property (nonatomic , copy) NSString              * pinyin;
@property (nonatomic , copy) NSString              * lat;
@property (nonatomic , assign) NSInteger             level;
@property (nonatomic , copy) NSString              * areaName;      //城市名
@property (nonatomic , copy) NSString              * lng;
@property (nonatomic , assign) NSInteger             cityId;       //城市ID
@property (nonatomic , assign) NSInteger             sort;
@property (nonatomic , assign) NSInteger             parentId;

@end

@interface CityDataModel :NSObject
@property (nonatomic , assign) BOOL              isTrue;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) NSArray<CityModel *>              * items;

@end
