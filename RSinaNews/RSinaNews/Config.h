//
//  Config.h
//  RSinaNews
//
//  Created by TY on 14-6-9.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  全局配置

#import <Foundation/Foundation.h>
//文章模型分类
typedef NS_ENUM(NSInteger, NewsModel) {
    NewsModelText = 1,//文本
    NewsModelImages,//组图
    NewsModelLink,//链接
    NewsModelVideo,//视频
    NewsModelInterview,//访谈
    NewsModelHeadNews,//头条
    NewsModelActive,//活动
    NewsModelVote,//投票
    NewsModelSurvey,//调查
    NewsModelSpecial,//专题
    NewsModeldisclose,//爆料
};
//新闻内容分类
typedef NS_ENUM(NSInteger, NewsCategory) {
    NewsCategoryEconomics = 1,//财经
    NewsCategoryTechnology,//科技
    NewsCategoryMilitary,//军事
    NewsCategoryDigital,//数码
    NewsCategoryMobile,//手机
    NewsCategoryInternet,//移动互联网
    NewsCategoryInternational,//国际
    NewsCategoryInland,//国内
    NewsCategorySearch,//搜索
    NewsCategoryDeep,//深度
    NewsCategoryCar,//汽车
    NewsCategoryHouse,//房产
};

@interface Config : NSObject
+ (instancetype)share;

@property (nonatomic, strong) NSDictionary *categoryDict;
@property (nonatomic, strong) NSDictionary *modelDict;
@end
