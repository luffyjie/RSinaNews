//
//  RegisterViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-16.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    [self.segmGender setSelectedSegmentIndex:1];
    UITapGestureRecognizer *tapBG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBG)];
    [self.view addGestureRecognizer:tapBG];
    self.textEmail.tag = 1;
    self.textPassword.tag = 2;
    self.textRepassword.tag = 3;
    self.textMphone.tag = 4;
    self.textNickname.tag = 5;
    self.textEmail.delegate = self;
    self.textPassword.delegate = self;
    self.textRepassword.delegate = self;
    self.textMphone.delegate = self;
    self.textNickname.delegate = self;
}
- (void)tapBG
{
    [self.textEmail resignFirstResponder];
    [self.textPassword resignFirstResponder];
    [self.textRepassword resignFirstResponder];
    [self.textMphone resignFirstResponder];
    [self.textNickname resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//取消
- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//注册
- (IBAction)registerClick:(id)sender {
    NSString *email = self.textEmail.text;
    NSString *password = self.textPassword.text;
    NSString *repassword = self.textRepassword.text;
    NSString *mphone = self.textMphone.text;
    NSString *nickname = self.textNickname.text;
    NSNumber *gender = [NSNumber numberWithInteger:self.segmGender.selectedSegmentIndex];
    [self checkEmail:email]; // 检查email
    if (![repassword isEqualToString:password]) {
        [TSMessage showNotificationWithTitle:@"确认密码和密码不相同！" type:TSMessageNotificationTypeError];
        return;
    }
    if ([email isEqualToString:@""] || [password isEqualToString:@""] || [repassword isEqualToString:@""] || [mphone isEqualToString:@""] || [nickname isEqualToString:@""])
    {
        [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"所有选项不能为空!"] type:TSMessageNotificationTypeError];
        return;
    }
    
    NSDictionary *param = @{@"email":email,
                            @"password":password,
                            @"mphone":mphone,
                            @"nickname":nickname,
                            @"gender":gender,
                            };
    [User userRegisterWithParam:param complete:^(User *user, NSError *error) {
        if (user) {
            [Tool loginCache:user];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [TSMessage showNotificationWithTitle:@"注册失败!" type:TSMessageNotificationTypeWarning];
        }
    }];
}

//邮箱验证
- (void)checkEmail:(NSString*)email
{
    NSString *url = [NSString stringWithFormat:@"%@%@",CHECK_EMAIL_URL,email];
    [[APIClient shareClient]GET:url
                     parameters:nil
                        success:^(NSURLSessionDataTask *task, id responseObject) {
                            NSNumber *errorNum = [responseObject objectForKey:@"errorNum"];
                            if ([errorNum  isEqual: @10000]) {
                                [TSMessage showNotificationWithTitle:@"邮箱可用" type:TSMessageNotificationTypeSuccess];
                            }else{
                                [TSMessage showNotificationWithTitle:@"邮箱已被注册" type:TSMessageNotificationTypeWarning];
                            }
    }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            NSLog(@"%@",error);
    }];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
//编写完成
- (void)textFieldDidEndEditing:(UITextField *)textField
{
}
//点击return按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    UITextField *nextField = (UITextField*)[self.view viewWithTag:(textField.tag+1)];
    [nextField becomeFirstResponder];
    return YES;
}


@end
