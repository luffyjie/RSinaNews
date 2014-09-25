//
//  User.h
//  RSinaNews
//
//  Created by TY on 14-6-10.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  用户model

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property (nonatomic, assign) NSNumber *userId;      //用户id
@property (nonatomic, strong) NSString *email;   //email
@property (nonatomic, strong) NSString *password;   //密码
@property (nonatomic, strong) NSString *nickName;   //昵称
@property (nonatomic, strong) NSString *userName;   //姓名
@property (nonatomic, strong) NSNumber *gender;     //性别
@property (nonatomic, strong) NSString *subscribe;  //订阅

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

- (User*)initWithUserId:(NSNumber*)userId email:(NSString*)email password:(NSString*)password nickName:(NSString*)nickName userName:(NSString*)userName gender:(NSNumber*)gender subscribe:(NSString*)subscribe;

//注册
+ (NSURLSessionDataTask *)userRegisterWithParam:(NSDictionary*)param complete:(void (^)(User *user, NSError *error))block;

//登录验证
+ (NSURLSessionDataTask *)userLoginWithParam:(NSDictionary*)param complete:(void (^)(User *user, NSError *error))block;

@end
