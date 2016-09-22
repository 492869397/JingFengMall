//
//  PhoneNumberVIew.m
//  JingFengMall
//
//  Created by len on 16/1/25.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "PhoneNumberVIew.h"
#import "registViewController.h"


@implementation PhoneNumberVIew

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"注册";
    
    UIEdgeInsets edge = UIEdgeInsetsMake(20, 20, 20, 20);
    UIImage *backgroundImage = [[UIImage imageNamed:@"按钮_03"]resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    [self.button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    self.Account.delegate = self;
    self.verify.delegate = self;
    self.vetifyButton.titleLabel.adjustsFontSizeToFitWidth = YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (IBAction)confirm:(id)sender {
    if ([self isAllFillOut]) {
        [self commitPhoneNumber];
    }
}

-(BOOL)isAllFillOut
{
    if ([self isVerifyTrue] && [self validateMobile:self.Account.text]) {
        return YES;
    }
    return NO;
}

- (IBAction)getVerify:(id)sender {
    if ([self validateMobile:self.Account.text]) {
        
        [self getVerifyFromNet];
        [_vetifyButton setEnabled:NO];
        self.time = 60;
        [_vetifyButton setTitle:@"60s后重试" forState:UIControlStateDisabled];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(buttonTimeLimit) userInfo:nil repeats:YES];
    }
}

-(void)buttonTimeLimit
{
    self.time -= 1;
    if (self.time <= 0) {
        [self.vetifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_vetifyButton setEnabled:YES];
        self.time = 60;
    }else
    {
        [self.vetifyButton setTitle:[NSString stringWithFormat:@"%lds后重试",(long)self.time] forState:UIControlStateDisabled];
    }
}

-(void)getVerifyFromNet
{
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:self.Account.text forKey:@"recNum"];
    [net accessNetUrl:URL_SMS parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            self.code = [responseObject objectForKey:@"msg"];
        }else
        {
            Toast *toast = [Toast makeText:@"操作过于频繁,请稍后再试"];
            [toast showWithType:ShortTime];
        }
    }];
}


-(void)commitPhoneNumber
{
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:self.Account.text forKey:ACCOUNT];
    [net accessNetUrl:URL_ISEXIT parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInteger:1]]) {
            Toast *toast = [Toast makeText:@"该账户名已存在"];
            [toast showWithType:ShortTime];
        }else{
            registViewController *regist = [[registViewController alloc]init];
            regist.account = self.Account.text;
            [self.navigationController pushViewController:regist animated:YES];
        }
    }];
}

//判断验证码是否输入正确
-(BOOL)isVerifyTrue
{
    if ([self.verify.text isEqualToString:[NSString stringWithFormat:@"%@",self.code]]) {
        return YES;
    }
    Toast *toast = [Toast makeText:@"验证码错误"];
    [toast showWithType:ShortTime];
    return NO;
}

//判断是否是手机号
- (BOOL)validateMobile:(NSString *)mobileNum
{
    
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//   
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
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
        Toast *toast = [Toast makeText:@"请输入正确的手机号码"];
        [toast showWithType:ShortTime];
        
        return NO;
    }
}
@end
