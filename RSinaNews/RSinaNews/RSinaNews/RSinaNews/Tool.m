//
//  Tool.m
//  RSinaNews
//
//  Created by TY on 14-6-5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "Tool.h"
#define FIRST_USE @"FIRST_USE"

@implementation Tool

#pragma mark- 判断是否第一次使用
+ (void)firstUse
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:FIRST_USE];
//    [defaults removeObjectForKey:FIRST_USE];
    [defaults synchronize];

}

+ (BOOL)isFirstUse
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults objectForKey:FIRST_USE];
    if ([value isEqualToString:@""] || value == nil) {
        [self firstUse];
        return YES;
    }else{
        return NO;
//        [self firstUse];
    }
}

#pragma mark- 登录登出
+ (void)loginCache:(User *)user
{
    NSUserDefaults *cache = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    if ([cache objectForKey:@"user"]) {
        [cache removeObjectForKey:@"user"];
    }
    [cache setObject:data forKey:@"user"];
    [cache synchronize];
    //cache到数据库
    DatabaseManager *db = [DatabaseManager sharedDatabase];
    [db open];
    NSString *selectMail = @"select * from user where mail=?";
    FMResultSet *set = [db executeQuery:selectMail,user.email];
    if (![set next]) {//没有该用户
        NSString *insertSql = @"insert into user(userid,mail,password,username,nickname,gender) values(?,?,?,?,?,?)";
        BOOL result = [db executeUpdate:insertSql withArgumentsInArray:@[user.userId,user.email,user.password,user.userName,user.nickName,user.gender]];
        if (result) {
            NSLog(@"缓存用户成功!");
        }
    }else{
        //已经存过
    }
    [db close];
}

+ (User *)getUser
{
    NSUserDefaults *cache = [NSUserDefaults standardUserDefaults];
    NSData *data = [cache objectForKey:@"user"];
    User *user = nil;
    if (data) {
        user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return user;
}

+ (void)logOut
{
    NSUserDefaults *cache = [NSUserDefaults standardUserDefaults];
    [cache removeObjectForKey:@"user"];
}

#pragma mark-关注收藏
+ (BOOL)isLiked:(NSNumber *)contentId
{
    BOOL result = NO;
    if (contentId) {
        User *u = [Tool getUser];
        if (u) {
            DatabaseManager *db = [DatabaseManager sharedDatabase];
            [db open];
            NSString *querySql = @"select * from userLike where userid=? and contentid=?";
            FMResultSet *set = [db executeQuery:querySql,u.userId,contentId];
            //用户关注过返回yes
            if ([set next]) {
                result = YES;
            }else{
                result = NO;
            }
            [db close];
        }else{
        }
    }
    return result;
}
+ (BOOL)isFavorited:(NSNumber *)contentId
{
    BOOL result = NO;
    if (contentId) {
        User *u = [Tool getUser];
        if (u) {
            DatabaseManager *db = [DatabaseManager sharedDatabase];
            [db open];
            NSString *querySql = @"select * from userCollection where userid=? and contentid=?";
            FMResultSet *set = [db executeQuery:querySql,u.userId,contentId];
            //用户收藏过返回yes
            if ([set next]) {
                result = YES;
            }else{
                result = NO;
            }
            [db close];
        }else{
        }
    }
    return result;
}

+ (BOOL)like:(NSNumber *)contentId
{
    BOOL result = NO;
    if (contentId) {
        User *u = [Tool getUser];
        if (u) {
            DatabaseManager *db = [DatabaseManager sharedDatabase];
            if ([Tool isLiked:contentId]) {//取消关注
                [db open];
                NSString *deleteSql = @"delete from userLike where userid=? and contentid=?";
                result = [db executeUpdate:deleteSql withArgumentsInArray:@[u.userId,contentId]];
            }else{
                [db open];
                NSString *insertSql = @"insert into userLike(userid,contentid) values(?,?)";
                result = [db executeUpdate:insertSql withArgumentsInArray:@[u.userId,contentId]];
                [db close];
            }
        }else{
            [TSMessage showNotificationWithTitle:@"请先登录！" type:TSMessageNotificationTypeWarning];
        }
    }
    return result;
}

+ (BOOL)favorite:(NSNumber *)contentId
{
    BOOL result = NO;
    if (contentId) {
        User *u = [Tool getUser];
        if (u) {
            DatabaseManager *db = [DatabaseManager sharedDatabase];
            if ([Tool isFavorited:contentId]) {
                [db open];
                NSString *deleteSql = @"delete from userCollection where userid=? and contentid=?";
                result = [db executeUpdate:deleteSql withArgumentsInArray:@[u.userId,contentId]];
                [db close];
            }else{
                [db open];
                NSString *insertSql = @"insert into userCollection(userid,contentid) values(?,?)";
                result = [db executeUpdate:insertSql withArgumentsInArray:@[u.userId,contentId]];
                [db close];
            }
        }else{
            [TSMessage showNotificationWithTitle:@"请先登录！" type:TSMessageNotificationTypeWarning];
        }
    }
    return result;
}


@end
