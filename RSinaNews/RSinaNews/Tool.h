//
//  Tool.h
//  RSinaNews
//
//  Created by TY on 14-6-5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  工具类

#import <Foundation/Foundation.h>
#import "User.h"
#import "TouchViewModel.h"

@interface Tool : NSObject

+ (void)firstUse;//第一次使用，cache一个字段
+ (BOOL)isFirstUse;//判断是否第一次使用

+ (void)loginCache:(User*)user;//缓存用户信息
+ (User*)getUser;//获取当前用户
+ (void)logOut;//注销用户


+ (BOOL)isLiked:(NSNumber *)contentId;//是否已经关注
+ (BOOL)isFavorited:(NSNumber *)contentId;//是否已经收藏
+ (BOOL)like:(NSNumber *)contentId;//是否已经关注
+ (BOOL)favorite:(NSNumber *)contentId;//收藏

+ (NSMutableArray*)getSubscribedChannel;//加载频道
+ (void)setSubscribedChannel:(NSMutableArray *)subedArray notSub:(NSMutableArray*)notSubArray;//设置频道,参数：订阅的数组和未订阅的数组

+ (CGSize)contentSizeOfTextView:(UITextView *)textView;//根据内容，自适应高度
@end
