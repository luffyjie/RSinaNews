//
//  User.m
//  RSinaNews
//
//  Created by TY on 14-6-10.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "User.h"

@implementation User


- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    if (self = [super init]) {
        self.userId = [attributes objectForKey:@"StfId"];
        self.password = [attributes objectForKey:@"Password"];
        self.userName = [attributes objectForKey:@"UserName"];
        self.gender = [attributes objectForKey:@"Gender"];
        self.email = [attributes objectForKey:@"Mail"];
        self.nickName = [attributes objectForKey:@"NickName"];
    }
    return self;
}

- (User *)initWithUserId:(NSNumber*)userId email:(NSString *)email password:(NSString *)password nickName:(NSString *)nickName userName:(NSString *)userName gender:(NSNumber *)gender subscribe:(NSString*)subscribe
{
    if (self = [super init]) {
        self.userId = userId;
        self.userName = userName;
        self.email = email;
        self.password = password;
        self.nickName = nickName;
        self.userName = nickName;
        self.gender = gender;
        self.subscribe = subscribe;
    }
    return self;
}
//注册
+ (NSURLSessionDataTask *)userRegisterWithParam:(NSDictionary *)param complete:(void (^)(User *user, NSError *error))block
{
    NSString *url = [NSString stringWithFormat:@"%@?email=%@&pwd=%@&mphone=%@",BASE_REGISTER_URL,[param objectForKey:@"email"],[param objectForKey:@"password"],[param objectForKey:@"mphone"]];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [[APIClient shareClient]GET:url parameters:nil
                               success:^(NSURLSessionDataTask *task, id responseObject) {
                                   NSNumber *result = [responseObject objectForKey:@"errorNum"];
                                   if ([result isEqual:@10000]) {//注册成功
                                       if (block) {
                                           NSDictionary *dict = [responseObject objectForKey:@"data"];
                                           User *u = [[User alloc]initWithAttributes:dict];
                                           if (block) {
                                               block(u,nil);
                                           }
                                       }
                                   }else{
                                       block(nil,nil);
                                   }
    }
                               failure:^(NSURLSessionDataTask *task, NSError *error) {
                                   block(nil,error);
    }];
}
//登录
+ (NSURLSessionDataTask *)userLoginWithParam:(NSDictionary *)param complete:(void (^)(User *user, NSError *error))block
{
    NSString *url = [NSString stringWithFormat:@"%@?mail=%@&Password=%@",BASE_LOGIN_URL,[param objectForKey:@"mail"],[param objectForKey:@"password"]];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [[APIClient shareClient]GET:url parameters:nil
                               success:^(NSURLSessionDataTask *task, id responseObject) {
                                   NSNumber *result = [responseObject objectForKey:@"errorNum"];
                                   if ([result isEqual:@10000]) {//登录成功
                                       NSDictionary *dict = [responseObject objectForKey:@"data"];
                                       User *u = [[User alloc]initWithAttributes:dict];
                                       if (block) {
                                           block(u,nil);
                                       }
                                   }else{
                                       block(nil,nil);
                                   }
                               }
                               failure:^(NSURLSessionDataTask *task, NSError *error) {
                                   block(nil,error);
                               }];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.subscribe forKey:@"subscribe"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.subscribe = [aDecoder decodeObjectForKey:@"subscribe"];
    }
    return self;
}
@end
