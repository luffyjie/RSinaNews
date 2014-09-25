//
//  CommentCell.h
//  RSinaNews
//
//  Created by TY on 14-6-25.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  评论cell

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
@property (strong, nonatomic) UIImageView *imgMask;//头像框
@property (strong, nonatomic) UIImageView *imgDefault;//默认头像

@property (strong, nonatomic) UIView *centerView;//中间视图
@property (strong, nonatomic) UILabel *lblNickName;//昵称
@property (strong, nonatomic) UILabel *lblPubTime;//发布时间
@property (strong, nonatomic) UITextView *textContent;//评论内容
@property (strong, nonatomic) UILabel *lblSupport;//赞数
@property (strong, nonatomic) UILabel *lblReply;//回复
@property (strong, nonatomic) UIImageView *imgSupport;
@property (strong, nonatomic) UIImageView *imgReply;




@end
