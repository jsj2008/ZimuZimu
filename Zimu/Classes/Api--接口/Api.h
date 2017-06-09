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

//============================================== #心理测试# ====================================================
#define GetHeartTestList        @"appHeartTest/getHeartTestList.do"           //获取心理测试列表
#define GetMyHeartTestList      @"appUser/check/queryMyHeartTest.do"                //获取我的心理测试列表 参数 userToken

//============================================== #new# ====================================================
#define GetHomeSixImageURL @"appImgs/getHomeSixImage.do"                //获取首页图片

//============================================== #线下活动# =================================================
#define GetAppOfflineCourseListURL @"appCourse/getAppOfflineCourseList.do"      //获取所有线下活动
#define GetOfflineCourseURL @"offlineCourse/getOfflineCourse.do"                //获取具体活动时间地点(参数:categoryId)
#define GetAppOfflineCourseByIdURL @"appCourse/getAppOfflineCourseById.do"      //获取该类别活动详情数据(参数:categoryId)
#define GetAppOfflineCourseByCourseIdURL @"appCourse/getAppOfflineCourseByCourseId.do" //获取具体活动详情(参数:courseId)
#define WXOfflineCourseURL @"pPay/check/addAppOfflineCourse.do"//线下活动报名，提交订单(参数:offlineCourseId、offCoursePrice、channel、offlineCourseName)
#define ModifyAppOfflineCourseURL @"pPay/check/modifyAppOfflineCourse.do"   //重新提交订单 (参数:userToken、offCourseOrderId、channel、offlineCourseName)
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
#define GetQuestionLabelURL @"appQuestion/getQuestionLabel.do"             //获取提问标签
#define AppRecommendQuestionURL @"appQuestion/appRecommendQuestion.do"     //根据标签获取类似问题 (categoryId，questionId)

//=========================================== #我的# =======================================================
/*个人信息*/
#define GetMyInfoURL @"appUser/check/getMyInfo.do"                //获取个人信息  （带参数userToken，后台拦截器会拦截userToken取出该用户信息）
#define EditMyInfoURL @"appUser/check/editMyInfo.do"              //修改个人信息，带参数 userToken 和要修改的 某个参数
#define GetProvinceURL @"appAddress/getProvince.do"         //获取所有省份
#define GetCityURL @"appAddress/getCitysByPrevId.do"        //根据省份ID获取城市 (prevId : 省份ID 例：ff19987b-484f-4645-9835-08c2daf344ce)
#define CreateTokenURL  @"qiniu/check/createToken.do"          //获取七牛token (参数:userToken)

/*订单*/
#define QueryAppUserOrderListURL @"appOrder/check/queryAppUserOrderList.do";  //获取所有订单 (参数：endTime、userToken)
#define QueryAppUserOrderCompleteListURL @"appOrder/check/queryAppUserOrderCompleteList.do" //查询已完成、待付款订单(参数:endTime、status(0:待付款；1:已完成)、userToken)
#define QueryOffLineCourseOrderDetailURL @"appOrder/queryOffLineCourseOrderDetail.do"   //订单详情 (参数:offCourseOrderId)
#define DeleteOffLineCourseOrderDetailURL @"appOrder/check/deleteOffLineCourseOrderDetail.do"   //删除订单 (参数:offCourseOrderId、userToken)
/*心事*/
#define QueryMyQuestionURL @"appQuestion/check/queryMyQuestion.do"        //我的心事列表 (参数:userToken、endTime)


//=========================================== #我的收藏# ================================================
#define GetMyFavouriteVideoListURL      @"appVideo/check/queryMyFavoriteVideo.do"         //获取我收藏的视频 ?endTime=1494068216&userToken=d0eb993ffa2e876c60b99b745d93f9fa
#define GetMyFavouriteArticleListURL    @"appArticle/check/queryMyFavoriteArticle.do"           //获取我收藏的文章 ?endTime=1494068216&userToken=9d3744dc1d940aa14e078b17ded7ee5c
#define GetMyFavouriteFMListURL         @"appFm/check/queryMyFavoriteFm.do"               //获取我收藏的FM  ?endTime=1495445276&userToken=d0eb993ffa2e876c60b99b745d93f9fa

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



//=========================================# 找朋友 # ============================================
//聊天先创建房间  再推送 进入房间 开始推拉流连麦 离开房间
#define GetVideoChatRequestURL  @"appLive/check/getVideoChatRequest.do"             //获取是否有该用户的视频请求
#define CreateChatRoomURL       @"appLive/check/createRoom.do"                      //创建聊天房间  (参数：?userId=&num=(加入视频的人数))
#define GenerateToomTokenURL    @"appLive/check/generateToomToken.do"               //用户获取房间token  (参数：?userId=&roomName=&role=（user/admin）)
#define ComeinRoomURL           @"appLive/check/comeInRoom.do"                      //用户进入房间  参数：userToken roomId
#define LeaveChatRoomURL        @"appLive/check/leaveRoom.do"                       //用户离开房间，（参数：roomId userToken）  这个roomId就是roomName
#define PushNotiToUsersURL      @"appJpush/check/toUserListVideoChat.do"            //给要通话的用户发送推送  参数：userToken=&type=videoChat&users=&roomName=

#define SearchFriendByPhoneURL  @"appUser/check/searchFriendByCondition.do"         //根据手机号搜搜陌生人 （userToken userPhone(被搜索人的手机号)）
#define GetFriendsListURL       @"appUser/check/getMyFriendList.do"                 //获取好友列表 userToken=d0eb993ffa2e876c60b99b745d93f9fa
#define AddFriendURL            @"appJpush/check/toUser.do"                         //添加好友  userId= type=addFriend
#define GetMyMsgURL             @"appUserMessage/check/getUserNoticeMessage.do"     //获取我的消息接口 endTime=2494399605&userToken=e1d7c24bb5cbef626e6e3a30bc618dd3
#define AcceptFriendURL         @"appUser/check/agreeFriendRequest.do"              //同意好友请求 fromUser=
#define GetFriendMsgURL         @"appUser/check/queryFriendInfo.do"                 //根据用户id获取用户信息
#define SearchMyFriendListURL   @"appUser/check/searchFriendByMyself.do"            //在好友列表搜索好友 userToken=d0eb993ffa2e876c60b99b745d93f9fa&userName=

#endif /* Api_h */



/*
 *  还没用过的接口
 
 5. appFind/getFindMoreSearchList.do?title=test   亲子学堂页面，搜索接口
 */
