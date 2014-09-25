//
//  OneImage.m
//  RSinaNews
//
//  Created by TY on 14-6-18.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "OneImage.h"

@implementation OneImage

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    if (self = [super init]) {
        self.contentId = [attributes objectForKey:@"ContentId"];
        self.description = [attributes objectForKey:@"Description"];
        self.thumb = [BASE_IMAGE_URL stringByAppendingString:[attributes objectForKey:@"FrURL"]];
        self.frURL = [NSURL URLWithString:[BASE_IMAGE_URL stringByAppendingString:[attributes objectForKey:@"FrURL"]]];
    }
    return self;
}

@end
