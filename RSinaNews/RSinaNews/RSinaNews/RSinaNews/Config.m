//
//  Config.m
//  RSinaNews
//
//  Created by TY on 14-6-9.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "Config.h"

@implementation Config

+ (instancetype)share
{
    static Config *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[Config alloc]init];
        config.categoryDict = @{@1:@"财经",
                                @2:@"科技",
                                @3:@"军事",
                                @4:@"数码",
                                @5:@"手机",
                                @6:@"移动互联网",
                                @7:@"国际",
                                @8:@"国内",
                                @9:@"探索",
                                @10:@"深度",
                                @11:@"汽车",
                                @12:@"房产"};
        
        config.modelDict = @{@1:@"文本",
                             @2:@"组图",
                             @3:@"链接",
                             @4:@"视频",
                             @5:@"访谈",
                             @6:@"头条",
                             @7:@"活动",
                             @8:@"投票",
                             @9:@"调查",
                             @10:@"专题",
                             @11:@"爆料"};
    });
    return config;
}

@end
