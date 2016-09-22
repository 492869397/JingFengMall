//
//  ForgetPassViewController.m
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "ForgetPassViewController.h"
#import "ChangeViewController.h"
#import "CIA_SDK/CIA_SDK.h"

@interface ForgetPassViewController ()

@end

@implementation ForgetPassViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"忘记密码";
    
    self.pass = [[NSMutableDictionary alloc]init];
    
    self.account.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (IBAction)confirm:(id)sender {
    [self.pass setObject:self.account.text forKey:ACCOUNT];
    
//    ChangeViewController *change = [[ChangeViewController alloc]init];
//    change.account = self.account.text;
//    [self.navigationController pushViewController:change animated:YES];
//#warning 接触注释,并删除上面的测试代码
        [self doCIA];
    
    Toast *toast = [Toast makeText:@"正在验证手机号,请稍等"];
    [toast showWithType:ShortTime];
    
    [self.view endEditing:YES];
}

#pragma 验证手机号
//进行cia验证,获取验证码
-(void)doCIA
{
    UIButton *button = [self.view viewWithTag:50];
    [button setEnabled:NO];
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    [activity setCenter:CGPointMake(kMainScreenWidth/2.0, kMainScreenHeight/2.0)];//指定进度轮中心点
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];//设置进度轮显示类型
    [self.view addSubview:activity];
    [activity startAnimating];
    
    if ([self validateMobile:self.account.text]) {
        [CIA startVerificationWithPhoneNumber:self.account.text callback:^(NSInteger code, NSString *msg, NSError *err) {
            
            [activity stopAnimating];
            [activity removeFromSuperview];
            UIButton *button = [self.view viewWithTag:50];
            [button setEnabled:YES];
            
            if (code == 100) {
                [self commitPhoneNumber];
            }else if (code == 101)
            {
                [self doCIABySelf];
            }
            
        }];
    }else
    {
        Toast *toast = [Toast makeText:@"请输入正确的手机号"];
        [toast showWithType:ShortTime];
    }
}

-(void)doCIABySelf
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"输入验证码" message:@"请输入刚刚呼入的手机号后四位" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入验证码";
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *verify = alertController.textFields.firstObject;
        [CIA verifySecurityCode:verify.text callback:^(NSInteger code, NSString *msg, NSString *transId, NSError *err) {
            if (code == 100) {
                [self commitPhoneNumber];
            }else if (code == 102)
            {
                Toast *toast = [Toast makeText:@"验证码错误"];
                [toast showWithType:ShortTime];
            }else
            {
                Toast *toast = [Toast makeText:@"验证码已过期"];
                [toast showWithType:ShortTime];
            }
        }];
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)commitPhoneNumber
{
    Network *net = [[Network alloc]init];
    [net accessNetUrl:URL_ISEXIT parameters:self.pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInteger:1]]) {
            [self.pass setObject:self.account.text forKey:ACCOUNT];
            ChangeViewController *change = [[ChangeViewController alloc]init];
            change.account = self.account.text;
            [self.navigationController pushViewController:change animated:YES];
        }else{
            Toast *toast = [Toast makeText:@"该账户已存在"];
            [toast showWithType:ShortTime];
        }
    }];
}

//判断是否是手机号
- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }else
    {
        Toast *toast = [Toast makeText:@"请填写正确的手机号"];
        [toast showWithType:ShortTime];
        return NO;
    }
}

@end


