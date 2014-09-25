//
//  SubscribeViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-24.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  订阅控制视图

#import <UIKit/UIKit.h>

@protocol SubscribeViewControllerDelegate <NSObject>

- (void)completeSubscribe;
@end


@interface SubscribeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *subscribeView;//订阅的整个视图
@property (nonatomic, assign) id<SubscribeViewControllerDelegate> delegate;

- (IBAction)finished:(id)sender;//完成按钮
- (IBAction)closeView:(id)sender;//关闭按钮

@property (nonatomic, strong) NSMutableArray *subscribedArray;//已订阅
@property (nonatomic, strong) NSMutableArray *subscribesArray;//未订阅
@end
