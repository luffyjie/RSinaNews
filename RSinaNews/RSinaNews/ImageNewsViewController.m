//
//  ImageNewsViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "ImageNewsViewController.h"

@interface ImageNewsViewController ()
{
    NSMutableArray *_tabsArray;//标签栏数组
}
@end

@implementation ImageNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor blackColor];
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"图片"
                                                       image:[[ImageConstant shareImage]tabImageNews]
                                               selectedImage:[[ImageConstant shareImage]tabImageNewsSelected]];
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
    [self updateSlideSwitch];
}

//更新slide视图
- (void)updateSlideSwitch
{
    if (_tabsArray.count > 0) {
        [_tabsArray removeAllObjects];
    }
    NSArray *titleArray = @[@"精选",@"趣图",@"美图",@"故事"];
    for (int i=0; i<4; i++) {
        ImageNewsBaseViewController *base = [[ImageNewsBaseViewController alloc]init];
        base.pushDelegate = self;
        base.mode = NewsModelImages;
        base.category = i+1;
        base.title = titleArray[i];
        [_tabsArray addObject:base];
    }
    
    
    //slide设置，隐藏了44px得topscroll
    self.slideSwitchView = [[SUNSlideSwitchView alloc]initWithFrame:CGRectMake(0, -44, 320, 544)];
    [self.view addSubview:self.slideSwitchView];
    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"bb0b15"];
    
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    self.slideSwitchView.slideSwitchViewDelegate = self;
    self.slideSwitchView.topScrollView.frame = CGRectMake(0, 0, 200, 44);
    [self.slideSwitchView buildUI];
    
    //    [self.navigationController.view addSubview:self.slideSwitchView];
    
    //把slide的top和rightbutton加到navigationbar上
    self.navigationItem.titleView = self.slideSwitchView.topScrollView;
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

//push到新闻详细页的方法
- (void)pushToImageDetail:(ImageNewsDetailViewController *)detailVC
{
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
