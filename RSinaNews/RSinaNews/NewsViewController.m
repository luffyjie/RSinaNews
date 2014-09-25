//
//  NewsViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "NewsViewController.h"
#import "SUNViewController.h"
#import "TouchViewModel.h"


@interface NewsViewController ()
{
    NSMutableArray *_tabsArray;//标签栏数组
    UIView *_hideTabView;//隐藏tab用
}
@end

@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"新闻"
                                                       image:[[ImageConstant shareImage]tabNews]
                                               selectedImage:[[ImageConstant shareImage]tabNewsSelected]];
        /********订阅界面设置*********/
        SubscribeViewController *subscribeVC = [[SubscribeViewController alloc]init];
        subscribeVC.delegate = self;
        UIView *subView = subscribeVC.view;
        [subView setFrame:CGRectMake(0, -568, 320, 568)];
        [self.view addSubview:subView];
        [self addChildViewController:subscribeVC];
        /*****************************/
        //加载tabbar的隐藏视图
        _hideTabView = [[UIView alloc]initWithFrame:CGRectMake(0, 568, 320, 58)];
        _hideTabView.backgroundColor = [UIColor darkGrayColor];
        _hideTabView.alpha = 0.5;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    //列表加载
    _tabsArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(closeSubscribe)
                                                name:CLOSE_SUBSCRIBE object:nil];//观察关闭通知
    
    //slide设置，隐藏了44px得topscroll
    self.slideSwitchView = [[SUNSlideSwitchView alloc]initWithFrame:CGRectMake(0, -44, 320, 544)];
    [self.view addSubview:self.slideSwitchView];
    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"bb0b15"];
    
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    //订阅按钮设置
    UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightSideButton addTarget:self action:@selector(showSubscribe) forControlEvents:UIControlEventTouchUpInside];
    [rightSideButton setImage:[UIImage imageNamed:@"slideTab_rightButton"] forState:UIControlStateNormal];
    UIImageView *shadow =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"slidetab_mask"]];
    shadow.frame = CGRectMake(0, 0, 10, 44);
    [rightSideButton addSubview:shadow];
    
    rightSideButton.frame = CGRectMake(0, 0, 44.0f, 44.0f);
    rightSideButton.userInteractionEnabled = YES;
    self.slideSwitchView.rigthSideButton = rightSideButton;
    self.slideSwitchView.slideSwitchViewDelegate = self;
    //把slide的top和rightbutton加到navigationbar上
    self.navigationItem.titleView = self.slideSwitchView.topScrollView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightSideButton];
    [self updateSlideSwitch];
}

//更新slide视图
- (void)updateSlideSwitch
{
    if (_tabsArray.count > 0) {
        [_tabsArray removeAllObjects];
    }
    
    //第一个button为头条不变
    NewsBaseViewController *base = [[NewsBaseViewController alloc]init];
    base.pushDelegate = self;
    base.mode = NewsModelHeadNews;
    base.title = [[[Config share]modelDict]objectForKey:@(NewsModelHeadNews)];
    [_tabsArray addObject:base];
    
    //加载已订阅频道
    NSMutableArray *channels = [Tool getSubscribedChannel];
    for (int i=0; i<channels.count; i++) {
        TouchViewModel *model = [channels objectAtIndex:i];//订阅频道中的单个对象
        NewsBaseViewController *base = [[NewsBaseViewController alloc]init];
        base.pushDelegate = self;
        base.category = [model.urlString intValue];
        base.title = model.title;
        [_tabsArray addObject:base];
    }

    [self.slideSwitchView buildUI];
}

#pragma mark - 滑动tab视图代理方法
- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return _tabsArray.count;
}

- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return _tabsArray[number];
}

- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number
{

}



//显示订阅
- (void)showSubscribe
{
    [self.tabBarController.view addSubview:_hideTabView];
    self.slideSwitchView.frame = CGRectMake(0, 0, 320, 544);//hide Nav时该坐标在变
    SubscribeViewController *subVC = [self.childViewControllers objectAtIndex:0];
    //通知SubscribeViewController更新视图
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationUpdateSubscribe" object:nil];
    [UIView animateWithDuration:SUBSCRIBE_HIDE_T delay:0 options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         self.navigationController.navigationBarHidden = YES;
                         subVC.view.frame = CGRectMake(0, 20, 320, 568);
                         _hideTabView.frame = CGRectMake(0, 519, 320, 58);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
//关闭订阅
- (void)closeSubscribe
{
    self.navigationController.navigationBarHidden = NO;
    self.slideSwitchView.frame = CGRectMake(0, -44, 320, 544); //显示时,又弄出来
    SubscribeViewController *subVC = [self.childViewControllers objectAtIndex:0];
    [UIView animateWithDuration:SUBSCRIBE_HIDE_T delay:0 options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         subVC.view.frame = CGRectMake(0, -568, 320, 568);
                         _hideTabView.frame = CGRectMake(0, 568, 320, 58);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
//push到新闻详细页的方法
- (void)pushToNewsDetail:(NewsDetailViewController *)detailVC
{
    [self.navigationController pushViewController:detailVC animated:YES];
}
//订阅完成,刷新界面
- (void)completeSubscribe
{
    [self updateSlideSwitch];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
