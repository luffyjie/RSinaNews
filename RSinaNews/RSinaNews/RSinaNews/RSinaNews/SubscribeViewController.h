//
//  SubscribeViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-24.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  订阅控制视图

#import <UIKit/UIKit.h>
#import "SUNSlideSwitchView.h"

@interface SubscribeViewController : UIViewController
@property (nonatomic, strong) SUNSlideSwitchView *slideView;

@property (weak, nonatomic) IBOutlet UIView *subscribedView;//已经订阅的
@property (weak, nonatomic) IBOutlet UIView *subscribesView;//可以添加的

- (IBAction)finished:(id)sender;//完成按钮
- (IBAction)closeView:(id)sender;//关闭按钮

@property (nonatomic, strong) NSMutableArray *subscribedArray;//已订阅
@property (nonatomic, strong) NSMutableArray *subscribesArray;//未订阅
@end
