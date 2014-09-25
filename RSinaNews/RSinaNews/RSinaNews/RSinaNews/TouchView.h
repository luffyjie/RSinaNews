//
//  TouchView.h
//  TouchDemo
//
//  Created by Zer0 on 13-10-11.
//  Copyright (c) 2013年 Zer0. All rights reserved.
//  触摸按钮
#define KOrderButtonFrameOriginX 257.0
#define KOrderButtonFrameOriginY 20
#define KOrderButtonFrameSizeX 63
#define KOrderButtonFrameSizeY 45
//以上是OrderButton的frame值
#define KOrderButtonImage @"topnav_orderbutton.png"
#define KOrderButtonImageSelected @"topnav_orderbutton_selected_unselected.png"
//以上是OrderButton的背景图片
#define KDefaultCountOfUpsideList 5
//默认订阅频道数
#define KTableStartPointX 10
#define KTableStartPointY 60
//已订阅的按钮起始的位置
#define KButtonWidth 92
#define KButtonHeight 30
//按钮的大小
#import <UIKit/UIKit.h>
@class TouchViewModel;
@interface TouchView : UIImageView
{
    CGPoint _point;//自己的坐标
    CGPoint _point2;//父视图坐标
    NSInteger _sign;
    @public
    
    NSMutableArray * _array;//当前array
    NSMutableArray * _viewArr11;//已订阅array
    NSMutableArray * _viewArr22;//未订阅array
}
@property (nonatomic,retain) UILabel * label;//标题
@property (nonatomic,retain) UILabel * moreChannelsLabel;//更多
@property (nonatomic,retain) TouchViewModel * touchViewModel;//触摸对象的属性
@end
