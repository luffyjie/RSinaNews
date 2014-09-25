//
//  URLConstant.h
//  RSinaNews
//
//  Created by TY on 14-6-10.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#ifndef RSinaNews_URLConstant_h
#define RSinaNews_URLConstant_h

//图片加载地址

#define BASE_IMAGE_URL @"http://192.168.0.43:8080/upload/"

/*********************** 多条新闻 *******************************/
//按新闻内容分类获取新闻列表
#define BASE_CAT_URL @"NewsWebService.asmx/GetNewsListByCatidAndPagesizeAndPage"
//按新闻模型分类获取新闻列表
#define BASE_MODEL_URL @"NewsWebService.asmx/GetNewsListByModelidAndPagesizeAndPage"
//按新闻内容分类和新闻模型分类获取新闻列表
#define BASE_MODEL_CAT_URL @"NewsWebService.asmx/GetNewsListByCatidAndModelidAndPagesizeAndPage"



/***********************  新闻分类列表 *******************************/
//新闻内容分类列表
#define BASE_CAT_LIST_URL @"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/GetNewsContentCategoryList"
//新闻模型分类列表
#define BASE_MODEL_LIST_URL @"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/GetNewsContentModelList"



/***********************    新闻详情  *******************************/
//获取文本新闻、视频新闻
#define BASE_CONTENT_URL @"NewsWebService.asmx/GetNewsByContentId"
//获取图片新闻
#define BASE_IMAGE_CONTENT_URL @"NewsWebService.asmx/GetImageNewsByContentId"




/***********************    评论   *******************************/
//评论列表
#define BASE_COMMENT_LIST_URL @"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/GetDiscussRecordListByContentid?contentid="
//发表评论
#define BASE_POST_COMMENT_URL @"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/AddDiscussRecord"



/***********************    登录注册   *******************************/
//登录
#define BASE_LOGIN_URL @"StaffWebService.asmx/LoginWithEmail"
//注册
#define BASE_REGISTER_URL @"WeiGuanWebService.asmx/RegistUser"
//检查Email是否可用
#define CHECK_EMAIL_URL @"StaffWebService.asmx/IsEmailExists?mail="


//爆料
#define BASE_TOPIC_URL @"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/AddImageNews"

#endif
