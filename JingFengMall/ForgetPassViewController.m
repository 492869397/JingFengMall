//
//  ForgetPassViewController.m
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "ForgetPassViewController.h"
#import "ChangeViewController.h"


@interface ForgetPassViewController ()

@end

@implementation ForgetPassViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"修改密码";
    
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
        if ([[responseObject objectForKey:@"code"] isEqualToNumber:@1]) {
            
            ChangeViewController *change = [[ChangeViewController alloc]init];
            change.account = self.Account.text;
            [self.navigationController pushViewController:change animated:YES];
        }else{
            Toast *toast = [Toast makeText:@"该账户不存在"];
            [toast showWithType:ShortTime];
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


