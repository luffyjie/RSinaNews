//
//  VideoNewsCell.m
//  RSinaNews
//
//  Created by TY on 14-6-19.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "VideoNewsCell.h"

@implementation VideoNewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)play:(id)sender {
}
@end
