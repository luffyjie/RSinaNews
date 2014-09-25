//
//  CommentCell.m
//  RSinaNews
//
//  Created by TY on 14-6-25.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        self.imgDefault = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment_cell_icon_default_large.png"]];
        self.imgDefault.frame = CGRectMake(13, 5, 33, 33);
        self.imgMask = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment_cell_icon_mask_large.png"]];
        self.imgMask.frame = CGRectMake(13, 5, 33, 33);
        
        //中间视图
        self.centerView = [[UIView alloc]initWithFrame:CGRectMake(28, 13, 277, 114)];
        self.centerView.backgroundColor = [UIColor colorWithRed:234/255.0 green:244/255.0 blue:254/255.0 alpha:1];
        
        self.lblNickName = [[UILabel alloc]initWithFrame:CGRectMake(20, 9, 111, 17)];
        self.lblNickName.text = @"手机用户";
        self.lblNickName.font = [UIFont systemFontOfSize:12];
        self.lblNickName.textColor = [UIColor lightGrayColor];
        
        self.lblPubTime = [[UILabel alloc]initWithFrame:CGRectMake(180, 9, 77, 21)];
        self.lblPubTime.text = @"2分钟前";
        self.lblPubTime.font = [UIFont systemFontOfSize:12];
        self.lblPubTime.textAlignment = NSTextAlignmentRight;
        self.lblPubTime.textColor = [UIColor lightGrayColor];
        
        self.textContent = [[UITextView alloc]initWithFrame:CGRectMake(20, 29, 242, 53)];
        self.textContent.backgroundColor = [UIColor clearColor];
        self.textContent.editable = NO;
        self.textContent.selectable = NO;
        self.textContent.font = [UIFont systemFontOfSize:14];
        
        self.imgSupport = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment_cell_support.png"]];
        self.imgSupport.frame = CGRectMake(176, 93, 12, 12);
        
        self.lblSupport = [[UILabel alloc]initWithFrame:CGRectMake(191, 90, 18, 17)];
        self.lblSupport.text = @"20";
        self.lblSupport.font = [UIFont systemFontOfSize:10];
        self.lblSupport.textColor = [UIColor lightGrayColor];
        
        self.imgReply = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment_cell_reply.png"]];
        self.imgReply.frame = CGRectMake(224, 94, 12, 12);
        
        self.lblReply = [[UILabel alloc]initWithFrame:CGRectMake(242, 90, 20, 18)];
        self.lblReply.text = @"回复";
        self.lblReply.font = [UIFont systemFontOfSize:10];
        self.lblReply.textColor = [UIColor lightGrayColor];
        
        [self.centerView addSubview:self.lblNickName];
        [self.centerView addSubview:self.lblPubTime];
        [self.centerView addSubview:self.textContent];
        [self.centerView addSubview:self.imgSupport];
        [self.centerView addSubview:self.lblSupport];
        [self.centerView addSubview:self.imgReply];
        [self.centerView addSubview:self.lblReply];
        [self addSubview:self.centerView];
        
        [self addSubview:self.imgDefault];
        [self addSubview:self.imgMask];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
