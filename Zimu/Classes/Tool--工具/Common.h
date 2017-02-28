//
//  Common.h
//  YiXian
//
//  Created by lj on 16/1/12.
//  Copyright © 2016年 YiXian. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width        //屏幕宽度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height      //屏幕高度

#define kSystmFont kScreenHeight > 570 ? 14 : 12
#define themeFont [UIFont systemFontOfSize:13]                      //界面中的主字体大小

//颜色
#define themeYellow [UIColor colorWithHexString:@"fadb07"]          //黄
#define themeBlue [UIColor colorWithHexString:@"007aff"]            //蓝
#define themeGray [UIColor colorWithHexString:@"efeff4"]            //背景灰
#define themeBlack [UIColor colorWithHexString:@"4a4a4a"]           //黑
#define themeGreen [UIColor colorWithHexString:@"4cd964"]           //绿
#define themeGold [UIColor colorWithHexString:@"dabd85"]            //金
#define themeWhite [UIColor whiteColor]                             //白
#define themeRed [UIColor redColor]                                 //红
#define themeOrange [UIColor colorWithHexString:@"ff9500"]          //橙
#define themeOrangeRed [UIColor colorWithHexString:@"ff4500"]       //橘红




/*判断系统版本*/
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#endif /* Common_h */
