//
//  News.h
//  RSinaNews
//
//  Created by TY on 14-6-10.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  新闻model

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic, assign) NSNumber *contentId;  //内容id
@property (nonatomic, strong) NSString *title;      //标题
@property (nonatomic, assign) NSNumber *topicId;    //专题id
@property (nonatomic, assign) NSNumber *modelId;    //模型id
@property (nonatomic, strong) NSNumber *catId;      //类型id
@property (nonatomic, strong) NSString *published;  //发布时间
@property (nonatomic, strong) NSString *thumb;      //图片
@property (nonatomic, assign) NSNumber *comments;   //评论数
@property (nonatomic, strong) NSString *content;    //内容
@property (nonatomic, strong) NSString *description;//描述
@property (nonatomic, strong) NSString *source;     //来源
@property (nonatomic, strong) NSString *video;      //视频
@property (nonatomic, assign) NSNumber *playTime;   //播放时间


- (instancetype)initWithAttributes:(NSDictionary *)attributes;

//按模型获取新闻列表
+ (NSURLSessionDataTask *)newsListWithModelId:(NSInteger)modelId
                                         page:(NSInteger)page
                                     pagesize:(NSInteger)pagesize
                                     complete:(void (^)(NSArray *list, NSError *error))block;

//按类型获取新闻列表
+ (NSURLSessionDataTask *)newsListWithCatId:(NSInteger)catId
                                       page:(NSInteger)page
                                   pagesize:(NSInteger)pagesize
                                   complete:(void (^)(NSArray *list, NSError *error))block;

//按模型和类型获取新闻列表
+ (NSURLSessionDataTask *)newsListWithCatIdAndModelId:(NSInteger)catId
                                              modelId:(NSInteger)modelId
                                                 page:(NSInteger)page
                                             pagesize:(NSInteger)pagesize
                                             complete:(void (^)(NSArray *list, NSError *error))block;

//根据contentid获取新闻详细内容
+ (NSURLSessionDataTask *)newsWithContentId:(NSNumber *)contentId
                                   complete:(void (^)(News *news, NSError *error))block;

+ (BOOL)saveNews:(News *)news;

@end
