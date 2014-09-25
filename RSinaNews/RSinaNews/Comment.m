//
//  Comment.m
//  RSinaNews
//
//  Created by TY on 14-6-10.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "Comment.h"

@implementation Comment

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    if (self = [super init]) {
        self.ip = [attributes objectForKey:@"IP"];
        self.nickName = [attributes objectForKey:@"NickName"];
        self.longitude = [attributes objectForKey:@"Longitude"];
        self.latitude = [attributes objectForKey:@"Latitude"];
        self.drId = [attributes objectForKey:@"DrId"];
        self.stfId = [attributes objectForKey:@"StfId"];
        self.contentId = [attributes objectForKey:@"ContentId"];
        self.published = [attributes objectForKey:@"Published"];
        self.content = [attributes objectForKey:@"Content"];
        
        self.published = [self.published substringWithRange:NSMakeRange(0, 10)];
        
        UITextView *txt = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 240, 53)];
        txt.text = self.content;
        txt.font = [UIFont systemFontOfSize:14];
        self.height = [Tool contentSizeOfTextView:txt].height;
    }
    return self;
}

+ (NSURLSessionDataTask *)commentListWithContentId:(NSNumber*)contentId complete:(void (^)(NSArray *, NSError *))block
{
    NSString *url = [NSString stringWithFormat:@"%@?contentid=%@",BASE_COMMENT_LIST_URL,contentId];
    return [[APIClient shareClient]GET:url parameters:nil
                               success:^(NSURLSessionDataTask *task, id responseObject) {
                                   NSString *errorMsg = [responseObject objectForKey:@"errorMsg"];
                                   if ([errorMsg isEqualToString:@"success"]) {//请求成功
                                       NSArray *dataArray = [responseObject objectForKey:@"data"];
                                       NSMutableArray *returnArray = [[NSMutableArray alloc]initWithCapacity:dataArray.count];
                                       for (NSDictionary *dict in dataArray) {
                                           Comment *c = [[Comment alloc]initWithAttributes:dict];
                                           [returnArray addObject:c];
                                       }
                                       if (block) {
                                           block([NSArray arrayWithArray:returnArray],nil);
                                       }
                                   }else{
                                       block(nil,nil);
                                   }
    }
                               failure:^(NSURLSessionDataTask *task, NSError *error) {
                                   NSLog(@"comment error:%@",error);
                                   [TSMessage showNotificationWithTitle:@"网络不给力" type:TSMessageNotificationTypeWarning];
    }];
}
@end
