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

#pragma mark-加载频道
+ (NSMutableArray*)getSubscribedChannel
{
    
    NSString * string = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * filePath = [string stringByAppendingString:@"/modelArray0.swh"];
    NSString * filePath1 = [string stringByAppendingString:@"/modelArray1.swh"];
    NSMutableArray *subscribedChannel = [NSMutableArray array];//订阅的频道
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {//不存在文件
        NSMutableArray * mutArr = [NSMutableArray array];
        NSInteger count = [[[Config share]categoryDict]allKeys].count;
        for (int i = 0; i < count; i++) {
            NSString * title = [[[Config share]categoryDict]objectForKey:@(i+1)];
            NSString * category = [NSString stringWithFormat:@"%d",i+1];
            TouchViewModel * touchViewModel = [[TouchViewModel alloc] initWithTitle:title urlString:category];
            [mutArr addObject:touchViewModel];
            
            if (i == KDefaultCountOfUpsideList - 1) {//已订阅,默认5个
                NSData * data = [NSKeyedArchiver archivedDataWithRootObject:mutArr];
                [data writeToFile:filePath atomically:YES];
                [mutArr removeAllObjects];
            }
            else if(i == count - 1){//未订阅
                NSData * data = [NSKeyedArchiver archivedDataWithRootObject:mutArr];
                [data writeToFile:filePath1 atomically:YES];
            }
        }
    }
    subscribedChannel = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return subscribedChannel;
}
//设置频道
+ (void)setSubscribedChannel:(NSMutableArray *)subedArray notSub:(NSMutableArray *)notSubArray
{
    NSString * string = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * filePath = [string stringByAppendingString:@"/modelArray0.swh"];
    NSString * filePath1 = [string stringByAppendingString:@"/modelArray1.swh"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]  ||  [[NSFileManager defaultManager] fileExistsAtPath:filePath1]) {
    [[NSFileManager defaultManager]removeItemAtPath:filePath error:nil];
    [[NSFileManager defaultManager]removeItemAtPath:filePath1 error:nil];
    }
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:subedArray];
    [data writeToFile:filePath atomically:YES];

    NSData * data1 = [NSKeyedArchiver archivedDataWithRootObject:notSubArray];
    [data1 writeToFile:filePath1 atomically:YES];
    
}


+ (CGSize)contentSizeOfTextView:(UITextView *)textView
{
    CGSize textViewSize = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, FLT_MAX)];
    return textViewSize;
}
@end
