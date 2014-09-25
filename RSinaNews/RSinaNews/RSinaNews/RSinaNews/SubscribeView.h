//
//  SubscribeView.h
//  RSinaNews
//
//  Created by TY on 14-6-6.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  订阅页

#import <UIKit/UIKit.h>
#import "SUNSlideSwitchView.h"

@interface SubscribeView : UIView

@property (nonatomic, strong) SUNSlideSwitchView *slideView;

@property (weak, nonatomic) IBOutlet UIScrollView *subscribeScrollView;//订阅的滑动视图

@property (weak, nonatomic) IBOutlet UIView *subscribedView;//已经订阅的
@property (weak, nonatomic) IBOutlet UIView *subscribesView;//可以添加的

- (IBAction)finished:(id)sender;//完成按钮
- (IBAction)closeView:(id)sender;//关闭按钮

@property (nonatomic, strong) NSMutableArray *subscribedArray;//已订阅
@property (nonatomic, strong) NSMutableArray *notSubscribedArray;//未订阅
@end
