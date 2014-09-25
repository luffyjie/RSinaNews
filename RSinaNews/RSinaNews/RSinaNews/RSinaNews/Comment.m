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
        
    }
    return self;
}

+ (NSURLSessionDataTask *)commentListWithContentId:(NSInteger)contentId complete:(void (^)(NSArray *, NSError *))block
{
    return nil;
}
@end
