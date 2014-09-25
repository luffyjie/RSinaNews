//
//  SubscribeViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-24.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "SubscribeViewController.h"

@interface SubscribeViewController ()

@end

@implementation SubscribeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
}


//加载订阅
- (void)loadSubscribes
{
    
}

- (IBAction)finished:(id)sender {
    //    @"channelDashedbox";虚线背景
    [self close];
}
- (IBAction)closeView:(id)sender {
    [self close];
}

- (void)close
{
    //通知NewsViewController调用closeSubscribe
    [[NSNotificationCenter defaultCenter]postNotificationName:CLOSE_SUBSCRIBE object:nil];
}


@end
