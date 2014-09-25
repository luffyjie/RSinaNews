//
//  SubscribeViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-24.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "SubscribeViewController.h"
#import "TouchView.h"
#import "TouchViewModel.h"


@interface SubscribeViewController ()
{
    NSMutableArray *_modelArray1;
    NSMutableArray *_modelArray2;
}
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
    self.subscribedArray = [NSMutableArray array];
    self.subscribesArray = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateSubscribe) name:@"NotificationUpdateSubscribe" object:nil];//对更新界面的观察
}
- (void)clear
{
    [_modelArray1 removeAllObjects];
    [_modelArray2 removeAllObjects];
    [self.subscribesArray removeAllObjects];
    [self.subscribedArray removeAllObjects];
    for (UIView *sub in self.subscribeView.subviews) {
        if ([sub isKindOfClass:[TouchView class]]) {
            [sub removeFromSuperview];
        }
    }
}

//更新视图
- (void)updateSubscribe
{
    [self clear];
    NSString * string = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * filePath = [string stringByAppendingString:@"/modelArray0.swh"];
    NSString * filePath1 = [string stringByAppendingString:@"/modelArray1.swh"];
    _modelArray1 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    _modelArray2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath1];
    
    //已订阅加载
    for (int i = 0; i < _modelArray1.count; i++) {
        
        TouchView *touchView = [[TouchView alloc] initWithFrame:CGRectMake(KTableStartPointX + KButtonWidth * (i%kColumnCount), KTableStartPointY + KButtonHeight * (i/kColumnCount), KButtonWidth, KButtonHeight)];
        [touchView setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0]];
        
        [self.subscribedArray addObject:touchView];
        touchView->_array = self.subscribedArray;
        
        [touchView.label setTextColor:[UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0]];
        
        touchView.label.text = [[_modelArray1 objectAtIndex:i] title];
        [touchView.label setTextAlignment:NSTextAlignmentCenter];
        touchView->_viewArr11 = self.subscribedArray;
        touchView->_viewArr22 = self.subscribesArray;
        [touchView setTouchViewModel:[_modelArray1 objectAtIndex:i]];
        [self.subscribeView addSubview:touchView];
    }
    //未订阅加载
    for (int i = 0; i < _modelArray2.count; i++) {
        
        TouchView *touchView = [[TouchView alloc] initWithFrame:CGRectMake(KTableStartPointX + KButtonWidth * (i%kColumnCount), KTableStartPointY2 + KButtonHeight * (i/kColumnCount), KButtonWidth, KButtonHeight)];
        [touchView setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0]];
        
        [self.subscribesArray addObject:touchView];
        touchView->_array = self.subscribesArray;
        
        [touchView.label setTextColor:[UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0]];
        
        touchView.label.text = [[_modelArray2 objectAtIndex:i] title];
        [touchView.label setTextAlignment:NSTextAlignmentCenter];
        touchView->_viewArr11 = self.subscribedArray;
        touchView->_viewArr22 = self.subscribesArray;
        [touchView setTouchViewModel:[_modelArray2 objectAtIndex:i]];
        [self.subscribeView addSubview:touchView];
    }
}



- (IBAction)finished:(id)sender {
    NSMutableArray *subedArray = [NSMutableArray array];
    NSMutableArray *notSubArray = [NSMutableArray array];
    for (TouchView *tv in self.subscribedArray) {
        [subedArray addObject:tv.touchViewModel];
    }
    for (TouchView *tv in self.subscribesArray) {
        [notSubArray addObject:tv.touchViewModel];
    }
    [Tool setSubscribedChannel:subedArray notSub:notSubArray];//归档
    [self.delegate completeSubscribe];
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
