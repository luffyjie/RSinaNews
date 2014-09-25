//
//  TouchView.h
//  TouchDemo
//
//  Created by Zer0 on 13-10-11.
//  Copyright (c) 2013年 Zer0. All rights reserved.
//  触摸按钮

#import <UIKit/UIKit.h>
@class TouchViewModel;
@interface TouchView : UIImageView
{
    CGPoint _point;//自己的坐标
    CGPoint _point2;//父视图坐标
    NSInteger _sign;//标志是移动还是点击、0表示点击、1表示移动
    @public
    
    NSMutableArray * _array;//当前array
    NSMutableArray * _viewArr11;//已订阅array
    NSMutableArray * _viewArr22;//未订阅array
}
@property (nonatomic,retain) UILabel * label;//标题
@property (nonatomic,retain) UILabel * moreChannelsLabel;//更多
@property (nonatomic,retain) TouchViewModel * touchViewModel;//触摸对象的属性
@end
