//
//  News.m
//  RSinaNews
//
//  Created by TY on 14-6-10.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "News.h"
#import "URLConstant.h"

@implementation News

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    if (self = [super init]) {
        self.contentId = [attributes objectForKey:@"ContentId"];
        self.title = [attributes objectForKey:@"Title"];
        self.topicId = [attributes objectForKey:@"Topicid"];
        self.modelId = [attributes objectForKey:@"Modelid"];
        self.catId = [attributes objectForKey:@"Catid"];
        self.published = [attributes objectForKey:@"Published"];
        self.thumb = [BASE_IMAGE_URL stringByAppendingString:[attributes objectForKey:@"Thumb"]];
        self.comments = [attributes objectForKey:@"Comments"];
        self.content = [attributes objectForKey:@"Content"];
        self.description = [attributes objectForKey:@"Description"];
        self.source = [attributes objectForKey:@"Source"];
        self.video = [attributes objectForKey:@"Video"];
        self.playTime = [attributes objectForKey:@"Playtime"];
    }
    return self;
}


//根据modeId获取
+ (NSURLSessionDataTask *)newsListWithModelId:(NSInteger)modelId
                                         page:(NSInteger)page
                                     pagesize:(NSInteger)pagesize
                                     complete:(void (^)(NSArray *list, NSError *error))block
{
    NSString *url = [NSString stringWithFormat:@"%@?modelid=%ld&pagesize=%ld&page=%ld",
                     BASE_MODEL_URL,modelId,pagesize,page];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [[APIClient shareClient]GET:url
                                    parameters:nil
                                       success:^(NSURLSessionDataTask *__unused task, id responseObject) {
                                           NSString *errorMsg = [responseObject objectForKey:@"errorMsg"];
                                           if ([errorMsg isEqualToString:@"success"]) {//请求成功
                                               NSArray *dataArray = [responseObject objectForKey:@"data"];
                                               NSMutableArray *returnArray = [[NSMutableArray alloc]initWithCapacity:dataArray.count];
                                               for (NSDictionary *dict in dataArray) {
                                                   News *n = [[News alloc]initWithAttributes:dict];
                                                   [returnArray addObject:n];
                                               }
                                               if (block) {
                                                   block([NSArray arrayWithArray:returnArray],nil);
                                               }
                                           }else{
                                               block([NSArray array],nil);
                                           }
                                           
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"mode error:%@",error);
    }];
}

//根据catId获取
+ (NSURLSessionDataTask *)newsListWithCatId:(NSInteger)catId
                                         page:(NSInteger)page
                                     pagesize:(NSInteger)pagesize
                                     complete:(void (^)(NSArray *list, NSError *error))block
{
    NSString *url = [NSString stringWithFormat:@"%@?catid=%ld&pagesize=%ld&page=%ld",
                     BASE_CAT_URL,catId,pagesize,page];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [[APIClient shareClient]GET:url
                            parameters:nil
                               success:^(NSURLSessionDataTask *__unused task, id responseObject) {
                                   NSString *errorMsg = [responseObject objectForKey:@"errorMsg"];
                                   if ([errorMsg isEqualToString:@"success"]) {//请求成功
                                       NSArray *dataArray = [responseObject objectForKey:@"data"];
                                       NSMutableArray *returnArray = [[NSMutableArray alloc]initWithCapacity:dataArray.count];
                                       for (NSDictionary *dict in dataArray) {
                                           News *n = [[News alloc]initWithAttributes:dict];
                                           [returnArray addObject:n];
                                       }
                                       if (block) {
                                           block([NSArray arrayWithArray:returnArray],nil);
                                       }
                                   }else{
                                        block([NSArray array],nil);
                                   }
                                   
                               } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
                                           NSLog(@"cat error:%@",error);
                               }];
}

//根据contentId获取
+ (NSURLSessionDataTask *)newsWithContentId:(NSNumber *)contentId
                                   complete:(void (^)(News *news, NSError *error))block
{
    NSString *url = [NSString stringWithFormat:@"%@?contentid=%@",BASE_CONTENT_URL,contentId];
    return [[APIClient shareClient]GET:url
                            parameters:nil
                               success:^(NSURLSessionDataTask *__unused task, id responseObject) {
                                   NSString *errorMsg = [responseObject objectForKey:@"errorMsg"];
                                   if ([errorMsg isEqualToString:@"success"]) {//请求成功
                                       NSDictionary *dataDict = [responseObject objectForKey:@"data"];
                                       News *returnNews = nil;
                                       if (dataDict) {
                                           returnNews = [[News alloc]initWithAttributes:dataDict];
                                       }
                                       if (block) {
                                           block(returnNews,nil);
                                       }
                                   }else{
                                       block(nil,nil);
                                   }
    }
                               failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
                                   NSLog(@"cat error:%@",error);
    }];
}

//根据modelId和catId获取
+ (NSURLSessionDataTask *)newsListWithCatIdAndModelId:(NSInteger)catId
                                              modelId:(NSInteger)modelId
                                                 page:(NSInteger)page
                                             pagesize:(NSInteger)pagesize
                                             complete:(void (^)(NSArray *, NSError *))block
{
    NSString *url = [NSString stringWithFormat:@"%@?modelid=%ld&catid=%ld&pagesize=%ld&page=%ld",
                     BASE_MODEL_CAT_URL,modelId,catId,pagesize,page];
    return [[APIClient shareClient]GET:url
                            parameters:nil
                               success:^(NSURLSessionDataTask *task, id responseObject) {
                                   NSString *errorMsg = [responseObject objectForKey:@"errorMsg"];
                                   if ([errorMsg isEqualToString:@"success"]) {//请求成功
                                       NSArray *dataArray = [responseObject objectForKey:@"data"];
                                       NSMutableArray *returnArray = [[NSMutableArray alloc]initWithCapacity:dataArray.count];
                                       for (NSDictionary *dict in dataArray) {
                                           News *n = [[News alloc]initWithAttributes:dict];
                                           [returnArray addObject:n];
                                       }
                                       if (block) {
                                           block([NSArray arrayWithArray:returnArray],nil);
                                       }
                                   }else{
                                       block([NSArray array],nil);
                                   }
    }
                               failure:^(NSURLSessionDataTask *task, NSError *error) {
                                   NSLog(@"catAndModel error:%@",error);
    }];
}


//缓存新闻
+ (BOOL)saveNews:(News *)news
{
    BOOL result=NO;
    if (news) {
        DatabaseManager *db = [DatabaseManager sharedDatabase];
        [db open];
        NSString *selectSql = @"select * from news where contentid=?";
        FMResultSet *set = [db executeQuery:selectSql,news.contentId];
        if ([set next]) {//存在新闻,不做存储
            result = YES;
        }else{
            NSString *insertSql = @"insert into news(contentid,title,topicid,modelid,catid,published,thumb,comments,content,description,source,video,playtime) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
            result = [db executeUpdate:insertSql withArgumentsInArray:@[news.contentId,news.title,news.topicId,news.modelId,news.catId,news.published,news.thumb,news.comments,news.content,news.description,news.source,news.video,news.playTime]];
        }
        [db close];
    }else{
        result = NO;
    }
    return result;
}
@end
