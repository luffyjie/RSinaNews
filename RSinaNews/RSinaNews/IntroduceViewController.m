//
//  IntroduceViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "IntroduceViewController.h"
#import "RootViewController.h"

@interface IntroduceViewController ()

@end

@implementation IntroduceViewController

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
    
    int introCount = 4;
    [self.introScrollView setContentSize:CGSizeMake(self.view.frame.size.width,
                                                    self.view.frame.size.height*introCount)];
    [self.introScrollView setShowsVerticalScrollIndicator:NO];
    
    CGFloat width =self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    //介绍1设置
    NSString *imgName1 = @"introduce_01";
    UIImageView *imgView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgName1]];
    imgView1.frame = CGRectMake(0, 0, width, height);
    imgView1.userInteractionEnabled = YES;
    //开始按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((width-159)/2,
                                                              height-100, 159, 34)];
    [btn setBackgroundImage:[UIImage imageNamed:@"introduce_start"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"introduce_start_hl"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(touchToRoot) forControlEvents:UIControlEventTouchUpInside];

    [imgView1 addSubview:btn];
    [self.introScrollView addSubview:imgView1];
    
    //介绍的2、3设置
    for (int i=2; i<=3; i++) {
        NSString *imgTopName = [NSString stringWithFormat:@"introduce_0%d",i];
        UIImageView *imgTopView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgTopName]];
        imgTopView.frame = CGRectMake(0, height*(i-1),width,height);
        [self.introScrollView addSubview:imgTopView];
    }
    
    //介绍4设置
    UIImageView *lastImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduce_04"]];
    lastImgView.frame = CGRectMake(0, height*(introCount-1),width,height);
    //箭头
    NSString *arrow = @"introduce_arrow";
    UIImageView *imgArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:arrow]];
    imgArrow.frame = CGRectMake((width-12)/2, height-50, 12, 25);
    [lastImgView addSubview:imgArrow];
    [self.introScrollView addSubview:lastImgView];
    
    [self.introScrollView setContentOffset:CGPointMake(0, height*(introCount-1))];
    
    //隐藏状态栏
    [UIView animateWithDuration:0.5 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
    
}
//隐藏方法
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//跳转到主页
- (void)touchToRoot
{
    RootViewController *root = [[RootViewController alloc]init];
    root.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:root animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
