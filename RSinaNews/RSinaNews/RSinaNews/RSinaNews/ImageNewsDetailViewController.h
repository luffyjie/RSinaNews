//
//  ImageNewsDetailViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-18.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  图片新闻详情

#import <UIKit/UIKit.h>
#import "ImageNews.h"
#import "OneImage.h"

@interface ImageNewsDetailViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic, strong) ImageNews *news;
@property(nonatomic, strong) ImageNews *newsDetail;

@property (weak, nonatomic) IBOutlet UIScrollView *imgScrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentPage;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPage;
@property (weak, nonatomic) IBOutlet UITextView *textDescripte;
@property (weak, nonatomic) IBOutlet UITextField *textFieldComment;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentCount;

@property (weak, nonatomic) IBOutlet UIView *commentView;


@end
