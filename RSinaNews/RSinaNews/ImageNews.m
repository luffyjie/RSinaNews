//
//  ImageNews.m
//  RSinaNews
//
//  Created by TY on 14-6-13.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "ImageNews.h"
#import "OneImage.h"

@implementation ImageNews

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    if (self = [super initWithAttributes:attributes]) {
        NSArray *arry = [attributes objectForKey:@"Imagelist"];
        NSMutableArray *mutArray = [NSMutableArray array];
        for (NSDictionary *dic in arry) {
            OneImage *oneImg = [[OneImage alloc]initWithAttributes:dic];
            [mutArray addObject:oneImg];
        }
        self.imageList = [NSArray arrayWithArray:mutArray];
    }
    return self;
}

+ (NSURLSessionDataTask *)imageNewsWithContentId:(NSNumber *)contentId
                                        complete:(void (^)(ImageNews *, NSError *))block
{
    NSString *url = [NSString stringWithFormat:@"%@?contentid=%@",BASE_IMAGE_CONTENT_URL,contentId];
    return [[APIClient shareClient]GET:url
                            parameters:nil
                               success:^(NSURLSessionDataTask *__unused task, id responseObject) {
                                   NSString *errorMsg = [responseObject objectForKey:@"errorMsg"];
                                   if ([errorMsg isEqualToString:@"success"]) {//请求成功
                                       NSDictionary *dataDict = [responseObject objectForKey:@"data"];
                                       ImageNews *returnNews = nil;
                                       if (dataDict) {
                                           returnNews = [[ImageNews alloc]initWithAttributes:dataDict];
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


+ (BOOL)saveImageNews:(ImageNews *)news
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
            //存图片信息
            [db beginTransaction];
            BOOL isRollBack = NO;
            @try {
                for (int i = 0; i<news.imageList.count; i++) {
                    NSString *sql = @"insert into oneImage(contentid,description,thumb) values(?,?,?)";
                    OneImage *img = news.imageList[i];
                    [db executeUpdate:sql,news.contentId,img.description,img.thumb];
                }
            }
            @catch (NSException *exception) {
                isRollBack = YES;
                [db rollback];
            }
            @finally {
                if (!isRollBack) {
                    [db commit];
                }
            }
        }
        [db close];
    }else{
        result = NO;
    }
    return result;
}
@end
