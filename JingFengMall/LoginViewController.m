//
//  LoginViewController.m
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "LoginViewController.h"
#import "PhoneNumberVIew.h"
#import "ForgetPassViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIEdgeInsets edge = UIEdgeInsetsMake(20, 20, 20, 20);
    UIImage *backgroundImage = [[UIImage imageNamed:@"按钮_03"]resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    [self.button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    [self initSet];
    
}

-(void)initSet
{
    self.title = @"登陆";

    self.passWord.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.passWord.secureTextEntry = YES;
    
    self.account.delegate = self;
    self.passWord.delegate = self;
}
//return键被点击
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
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
    if ([self validateMobile:self.account.text] && [self isAllEdited]) {
        NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
        [para setObject:self.account.text forKey:ACCOUNT];
        [para setObject:self.passWord.text forKey:PASSWORD];
        Network *net = [[Network alloc]init];
        [net accessNetUrl:URL_LOGIN parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString *code = [responseObject objectForKey:@"code"];
            if ([code isEqual:@1]) {
                [[NSUserDefaults standardUserDefaults] setObject:self.account.text forKey:@"userPhone"];
                [[NSUserDefaults standardUserDefaults] setObject:self.passWord.text forKey:PASSWORD];
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isUserLogin"];
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                Toast *toast = [Toast makeText:@"账号或密码错误"];
                [toast showWithType:ShortTime];
            }
        }];
    }
}

//判断时候账号密码都已输入
-(BOOL)isAllEdited
{
    BOOL a;
    a = self.passWord.text.length >= 4;
    if (!a)
    {
        Toast *toast = [Toast makeText:@"请填写完整基本信息"];
        [toast showWithType:ShortTime];
    }
    return a;
}

//判断是否是手机号
- (BOOL)validateMobile:(NSString *)mobileNum
{
//       NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    
//   
//    
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    
//    
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    
//   
//    
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    
//   
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
//    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
//        || ([regextestcm evaluateWithObject:mobileNum] == YES)
//        || ([regextestct evaluateWithObject:mobileNum] == YES)
//        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    
    if (mobileNum.length == 11) 
    {
        return YES;
    }else
    {
        Toast *toast = [Toast makeText:@"请输入正确的手机号"];
        [toast showWithType:ShortTime];
        
        return NO;
    }
}

@end
