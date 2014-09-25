//
//  LoginViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-16.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "User.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    UITapGestureRecognizer *tapBG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBG)];
    [self.view addGestureRecognizer:tapBG];
}

- (void)tapBG
{
    [self.textUsername resignFirstResponder];
    [self.textPassword resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//注册按钮
- (IBAction)clickRegister:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

//登录
- (IBAction)clickLogin:(id)sender {
    NSString *username = self.textUsername.text;
    NSString *password = self.textPassword.text;
    //验证
    if ([username isEqualToString:@""]) {
        [TSMessage showNotificationWithTitle:@"请输入登录账号" type:TSMessageNotificationTypeWarning];
        return;
    }
    if ([password isEqualToString:@""]) {
        [TSMessage showNotificationWithTitle:@"请输入登录密码" type:TSMessageNotificationTypeWarning];
        return;
    }
    NSDictionary *param = @{@"mail":username,@"password":password};
    [User userLoginWithParam:param complete:^(User *user, NSError *error) {
        if (user) {
            [Tool loginCache:user];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [TSMessage showNotificationWithTitle:@"用户名或密码错误!" type:TSMessageNotificationTypeWarning];
        }
    }];
}
//取消
- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
