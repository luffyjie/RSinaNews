//
//  Comment.h
//  RSinaNews
//
//  Created by TY on 14-6-10.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  评论model

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (nonatomic, strong) NSString *ip;
@property (nonatomic, strong) NSString *nickName;   //昵称
@property (nonatomic, strong) NSString *longitude;  //经度
@property (nonatomic, strong) NSString *latitude;   //纬度
@property (nonatomic, assign) NSNumber *drId;       //
@property (nonatomic, assign) NSNumber *stfId;      //评论人id
@property (nonatomic, assign) NSNumber *contentId;  //新闻id
@property (nonatomic, strong) NSString *published;  //发布时间
@property (nonatomic, strong) NSString *content;    //内容


@property (nonatomic, assign) CGFloat height;  //内容高度


- (instancetype)initWithAttributes:(NSDictionary *)attributes;

//根据contentId获取评论列表
+ (NSURLSessionDataTask *)commentListWithContentId:(NSNumber*)contentId complete:(void (^)(NSArray *list, NSError *error))block;

@end
