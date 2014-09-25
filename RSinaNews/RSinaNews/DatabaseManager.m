//
//  DatabaseManager.m
//  RSinaNews
//
//  Created by TY on 14-6-5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

+ (instancetype)sharedDatabase
{
    static DatabaseManager *database = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *databasePath = [documentPath[0]stringByAppendingPathComponent:@"newsDatabase.sqlite"];
        //创建数据库实例,不存在则自动创建
        database = [FMDatabase databaseWithPath:databasePath];
        if (![database open]) {
            NSLog(@"db can't open");
            return;
        }
        //新建数据库表
        [database executeUpdate:@"CREATE TABLE user (userid integer NOT NULL PRIMARY KEY,username text,password text,nickname text,gender integer,subscribe text, mail text)"];//用户表
        [database executeUpdate:@"CREATE TABLE news (contentid integer NOT NULL PRIMARY KEY,title text,topicid integer,modelid integer,catid integer,published text,thumb text,comments integer,content text,description text,source text,video text,playtime text)"];//新闻表
        [database executeUpdate:@"CREATE TABLE oneImage (contentid integer,description text,thumb text)"];//图片表
        
        [database executeUpdate:@"create table userCollection(userid integer,contentid integer)"];//收藏表
        [database executeUpdate:@"create table userLike(userid integer,contentid integer)"];//喜欢表
        [database close];
    });
    
    return database;
}

@end
