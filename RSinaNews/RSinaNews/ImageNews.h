//
//  ImageNews.h
//  RSinaNews
//
//  Created by TY on 14-6-13.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  图片新闻Model

#import "News.h"

@interface ImageNews : News

@property (nonatomic, strong) NSArray *imageList;   //图片列表

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

//根据contentid获取图片新闻详细内容
+ (NSURLSessionDataTask *)imageNewsWithContentId:(NSNumber *)contentId
                                   complete:(void (^)(ImageNews *news, NSError *error))block;

+ (BOOL)saveImageNews:(ImageNews *)news;
@end
