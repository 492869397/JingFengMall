//
//  DiverLoginViewController.m
//  JingFengMall
//
//  Created by len on 16/1/26.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "DiverLoginViewController.h"
#import "ForgetPassViewController.h"
#import "PhoneNumberVIew.h"
#import "Network.h"


@interface DiverLoginViewController ()

@end

@implementation DiverLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSet];
    self.photo.layer.cornerRadius = 85;
}

-(void)initSet
{
    self.title = @"登陆";
    self.account.keyboardType = UIKeyboardTypeNumberPad;
    self.account.returnKeyType = UIReturnKeyDone;
    self.password.returnKeyType = UIReturnKeyDone;
    
    self.account.delegate = self;
    self.password.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)forgetPassWord:(id)sender {
    ForgetPassViewController *forgetView = [[ForgetPassViewController alloc]init];
    [self.navigationController pushViewController:forgetView animated:YES];
}

- (IBAction)regist:(id)sender {
    PhoneNumberVIew * regist = [[PhoneNumberVIew alloc]init];
    [self.navigationController pushViewController:regist animated:YES];
}

- (IBAction)login:(id)sender {
    if ([self isAllEdited]) {
        NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
        [para setObject:self.account.text forKey:ACCOUNT];
        [para setObject:self.password.text forKey:PASSWORD];
        Network *net = [[Network alloc]init];
        [net accessNetUrl:URL_LOGIN parameters:(id)para success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"code"] isEqual:@1]) {
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:self.account.text forKey:ACCOUNT];
                [user setObject:self.password.text forKey:PASSWORD];
                [user setBool:YES forKey:@"isUserLogin"];
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"登陆失败" message:@"账号密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alter show];
            }
        }];
    }else{
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写正确的账号密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
    }
    
}

//判断时候账号密码都已输入
-(BOOL)isAllEdited
{
    BOOL a,b;
    a = self.account.text.length == 11;
    b = self.password.text.length >= 4;
    return a && b;
}

@end

