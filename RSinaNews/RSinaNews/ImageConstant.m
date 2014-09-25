//
//  ImageConstant.m
//  RSinaNews
//
//  Created by TY on 14-6-13.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "ImageConstant.h"

@implementation ImageConstant


+ (instancetype)shareImage
{
    static ImageConstant *menu = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        menu = [[ImageConstant alloc]init];
        
        menu.tabNews = [[UIImage imageNamed:@"tabbar_news"]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.tabNewsSelected = [[UIImage imageNamed:@"tabbar_news_hl"]
                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        menu.tabImageNews = [[UIImage imageNamed:@"tabbar_picture"]
                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.tabImageNewsSelected = [[UIImage imageNamed:@"tabbar_picture_hl"]
                                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        menu.tabVideoNews = [[UIImage imageNamed:@"tabbar_video"]
                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.tabVideoNewsSelected = [[UIImage imageNamed:@"tabbar_video_hl"]
                                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        menu.tabSetting = [[UIImage imageNamed:@"tabbar_setting"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.tabSettingSelected = [[UIImage imageNamed:@"tabbar_setting_hl"]
                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //占位图
        menu.placeholderBig = [[UIImage imageNamed:@"feed_focus"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.placeholderCell = [[UIImage imageNamed:@"feed_Groupgraph"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //nav
        //红色的
        menu.navBack = [[UIImage imageNamed:@"navigationbar_back_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.navLikeNormal = [[UIImage imageNamed:@"navigationBarItem_like_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.navLikeSelected = [[UIImage imageNamed:@"navigationBarItem_liked_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.navFavoriteNormal = [[UIImage imageNamed:@"navigationBarItem_favorite_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.navFavoriteSelected = [[UIImage imageNamed:@"navigationBarItem_favorited_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.navShareNormal = [[UIImage imageNamed:@"navigationbar_share_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //白色的
        menu.navBackWhite = [[UIImage imageNamed:@"navigationbar_pic_back_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.navLikeNormalWhite = [[UIImage imageNamed:@"navigationBarItem_like_normal_PB"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.navLikeSelectedWhite = [[UIImage imageNamed:@"navigationBarItem_liked_normal_PB"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.navFavoriteNormalWhite = [[UIImage imageNamed:@"navigationBarItem_favorite_normal_PB"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.navFavoriteSelectedWhite = [[UIImage imageNamed:@"navigationBarItem_favorited_normal_PB"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        menu.navShareNormalWhite = [[UIImage imageNamed:@"navigationbar_pic_share_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //toolbar
        menu.commentNormal = [[UIImage imageNamed:@"comment_toolbar_comment"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //setting
        menu.weatherBgSun = [UIImage imageNamed:@"UseCenterWeatherBGSunny"];
        menu.weatherBgSnow = [UIImage imageNamed:@"UseCenterWeatherBGSnow"];
        menu.weatherBgRain = [UIImage imageNamed:@"UseCenterWeatherBGRain"];
        menu.weatherBgWind = [UIImage imageNamed:@"UseCenterWeatherBGWind"];
        menu.weatherBgHaz = [UIImage imageNamed:@"UseCenterWeatherBGHaz"];
        menu.weatherBgCloudy = [UIImage imageNamed:@"UseCenterWeatherBGCloudy"];
        
    });
    return menu;
}

@end
