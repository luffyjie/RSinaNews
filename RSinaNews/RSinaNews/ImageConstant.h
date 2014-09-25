//
//  ImageConstant.h
//  RSinaNews
//
//  Created by TY on 14-6-13.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  图片常量

#import <Foundation/Foundation.h>

@interface ImageConstant : NSObject


+ (instancetype)shareImage;
//tab图片
@property (nonatomic, strong) UIImage *tabNews;
@property (nonatomic, strong) UIImage *tabNewsSelected;

@property (nonatomic, strong) UIImage *tabImageNews;
@property (nonatomic, strong) UIImage *tabImageNewsSelected;

@property (nonatomic, strong) UIImage *tabVideoNews;
@property (nonatomic, strong) UIImage *tabVideoNewsSelected;

@property (nonatomic, strong) UIImage *tabSetting;
@property (nonatomic, strong) UIImage *tabSettingSelected;

//占位图片
@property (nonatomic, strong) UIImage *placeholderBig;//占位大图
@property (nonatomic, strong) UIImage *placeholderCell;//tableCell占位图

//红色版
@property (nonatomic, strong) UIImage *navBack;//返回

@property (nonatomic, strong) UIImage *navLikeNormal; //桃心
@property (nonatomic, strong) UIImage *navLikeSelected;

@property (nonatomic, strong) UIImage *navFavoriteNormal;//五角星
@property (nonatomic, strong) UIImage *navFavoriteSelected;

@property (nonatomic, strong) UIImage *navShareNormal;//转发

//白色版
@property (nonatomic, strong) UIImage *navBackWhite;//返回

@property (nonatomic, strong) UIImage *navLikeNormalWhite; //桃心
@property (nonatomic, strong) UIImage *navLikeSelectedWhite;

@property (nonatomic, strong) UIImage *navFavoriteNormalWhite;//五角星
@property (nonatomic, strong) UIImage *navFavoriteSelectedWhite;

@property (nonatomic, strong) UIImage *navShareNormalWhite;//转发

@property (nonatomic, strong) UIImage *commentNormal;//评论

//setting
@property (nonatomic, strong) UIImage *weatherBgSun;
@property (nonatomic, strong) UIImage *weatherBgSnow;
@property (nonatomic, strong) UIImage *weatherBgCloudy;
@property (nonatomic, strong) UIImage *weatherBgHaz;
@property (nonatomic, strong) UIImage *weatherBgRain;
@property (nonatomic, strong) UIImage *weatherBgWind;

@end
