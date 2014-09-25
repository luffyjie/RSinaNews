//
//  SubscribeView.m
//  RSinaNews
//
//  Created by TY on 14-6-6.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "SubscribeView.h"

@implementation SubscribeView

- (IBAction)finished:(id)sender {
//    @"channelDashedbox";
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
