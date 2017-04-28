//
//  Api.h
//  Zimu
//
//  Created by Redpower on 2017/3/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#ifndef Api_h
#define Api_h


//============================================登录==========================================================
#define GetSMS @"sms/sendCaptcha.do"                                        //获取验证码
#define UserLogin @"appLogin/loginAndRegister.do"                           //登录接口 post

//================================================HOME==========================================================
#define GetHomeBanner @"appHome/getHomeBanner.do"                           //获取首页轮播banner
#define GetHomeRecommendToday @"appHome/getHomeRecommendToday.do"           //获取首页今日推荐
#define GetHomeFourImage @"appHome/getHomeFourImage.do"                     //获取首页四个功能模块
#define GetRecommendExpertList @"appHome/getRecommendExpertList.do"         //获取首页订阅专家
#define GetHomeFreeCourse @"appHome/getHomeFreeCourse.do"                   //获取首页免费课程
#define GetHomeCourseIsNotFree @"appHome/getHomeCourseIsNotFree.do"         //获取首页付费课程
#define GetHomeFm @"appHome/getHomeFm.do"                                   //获取首页FM
#define GetHomeRecommendArticle @"appHome/getHomeRecommendArticle.do"       //获取首页美文推荐



//============================================== #new# ====================================================

#define GetHomeSixImageURL @"appImgs/getHomeSixImage.do"                //获取首页图片
#define GetParentSchoolListURL @"appFind/getFindMoreList.do"            //获取亲子学堂页数据 endTime : 时间戳
#define InsertQuestionURL @"appQuestion/insertQuestion.do"            //提交问题  参数对应名称（用户id:userId 问题标题:questionTitle 标签:keyWord 问题内容:questionVal）



#endif /* Api_h */
