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

//============================================== #线下活动# =================================================
#define GetAppOfflineCourseListURL @"appCourse/getAppOfflineCourseList.do"      //获取所有线下活动
#define GetOfflineCourseURL @"offlineCourse/getOfflineCourse.do"                //获取具体活动时间地点(参数:categoryId)
#define GetAppOfflineCourseByIdURL @"appCourse/getAppOfflineCourseById.do"      //获取该类别活动详情数据(参数:categoryId)
#define GetAppOfflineCourseByCourseIdURL @"appCourse/getAppOfflineCourseByCourseId.do" //获取具体活动详情(参数:courseId)
#define WXOfflineCourseURL @"pPay/check/wxOfflineCourse.do"//线下活动报名(参数:offlineCourseId、offCoursePrice、channel、offlineCourseName)
#define GetOfflineCourseByIdURL @"offlineCourse/getOfflineCourseById.do"    //获取所报名的活动的详情(参数:offCourseId)


//============================================== #提问# ====================================================
#define AppExpSolveURL @"appExpSolve/appExpSolve.do"                  //搜索问题  参数对应名称（questionTitle : 问题标题）
#define InsertQuestionURL @"appExpSolve/check/insertQuestion.do"            //提交问题  参数对应名称（问题标题:questionTitle 标签:keyWord 问题内容:questionVal）
#define AppQuestionByIdURL @"appExpSolve/appQuestionById.do"          //查询问题详情  参数对应名称（问题id:questionId）
#define AppExpSolveReadURL @"appExpSolve/appExpSolveRead.do"          //问题详情中专家回答内容 （问题id:questionId）
#define AppUserCommentURL @"appExpSolve/appUserComment.do"            //问题详情中用户评论列表  参数对应名称（问题id:questionId）
#define InsertCommentURL @"appExpSolve/check/insertComment.do"            //提交评论 （评论内容 commentVal  问题id questionId）
#define CareQuestionURL @"appExpSolve/check/careQuestion.do"               //关注问题 （传userToken，问题id）
#define QueryWhetherCareURL @"appExpSolve/check/queryWhetherCare.do"       //是否已关注该问题（传userToken，问题id）


//=========================================== #我的# =======================================================
/*个人信息*/
#define GetMyInfoURL @"appUser/check/getMyInfo.do"                //获取个人信息  （带参数userToken，后台拦截器会拦截userToken取出该用户信息）
#define EditMyInfoURL @"appUser/check/editMyInfo.do"              //修改个人信息，带参数 userToken 和要修改的 某个参数
#define GetProvinceURL @"appAddress/getProvince.do"         //获取所有省份
#define GetCityURL @"appAddress/getCitysByPrevId.do"        //根据省份ID获取城市 (prevId : 省份ID 例：ff19987b-484f-4645-9835-08c2daf344ce)
/*订单*/
#define QueryAppUserOrderListURL @"appOrder/check/queryAppUserOrderList.do";  //获取所有订单 (参数：endTime、userToken)
#define QueryAppUserOrderCompleteListURL @"appOrder/check/queryAppUserOrderCompleteList.do" //查询已完成、待付款订单(参数:endTime、status(0:待付款；1:已完成)、userToken)
#define QueryOffLineCourseOrderDetailURL @"appOrder/queryOffLineCourseOrderDetail.do"   //订单详情 (参数:offCourseOrderId)
#define DeleteOffLineCourseOrderDetailURL @"appOrder/check/deleteOffLineCourseOrderDetail.do"   //删除订单 (参数:offCourseOrderId、userToken)
/*心事*/
#define QueryMyQuestionURL @"appQuestion/check/queryMyQuestion.do"        //我的心事列表 (参数:userToken、endTime)



//=========================================== #亲子学堂# ================================================
#define GetParentSchoolListURL @"appFind/getFindMoreList.do"                //获取亲子学堂页数据 endTime : 时间戳
//FM
#define GetFmByPrimaryKeyURL @"appFm/getFmByPrimaryKey.do"                  //获取FM详情  （参数：fmId）
#define GetFmCommentListURL  @"appFm/getFmCommentList.do"                   //获取fm列表   (参数：fmId)
#define InsertFmCommentURL @"appFm/check/insertFmComment.do"                      //插入fm评论 (参数：fmId、commentVal、userToken)
#define GetWhetherFavoriteFmURL @"appFm/check/getWhetherFavoriteFm.do"            //查询是否已收藏该FM (参数：fmId、userToken)
#define InsertFmCollectionURL @"appFm/check/insertFmCollection.do"                //收藏FM (参数：fmId、userToken)

//文章
#define GetArticleByPrimaryKeyURL @"appArticle/getArticleByPrimaryKey.do"   //获取文章详情  （参数：传articleId）
#define GetArticleCommentListURL @"appArticle/getArticleCommentList.do"     //获取文章评论  (参数：articleId)
#define InsertArticleCommentURL @"appArticle/check/insertArticleComment.do"       //插入文章评论  (参数：userToken、articleId、commentVal)
#define GetWhetherFavoriteArticleURL @"appArticle/check/getWhetherFavoriteArticle.do"     //查询是否已收藏该文章 (参数：articleId、userToken)
#define InsertArticleCollectionURL @"appArticle/check/insertArticleCollection.do" //收藏文章 (参数：articleId、userToken)

//视频
#define AppQueryVideoURL @"appVideo/appQueryVideo.do"                       //获取视频详情  （参数：传videoId）
#define GetHotVideoURL @"appVideo/getRandTwoVideo.do"                       //获取热门推荐视频
#define GetExpertByPrimaryKeyURL  @"appExpert/getExpertByPrimaryKey.do"     //获取专家信息  (参数：expertId)
#define GetVideoCommentListURL  @"appVideo/getVideoCommentList.do"          //获取视频评论  （参数：videoId）
#define InsertVideoCommentURL  @"appVideo/check/insertVideoComment.do"            //插入视频评论    （参数：commentVal、videoId、userToken）
#define GetWhetherFavoriteVideoURL  @"appVideo/check/getWhetherFavoriteVideo.do"  //查询是否已收藏视频  (参数：videoId、userToken)
#define InsertVideoCollectionURL @"appVideo/check/insertVideoCollection.do"       //收藏视频  (参数：videoId、userToken)

//=================================================设置=========================================================
#define AddFeedbackURL @"feedback/addFeedback.do"      //意见反馈(参数:phone、feedbackVal、systemName、systemVersion、deviceModel、appVersion)



#endif /* Api_h */



/*
 *  还没用过的接口
 
 5. appFind/getFindMoreSearchList.do?title=test   亲子学堂页面，搜索接口
 */
