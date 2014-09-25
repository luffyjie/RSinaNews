//
//  APIClient.h
//  RSinaNews
//
//  Created by TY on 14-6-11.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  网络请求公共类

#import "AFHTTPSessionManager.h"

@interface APIClient : AFHTTPSessionManager

+ (instancetype)shareClient;

@end
