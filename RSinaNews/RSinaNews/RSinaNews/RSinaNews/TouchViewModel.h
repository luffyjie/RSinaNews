//
//  TouchViewModel.h
//  ifengNewsOrderDemo
//
//  Created by zer0 on 14-2-27.
//  Copyright (c) 2014年 zer0. All rights reserved.
//  触摸按钮模型

#import <Foundation/Foundation.h>

@interface TouchViewModel : NSObject<NSCoding>

@property (nonatomic,retain) NSString * title;//标题
@property (nonatomic,retain) NSString * urlString;//类型
- (id)initWithTitle:(NSString *)title urlString:(NSString *)urlString;
@end
