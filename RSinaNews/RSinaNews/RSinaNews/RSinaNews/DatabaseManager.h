//
//  DatabaseManager.h
//  RSinaNews
//
//  Created by TY on 14-6-5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  数据库管理类

#import "FMDatabase.h"


@interface DatabaseManager : FMDatabase

+ (instancetype)sharedDatabase;

@end
