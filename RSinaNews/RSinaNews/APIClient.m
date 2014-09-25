//
//  APIClient.m
//  RSinaNews
//
//  Created by TY on 14-6-11.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "APIClient.h"

static NSString * const kBaseURLString = @"http://192.168.0.43:8080/WebServices/";

@implementation APIClient

+ (instancetype)shareClient
{
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _sharedClient = [[APIClient alloc]initWithBaseURL:[NSURL URLWithString:kBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    });
    return _sharedClient;
}
@end
