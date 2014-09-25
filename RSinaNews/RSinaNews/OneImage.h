//
//  OneImage.h
//  RSinaNews
//
//  Created by TY on 14-6-18.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  一张图片的信息

#import <Foundation/Foundation.h>

@interface OneImage : NSObject

@property (nonatomic, assign) NSNumber *contentId;  //内容id
@property (nonatomic, strong) NSString *description;//描述
@property (nonatomic, strong) NSString *thumb;//图片地址
@property (nonatomic, strong) NSURL *frURL;     //网络地址


- (instancetype)initWithAttributes:(NSDictionary *)attributes;
@end
